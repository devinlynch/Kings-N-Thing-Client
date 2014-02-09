//
//  GoldCollectionHandler.h
//  3004iPhone
//
//  Created by Richard Ison on 2/8/2014.
//
//

#import <Foundation/Foundation.h>
#import "EventHandlerProtocol.h"


@interface GoldCollectionHandler :  NSObject<EventHandlerProtocol>
-(void) handleGoldCollection: (Event*) event;
@end
