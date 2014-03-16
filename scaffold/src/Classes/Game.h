//
//  Game.h
//  3004iPhone
//
//  Created by John Marsh on 1/21/2014.
//
//

#import <Foundation/Foundation.h>
#import "Player.h"
#import "HexTile.h"
#import "GameState.h"
#import "HexLocation.h"
#import "JSONSerializable.h"
#import "ScaledGamePiece.h"

@class GameChatMessage;

@interface Game : NSObject <JSONSerializable>{
    NSString *_gameID;
    GameState *_gameState;
    NSMutableArray *_users;
    NSMutableArray *_chatMessages;
}


@property NSMutableArray *users;
@property GameState *gameState;
@property NSString  *gameID;
@property NSMutableArray *chatMessages;

+(id) currentGame;
+(void) setInstance: (Game*) game;
-(User*) getUserByUserId:(NSString*) userId;
-(void) addChatMessage: (GameChatMessage*) message;

@end
