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


-(id<JSONSerializable>)initFromJSON:(NSDictionary*) json{
    self=[super init];
    if(self && json != nil) {
         _user = [[User alloc] initFromJSON:json];
        _username = [[NSString alloc] initWithString:[json objectForKey:@"username"]];
        _playerId   = [[NSString alloc] initWithString:[json objectForKey:@"playerId"]];
        _gold = (int)[json objectForKey:@"gold"];
        _rack1 = [Rack alloc] 
    }
    return self;
}

@end