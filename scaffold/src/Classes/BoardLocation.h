//
//  BoardLocation.h
//  3004iPhone
//
//  Created by John Marsh on 1/15/2014.
//
//

#import <Foundation/Foundation.h>

@interface BoardLocation : NSObject{
    NSString *_containerID;
    NSString *_containerName;
    NSString *_containerLocation;
    NSMutableDictionary *_pieces;

}

@property NSString *containerID, *containerName, *containerLocation;
@property NSMutableDictionary *pieces;

@end
