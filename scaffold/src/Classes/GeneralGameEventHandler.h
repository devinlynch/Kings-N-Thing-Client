//
//  GeneralGameEventHandler.h
//  3004iPhone
//
//  Created by Devin Lynch on 2014-02-27.
//
//

#import <Foundation/Foundation.h>
@class Event;
@interface GeneralGameEventHandler : NSObject

-(void) handleGameOver:(Event*) event;

@end
