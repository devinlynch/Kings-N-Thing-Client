//
//  Counter.h
//  3004iPhone
//
//  Created by John Marsh on 1/20/2014.
//
//

#import "GamePiece.h"
#import "CounterType.h"

@interface Counter : GamePiece{
    CounterType *_counterType;
}

@property CounterType *counterType;

@end
