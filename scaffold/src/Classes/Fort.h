//
//  Fort.h
//  3004iPhone
//
//  Created by John Marsh on 1/15/2014.
//
//

#import "Counter.h"
#import "FortLevel.h"

@interface Fort : Counter{
    NSInteger *_combatValue;
}

@property NSInteger *combatValue;

@end
