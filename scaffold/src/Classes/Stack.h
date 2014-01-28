//
//  Stack.h
//  3004iPhone
//
//  Created by John Marsh on 1/28/2014.
//
//

#import "BoardLocation.h"
#import "HexLocation.h"

@interface Stack : BoardLocation{
    HexLocation *_location;
}

@property HexLocation *location;

@end
