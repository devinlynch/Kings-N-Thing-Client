//
//  GameLobby.h
//  3004iPhone
//
//  Created by Devin Lynch on 2014-01-25.
//
//

#import <Foundation/Foundation.h>
#import "JSONSerializable.h"
@class Game;
@class User;

@interface GameLobby : NSObject<JSONSerializable>
{
    int _numberOfPlayersWanted;
    BOOL _isPrivate;
    Game *_game;
    User *_host;
    NSMutableArray *_users;
    NSString* _gameLobbyId;
}

@property int numberOfPlayersWanted;
@property BOOL isPrivate;
@property Game *game;
@property User *host;
@property NSMutableArray *users;
@property NSString* gameLobbyId;

@end
