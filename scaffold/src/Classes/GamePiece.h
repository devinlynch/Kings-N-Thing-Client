//
//  GamePiece.h
//  3004iPhone
//
//  Created by John Marsh on 1/15/2014.
//
//

#import <Foundation/Foundation.h>

@class ScaledGamePiece, BoardLocation;

@interface GamePiece : NSObject{
    NSString *_gamePieceID;
    BoardLocation *_location;
    ScaledGamePiece *_pieceImage;
}

@property NSString *gamePieceID;
@property BoardLocation *location;
@property ScaledGamePiece *pieceImage;


@end
