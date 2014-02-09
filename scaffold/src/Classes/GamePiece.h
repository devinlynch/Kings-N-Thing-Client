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
    NSString *_gamePieceId;
    NSString *_locationId;
    ScaledGamePiece *_pieceImage;
}

@property NSString *gamePieceId;
@property NSString *locationId;
@property ScaledGamePiece *pieceImage;


@end
