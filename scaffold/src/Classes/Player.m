//
//  Player.m
//  3004iPhone
//
//  Created by John Marsh on 1/15/2014.
//
//

#import "Player.h"

@implementation Player

@synthesize user = _user;
@synthesize rack1 = _rack1;
@synthesize rack2 = _rack2;
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
        _gold =  [[json objectForKey:@"gold"] integerValue];
        _rack1 = [[Rack alloc] initFromJSON:[json objectForKey:@"rack1"] withOwner:self];
        _rack2 = [[Rack alloc] initFromJSON:[json objectForKey:@"rack2"] withOwner:self];
    }
    return self;
}

-(void) addGold: (int) g{
    NSLog(@"%@ had %d gold", _username, _gold);
    _gold += g;
    NSLog(@"%@ now has %d gold", _username, _gold);
}

@end