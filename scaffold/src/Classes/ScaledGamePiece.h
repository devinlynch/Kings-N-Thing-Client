//
//  ScaleImage.h
//  3004iPhone
//
//  Created by Richard Ison on 1/16/2014.
//
//

#import "SPImage.h"
@class  GamePiece;


@interface ScaledGamePiece : SPImage{
    GamePiece *_owner;
}

@property GamePiece *owner;

- (id) initWithContentsOfFile:(NSString *)path andOwner: (GamePiece*) piece;

@end
