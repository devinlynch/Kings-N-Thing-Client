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

@implementation GameState

@synthesize players = _players;
@synthesize game = _game;

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
