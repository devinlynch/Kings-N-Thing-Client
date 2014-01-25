//
//  ClientLoginHandler.m
//  COMP2601iPhoneAssignment3
//
//  Created by John Marsh on 13-04-03.
//  Copyright (c) 2013 John Marsh. All rights reserved.
//

#import "TestEventHandler.h"
#import "Event.h"
#import "Message.h"
@implementation TestEventHandler

-(void) handleEvent:(Event *)event{
    NSLog(@"Test event handler data: %@", event.msg.data.map);
}

@end
