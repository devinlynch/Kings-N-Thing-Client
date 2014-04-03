//
//  GamePiece.h
//  3004iPhone
//
//  Created by John Marsh on 1/15/2014.
//
//

#import <Foundation/Foundation.h>

@class ScaledGamePiece, BoardLocation, Player;

@interface GamePiece : NSObject{
    NSString *_gamePieceId;
    BoardLocation *_location;
    Player *_owner;
    ScaledGamePiece *_pieceImage;
    ScaledGamePiece *_bluffImage;
    NSString *_fileName;
    BOOL _isBluff;
}

@property NSString *gamePieceId;
@property Player *owner;
@property BoardLocation *location;
@property ScaledGamePiece *pieceImage;
@property ScaledGamePiece *bluffImage;
@property NSString *fileName;
@property BOOL isBluff;

@end
