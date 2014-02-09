//
//  SideLocation.h
//  3004iPhone
//
//  Created by Richard Ison on 2/8/2014.
//
//

#import <Foundation/Foundation.h>
#import "BoardLocation.h"
#import "JSONSerializable.h"


@interface SideLocation : BoardLocation {
    NSMutableDictionary *_sidePieces;
}


@property NSMutableDictionary *sidePieces;

@end
