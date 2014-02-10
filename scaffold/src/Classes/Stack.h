//
//  Stack.h
//  3004iPhone
//
//  Created by John Marsh on 1/28/2014.
//
//

#import "BoardLocation.h"


@class HexLocation;

@interface Stack : BoardLocation{
    HexLocation *_location;
    Player *_owner;
}

@property HexLocation *location;
@property Player *owner;

@end
