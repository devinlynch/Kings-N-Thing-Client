//
//  Event.m
//  Reactor
//
//  Created by Tony White on 12-03-22.
//  Copyright (c) 2012 Carleton University. All rights reserved.
//

#import "Event.h"

@implementation Event

@synthesize type;
@synthesize msg;
@synthesize delegateListener, requestParams;

-(id) init {
    self = [super init];
    if (self) {
        type = @"TEST";
    }
    return self;
}


-(id) initForType:(NSString *)t withMessage:(Message *)m{
    self = [self init];
    self.type = t;
    self.msg = m;
    return self;
}


@end
