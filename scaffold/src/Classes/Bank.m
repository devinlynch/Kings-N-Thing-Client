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
    _currentTotal = total;
    return [super init];
}

@end
