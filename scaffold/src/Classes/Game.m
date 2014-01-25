//
//  Game.m
//  3004iPhone
//
//  Created by John Marsh on 1/21/2014.
//
//

#import "Game.h"

@implementation Game

@synthesize players = _players;

-(id<JSONSerializable>)initFromJSON:(NSDictionary*) json{
    self=[super init];
    if(self && json != nil) {
        NSArray *playersJsonArr = [json objectForKey:@"players"];
        if(playersJsonArr != nil){
            [self setPlayers:[[NSMutableArray alloc] init]];
            for(id o in playersJsonArr) {
                if(o != nil && ([o isKindOfClass:[NSDictionary class]])){
                    NSDictionary *playerDic = (NSDictionary*) o;
                    Player *u = [[Player alloc] initFromJSON:playerDic];
                    [self.players addObject:u];
                }
            }
        }
    }
    return self;
}


@end
