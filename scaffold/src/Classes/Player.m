//
//  Player.m
//  3004iPhone
//
//  Created by John Marsh on 1/15/2014.
//
//

#import "Player.h"
#import "GamePiece.h"
@implementation Player

@synthesize user = _user;
@synthesize rack1 = _rack1;
@synthesize gold = _gold;
@synthesize playerId = _playerId;
@synthesize gamePieces = _gamePieces;
@synthesize username = _username;


-(id<JSONSerializable>)initFromJSON:(NSDictionary*) json{
    self=[super init];
    if(self && json != nil) {
         _user = [[User alloc] initFromJSON:json];
        _username = [[NSString alloc] initWithString:[json objectForKey:@"username"]];
        _playerId   = [[NSString alloc] initWithString:[json objectForKey:@"playerId"]];
        _gold =  [[json objectForKey:@"gold"] intValue];
        _rack1 = [[Rack alloc] initFromJSON:[json objectForKey:@"rack1"] withOwner:self];
        _gamePieces = [[NSMutableDictionary alloc] init];
    }
    return self;
}

-(void) addGold: (int) g{
    NSLog(@"%@ had %d gold", _username, _gold);
    _gold += g;
    NSLog(@"%@ now has %d gold", _username, _gold);
}

-(void) assignPiece: (GamePiece*) gamePiece{
    Player *previousOwner = gamePiece.owner;
    if(previousOwner != nil && ![previousOwner isKindOfClass:[NSNull class]]) {
        [previousOwner.gamePieces removeObjectForKey:gamePiece.gamePieceId];
    }
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
        _gold =  [[json objectForKey:@"gold"] intValue];
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

@end