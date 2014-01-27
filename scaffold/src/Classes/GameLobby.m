//
//  GameLobby.m
//  3004iPhone
//
//  Created by Devin Lynch on 2014-01-25.
//
//

#import "GameLobby.h"
#import "User.h"
#import "Game.h"

@implementation GameLobby

@synthesize users=_users;
@synthesize numberOfPlayersWanted=_numberOfPlayersWanted;
@synthesize isPrivate=_isPrivate;
@synthesize host=_host;
@synthesize game=_game;
@synthesize gameLobbyId=_gameLobbyId;

-(id<JSONSerializable>)initFromJSON:(NSDictionary*) json{
    self=[super init];
    if(self && json != nil) {
        [self setGameLobbyId:[json objectForKey:@"gameLobbyId"]];
        
        NSString* numPlay = [json objectForKey:@"numberOfPlayersWanted"];
        if(numPlay != nil)
            [self setNumberOfPlayersWanted: numPlay.integerValue];
        
        NSNumber *priv = [json objectForKey:@"private"];
        [self setIsPrivate:priv.boolValue];
        
        NSDictionary *host = [json objectForKey:@"host"];
        if(host != nil && ([host isKindOfClass:[NSDictionary class]])) {
            User *hUser = [[User alloc] initFromJSON:host];
            [self setHost:hUser];
        }
        
        NSDictionary *gameJson = [json objectForKey:@"game"];
        if(gameJson != nil && ([gameJson isKindOfClass:[NSDictionary class]])) {
            Game *game = [[Game alloc] initFromJSON:gameJson];
            [self setGame:game];
        }
        
        NSArray *usersJsonArr = [json objectForKey:@"users"];
        if(usersJsonArr != nil){
            [self setUsers:[[NSMutableArray alloc] init]];
            for(id o in usersJsonArr) {
                if(o != nil && ([o isKindOfClass:[NSDictionary class]])){
                    NSDictionary *userWaitingDic = (NSDictionary*) o;
                    NSDictionary *userDic = [userWaitingDic objectForKey:@"user"];
                    if(userDic != nil && ([userDic isKindOfClass:[NSDictionary class]])){
                        User *u = [[User alloc] initFromJSON:userDic];
                        [self.users addObject:u];
                    }
                }
            }
        }
        
    }
    return self;
}

@end
