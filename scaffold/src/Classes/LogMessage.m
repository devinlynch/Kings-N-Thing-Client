//
//  LogMessage.m
//  3004iPhone
//
//  Created by Devin Lynch on 2014-04-01.
//
//

#import "LogMessage.h"

@implementation LogMessage
@synthesize date, message;

-(id) initWithMessage: (NSString*) _message{
    self = [super init];
    if(self) {
        date = [[NSDate alloc] init];
        message = _message;
    }
    return self;
}


@end
