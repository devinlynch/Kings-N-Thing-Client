//
//  Player.m
//  3004iPhone
//
//  Created by John Marsh on 1/15/2014.
//
//

#import "Player.h"
#import "Rack.h"
#import "User.h"
#import "Creature.h"
#import "Game.h"
#import "GameState.h"
#import "HexLocation.h"
#import "HexTile.h"
#import "Terrain.h"
#import "SpecialCharacter.h"
#import "RandomEvent.h"

@implementation Player

@synthesize user = _user;
@synthesize rack1 = _rack1;
@synthesize playerId = _playerId;
@synthesize gamePieces = _gamePieces;
@synthesize username = _username;


-(id<JSONSerializable>)initFromJSON:(NSDictionary*) json{
    self=[super init];
    if(self && json != nil) {
        _gamePieces = [[NSMutableDictionary alloc] init];
         _user = [[User alloc] initFromJSON:json];
        _username = [[NSString alloc] initWithString:[json objectForKey:@"username"]];
        _playerId   = [[NSString alloc] initWithString:[json objectForKey:@"playerId"]];
        [self setGold: [[json objectForKey:@"gold"] intValue]];
        _rack1 = [[Rack alloc] initFromJSON:[json objectForKey:@"rack1"] withOwner:self];
    }
    return self;
}

-(void) addGold: (int) g{
    NSLog(@"%@ had %d gold", _username, _gold);
    [self setGold:_gold + g];
    NSLog(@"%@ now has %d gold", _username, _gold);
}

-(void) assignPiece: (GamePiece*) gamePiece{
    Player *previousOwner = gamePiece.owner;
    if(previousOwner != nil && ![previousOwner isKindOfClass:[NSNull class]]) {
        [previousOwner.gamePieces removeObjectForKey:gamePiece.gamePieceId];
    }
   
    [gamePiece changeOwnerToPlayer:self];
    
    [self.gamePieces setObject:gamePiece forKey:gamePiece.gamePieceId];
}

-(void) updateFromSerializedJson: (NSDictionary*) json{
    if(json == nil || ! [json isKindOfClass:[NSDictionary class]])
        return;
                      
    if([json objectForKey:@"username"] != nil) {
        _username = [[NSString alloc] initWithString:[json objectForKey:@"username"]];
    }
    
    if([json objectForKey:@"playerId"] != nil) {
        _playerId   = [[NSString alloc] initWithString:[json objectForKey:@"playerId"]];
    }
    
    if([json objectForKey:@"gold"] != nil) {
        [self setGold: [[json objectForKey:@"gold"] intValue]];
    }
    
    BOOL didCreateRack1 =YES ;
    
    if(_rack1 == nil && [json objectForKey:@"rack1"] != nil){
        didCreateRack1=YES;
        _rack1 = [[Rack alloc] initFromJSON:[json objectForKey:@"rack1"] withOwner:self];
    }
    
    
    if(!didCreateRack1 && _rack1 != nil && [json objectForKey:@"rack1"] != nil) {
        [_rack1 updateLocationFromSerializedJSONDictionary:[json objectForKey:@"rack1"]];
    }
    
}

-(int) gold{
    return _gold;
}

-(void) setGold: (int) g{
    _gold = g;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"playerGoldChanged" object:self];
}


-(BOOL) canSupportCreature:(Creature *)creature atLocation:(HexLocation *)hexLocation{
    
    if(![creature isKindOfClass:[Creature class]]){
        return YES;
    }
    
    //Check if player has a supporting hex
    for (NSString *locationKey in [[[Game currentGame] gameState] hexLocations]) {
        HexLocation *location = [[[[Game currentGame] gameState] hexLocations] objectForKeyedSubscript:locationKey];
        if ([[location owner] isEqual:self]) {
            if ([location.tile.terrain isEqual:creature.terrain]) {
                return YES;
            }
        }
    }
    
    //Check if player has a terrain lord at this location
    for(NSString *pieceKey in [hexLocation pieces]){
        GamePiece *piece = [[hexLocation pieces] objectForKey:pieceKey];
        if ([piece isKindOfClass:[SpecialCharacter class]]) {
            if ([piece.owner isEqual:self]) {
                if ([piece.gamePieceId isEqualToString:@"specialcharacter_12"]) {
                    return [creature.terrain isEqual:[Terrain getDesertInstance]];
                } else if ([piece.gamePieceId isEqualToString:@"specialcharacter_13"]) {
                    return [creature.terrain isEqual:[Terrain getFrozenInstance]];
                } else if ([piece.gamePieceId isEqualToString:@"specialcharacter_14"]) {
                    return [creature.terrain isEqual:[Terrain getJungleInstance]];
                } else if ([piece.gamePieceId isEqualToString:@"specialcharacter_15"]) {
                    return [creature.terrain isEqual:[Terrain getForestInstance]];
                } else if ([piece.gamePieceId isEqualToString:@"specialcharacter_16"]) {
                    return [creature.terrain isEqual:[Terrain getPlainesInstance]];
                } else if ([piece.gamePieceId isEqualToString:@"specialcharacter_17"]) {
                    return [creature.terrain isEqual:[Terrain getMountainInstance]];
                } else if ([piece.gamePieceId isEqualToString:@"specialcharacter_18"]) {
                    return [creature.terrain isEqual:[Terrain getSwampInstance]];
                }
            }
        }
    }
    
    return NO;
}

-(NSArray*) getRandomEvents{
    NSMutableArray *events = [[NSMutableArray alloc] init];
    
    NSEnumerator *enumerator = [_gamePieces keyEnumerator];
    id key;
    while ((key = [enumerator nextObject])) {
        GamePiece *gp = [_gamePieces objectForKey:key];
        if([gp isKindOfClass:[RandomEvent class]]) {
            [events addObject:(RandomEvent*)gp];
        }
    }
    
    return events;
}

@end