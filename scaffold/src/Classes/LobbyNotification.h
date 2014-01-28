//
//  JoinLobbyNotification.h
//  3004iPhone
//
//  Created by Devin Lynch on 2014-01-25.
//
//

#import <Foundation/Foundation.h>
#import "ServerMessageError.h"
#import "GameLobby.h"
@interface LobbyNotification : NSObject
@property (strong) ServerMessageError *error;
@property GameLobby* gameLobby;
@end
