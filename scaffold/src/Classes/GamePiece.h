//
//  GamePiece.h
//  3004iPhone
//
//  Created by John Marsh on 1/15/2014.
//
//

#import <Foundation/Foundation.h>
#import "ScaledGamePiece.h"

@interface GamePiece : NSObject{
    NSString *_gamePieceID;
    ScaledGamePiece *_pieceImage;
}

@property NSString *gamePieceID;
@property ScaledGamePiece *pieceImage;


@end
