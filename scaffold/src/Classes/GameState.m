//
//  GameState.m
//  3004iPhone
//
//  Created by Devin Lynch on 2014-01-26.
//
//

#import "GameState.h"
#import "Player.h"
#import "Game.h"
#import "PlayingCup.h"
#import "Bank.h"
#import "HexLocation.h"
#import "Creature.h"
#import "SideLocation.h"
#import "CombatPhase.h"
#import "Utils.h"

@implementation GameState

@synthesize players = _players;
@synthesize game = _game;
@synthesize myPlayerId = _myPlayerId;
@synthesize sideLocation = _sideLocation;
@synthesize playingCup = _playingCup;
@synthesize bank = _bank;
@synthesize currentCombatPhase=_currentCombatPhase;

-(id<JSONSerializable>)initFromJSON:(NSDictionary*) json{
    self = [super init];
    NSDictionary *_gameStateDic = [json objectForKey:@"gameState"];
    if(self && json != nil) {
        NSArray *playersJsonArr = [_gameStateDic objectForKey:@"players"];
        if(playersJsonArr != nil){
            _players = [[NSMutableArray alloc] init];
            for(id o in playersJsonArr) {
                if(o != nil && ([o isKindOfClass:[NSDictionary class]])){
                    NSDictionary *playerDic = (NSDictionary*) o;
                    Player *u = [[Player alloc] initFromJSON:playerDic];
                    [self.players addObject:u];
                }
            }
        }
        
        _myPlayerId = [[NSString alloc] initWithString:[json objectForKey:@"myPlayerId"]];
        
        _playingCup = [[PlayingCup alloc] initFromJSON:[_gameStateDic objectForKey:@"playingCup"]];
        [_playingCup setGameState: self];
        
        _bank = [[Bank alloc] initFromJSON:[_gameStateDic objectForKey:@"bank"]];
        
        _sideLocation = [[SideLocation alloc] initFromJSON:[_gameStateDic objectForKey:@"sideLocation"]];
        [_sideLocation setGameState: self];
        
        
        NSArray *hexLocationJsonArr = [_gameStateDic objectForKey:@"hexLocations"];
        NSMutableDictionary *locationDic = [[NSMutableDictionary alloc] init];
        if(hexLocationJsonArr != nil){
            for(id o in hexLocationJsonArr) {
                if(o != nil && ([o isKindOfClass:[NSDictionary class]])){
                    HexLocation *hexLocation =[[HexLocation alloc] initFromJSON:o];
                    [hexLocation setGameState: self];
                    [locationDic setObject:hexLocation forKey:[o objectForKey:@"locationId"]];
                }
            }
            _hexLocations = (NSMutableDictionary*)[[NSDictionary alloc] initWithDictionary:locationDic];
        }
    }
    return self;
}

-(NSString*) description{
    return [NSString stringWithFormat:@"GameState with player ID: %@ \nHexLocations:\n %@ and playing cup:\n %@", _myPlayerId , _hexLocations, _playingCup];
}


-(void)findPathFromLocation:(HexLocation *)location withMoves:(int)moves{
    
//    if(location.tile.isHilighted){
//        return;
//    }
//    
//    if (moves == 0) {
//        [[location tile] hilight];
//        return;
//    }
//    else{
//        [[location tile] hilight];
//    }
//    
//    for (HexLocation *tileLocation in [location neighbours]){
//        [self findPathFromLocation:tileLocation withMoves:--moves];
//    }
//    
    
    
}


-(Player*) getPlayerById: (NSString*) ID{
    for(Player *p in self.players) {
        if(p != nil && [p.playerId isEqualToString:ID])
            return p;
    }
    return nil;
}

-(BoardLocation*) getBoardLocationById: (NSString*) ID{
    if([ID isEqualToString: self.playingCup.locationId])
        return self.playingCup;
    
    if([ID isEqualToString: self.sideLocation.locationId])
        return self.sideLocation;
    
    for(Player *p in self.players) {
        if(p != nil && [p.rack1.locationId isEqualToString:ID])
            return p.rack1;
        if(p != nil && [p.rack2.locationId isEqualToString:ID])
            return p.rack2;
    }
    
    HexLocation *hexLocation = [self.hexLocations objectForKey:ID];
    if(hexLocation != nil) {
        return hexLocation;
    }
    
    return nil;
}

-(Stack*) getStackById:(NSString*) stackId {
    NSEnumerator *enumerator = [self.hexLocations keyEnumerator];
    id key;
    while ((key = [enumerator nextObject])) {
        HexLocation *hl = [self.hexLocations objectForKey:key];
        if(hl != nil) {
            Stack *stack = [hl.stacks objectForKey:stackId];
            if(stack != nil)
                return stack;
        }
    }
    return nil;
}

-(Player*) getMe{
    return [self getPlayerById:_myPlayerId];
}

-(void) startNewCombatPhase{
    _currentCombatPhase = [[CombatPhase alloc] initWithGameState:self];
    
    [Utils notifyOnMainQueue:@"handleCombatPhaseStarted" withObject:_currentCombatPhase];
}

-(CombatPhase*) getOrCreateCombatPhase{
    if(_currentCombatPhase == nil) {
        [self startNewCombatPhase];
    }
    return _currentCombatPhase;
}


-(void) updateHexLocationsFromSerializedJSONArray: (NSArray*) jsonArray {
    if(jsonArray != nil && ([jsonArray isKindOfClass:[NSArray class]])){
        for(NSMutableDictionary *dic in jsonArray) {
            if([dic isKindOfClass:[NSDictionary class]]){
                NSString *hexId = [dic objectForKey:@"locationId"];
                if(hexId != nil) {
                    HexLocation *hl = [_hexLocations objectForKey:hexId];
                    if(hl != nil)
                        [hl updateLocationFromSerializedJSONDictionary: dic];
                    else
                        NSLog(@"For some reason the hex location from id %@ was nil when trying to update it", hexId);
                }
            }
        }
    }
}
@end
