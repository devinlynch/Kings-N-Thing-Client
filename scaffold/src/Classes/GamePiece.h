//
//  GamePiece.h
//  3004iPhone
//
//  Created by John Marsh on 1/15/2014.
//
//

#import <Foundation/Foundation.h>

@class ScaledGamePiece, BoardLocation, Player, GameState;

@interface GamePiece : NSObject{
    NSString *_gamePieceId;
    BoardLocation *_location;
    Player *_owner;
    ScaledGamePiece *_pieceImage;
    ScaledGamePiece *_bluffImage;
    ScaledGamePiece *_borderImage;
    NSString *_fileName;
    NSString *_name;
    BOOL _isBluff;
}

@property NSString *gamePieceId;
@property Player *owner;
@property BoardLocation *location;
@property ScaledGamePiece *pieceImage;
@property ScaledGamePiece *bluffImage;
@property ScaledGamePiece *borderImage;
@property NSString *fileName;
@property NSString *name;
@property BOOL isBluff;

-(void) updateFromSerializedJson: (NSDictionary*) json forGameState: (GameState*) gameState;

-(void) changeOwnerToPlayer: (Player*) player;

@end
