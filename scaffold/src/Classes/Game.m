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

static Game *instance;

+(id) currentGame{
    @synchronized(self){
        return instance;
    }
}

+(void) setInstance: (Game*) game {
    @synchronized(self){
        instance = game;
    }
}

-(id<JSONSerializable>)initFromJSON:(NSDictionary*) json{
    self=[super init];
    if(self && json != nil) {
        [self setGameID:[json objectForKey:@"gameId"]];
        
        NSArray *usersJsonArr = [json objectForKey:@"users"];
        if(usersJsonArr != nil){
            [self setUsers:[[NSMutableArray alloc] init]];
            for(id o in usersJsonArr) {
                if(o != nil && ([o isKindOfClass:[NSDictionary class]])){
                    NSDictionary *userDic = (NSDictionary*) o;
                    User *u = [[User alloc] initFromJSON:userDic];
                    [self.users addObject:u];
                }
            }
        }
    }
    return self;
}







@end
