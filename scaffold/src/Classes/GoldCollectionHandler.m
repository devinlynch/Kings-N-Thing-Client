//
//  GoldCollectionHandler.m
//  3004iPhone
//
//  Created by Richard Ison on 2/8/2014.
//
//

#import "GoldCollectionHandler.h"
#import "Event.h"
#import "GameState.h"
#import "GameMessage.h"

@implementation GoldCollectionHandler

-(void) handleEvent:(Event *)event{
    NSString *type = event.type;
    if (type != nil) {
        if ([type isEqualToString:@"goldCollection"]) {
            [self handleGoldCollection:event];
        }
    }
}

-(void) handleGoldCollection:(Event *)event{
    GameMessage *message = (GameMessage*) event.msg;
    NSLog(@"Got gold collection message");
    
    if (message == nil || message.jsonDictionnary == nil){
        NSLog(@"For some reason the game was not provided in the data for a GameStarted message.  WHY????? idk devin");
        
        return;
    }
    
    

    
    NSDictionary* goldCollectionDic = [message.jsonDictionnary objectForKey:@"data"];

    
    if(goldCollectionDic == nil){
        NSLog(@"Got goldCollection message but for some reason it goofed");
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"Successfully parsed parsed from goldCollection message, now sending notificaion");
        [[NSNotificationCenter defaultCenter] postNotificationName:@"goldCollection" object:goldCollectionDic];
    });
  
    
}



@end
