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


@interface Game : NSObject <JSONSerializable>{
    NSString *_gameID;
    GameState *_gameState;
    NSMutableArray *_users;
}


@property NSMutableArray *users;
@property GameState *gameState;
@property NSString  *gameID;





@end
