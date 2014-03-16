//
//  MessagesEventHandler.h
//  3004iPhone
//
//  Created by Devin Lynch on 2014-03-15.
//
//

#import <Foundation/Foundation.h>
@class Event;

@interface MessagesEventHandler : NSObject

-(void) handleNewMessages:(Event*) event;

@end
