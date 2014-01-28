//
//  GameEventHandler.h
//  3004iPhone
//
//  Created by Devin Lynch on 2014-01-26.
//
//

#import <Foundation/Foundation.h>
#import "EventHandlerProtocol.h"

@interface GameEventHandler : NSObject<EventHandlerProtocol>
-(void) handleGameStarted: (Event*) event;
@end
