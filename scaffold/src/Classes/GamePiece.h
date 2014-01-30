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
    ScaledGamePiece *_image;
}

@property NSString *gamePieceID;

-(GamePiece*) initWithImageFileName: (NSString*) img;

@end
