//
//  GoldEventHandler.h
//  3004iPhone
//
//  Created by John Marsh on 2/9/2014.
//
//

#import <Foundation/Foundation.h>
#import "EventHandlerProtocol.h"
@class Event;

@interface GoldEventHandler : NSObject<EventHandlerProtocol>

-(void) handleGoldCollection: (Event*) event;

@end
