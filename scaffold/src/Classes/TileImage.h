//
//  TileImage.h
//  3004iPhone
//
//  Created by John Marsh on 2/10/2014.
//
//

#import "SPImage.h"

@class  GamePiece;

@interface TileImage :SPImage{
    GamePiece *_owner;
}

@property GamePiece *owner;


- (id) initWithContentsOfFile:(NSString *)path andOwner: (GamePiece*) piece;

@end
