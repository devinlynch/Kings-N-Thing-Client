//
//  GoldEventHandler.m
//  3004iPhone
//
//  Created by John Marsh on 2/9/2014.
//
//

#import "GoldEventHandler.h"
#import "GameMessage.h"
#import "Event.h"

@implementation GoldEventHandler

-(void) handleEvent:(Event *)event{
    
}

-(void) handleGoldCollection: (Event*) event{
    GameMessage *message = (GameMessage*) event.msg;
    
    NSLog(@"Got gold message");
    
    if(message == nil){
        NSLog(@"For some reason the game was not provided in the data for a GameStarted message.  WHY?????");
        return;
    }
    
    

    
    NSDictionary* setupDic= [[message jsonDictionnary]  objectForKey:@"data"];
    
    
    if(setupDic == nil) {
        NSLog(@"Got gold message but for some reason game could not be parsed");
        return;
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"goldCollection" object:setupDic];
}

@end
