//
//  Stack.h
//  3004iPhone
//
//  Created by John Marsh on 1/28/2014.
//
//

#import "BoardLocation.h"


@class HexLocation, ScaledGamePiece;

@interface Stack : BoardLocation{
    HexLocation *_location;
    Player *_owner;
    ScaledGamePiece *_stackImage;
}

@property HexLocation *location;
@property Player *owner;
@property ScaledGamePiece *stackImage;

-(void) destroy;

@end
