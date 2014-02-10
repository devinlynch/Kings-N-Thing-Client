//
//  Bank.m
//  3004iPhone
//
//  Created by John Marsh on 1/21/2014.
//
//

#import "Bank.h"

@implementation Bank

@synthesize currentTotal = _currentTotal;

-(Bank*) initWithTotal:(int)total{
    self=[super init];
    _currentTotal = total;
    return self;
}

-(id<JSONSerializable>) initFromJSON:(NSDictionary *)json{
    _currentTotal = (int) [json objectForKey:@"currentTotal"];
    return [super init];
}


-(void) decreaseByAmount: (int) amount{
    _currentTotal -= amount;
}

-(void) increaseByAmount: (int) amount{
    _currentTotal += amount;
}


@end
