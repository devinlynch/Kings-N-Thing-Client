//
//  LobbyEventHandler.h
//  3004iPhone
//
//  Created by Devin Lynch on 2014-01-25.
//
//
/*
 Handles messages beign received about state of the users current lobby, or search for a lobby.  These messages are mostly, but may not be,
 received through UDP and therefore a NSNotification is fired rather than a delegate listener
 
 
 */

#import <Foundation/Foundation.h>
#import "EventHandlerProtocol.h"

@interface LobbyEventHandler : NSObject<EventHandlerProtocol>

@end
