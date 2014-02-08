//
//  Game.m
//  3004iPhone
//
//  Created by John Marsh on 1/21/2014.
//
//

#import "Game.h"

@implementation Game

@synthesize gameID = _gameID;
@synthesize gameState = _gameState;
@synthesize users = _users;

-(id<JSONSerializable>)initFromJSON:(NSDictionary*) json{
    self=[super init];
    if(self && json != nil) {
        NSArray *playersJsonArr = [json objectForKey:@"players"];
        if(playersJsonArr != nil){
            [self setUsers:[[NSMutableArray alloc] init]];
            for(id o in playersJsonArr) {
                if(o != nil && ([o isKindOfClass:[NSDictionary class]])){
                    NSDictionary *playerDic = (NSDictionary*) o;
                    User *u = [[User alloc] initFromJSON:playerDic];
                    [self.users addObject:u];
                }
            }
        }
    }
    return self;
}







@end
