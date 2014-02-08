//
//  SetupEventHandler.h
//  3004iPhone
//
//  Created by John Marsh on 2/3/2014.
//
//

#import <Foundation/Foundation.h>
#import "EventHandlerProtocol.h"

@interface SetupEventHandler : NSObject<EventHandlerProtocol>

-(void) handleGameSetup: (Event*) event;

@end
