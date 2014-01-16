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
    int _combatValue;
    FortLevel *_level;
}

@property int combatValue;
@property FortLevel *level;

@end
