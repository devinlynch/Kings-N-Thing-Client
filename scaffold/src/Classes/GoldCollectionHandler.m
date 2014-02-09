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
    Message *message = event.msg;
    NSLog(@"Got handle game message");
    
    if (message == nil || message.data == nil){
        NSLog(@"For some reason the game was not provided in the data for a GameStarted message.  WHY????? idk devin");
        
        return;
    }
    
    

    
    NSDictionary* goldCollectionDic = [message.data.map objectForKey:@"data"];

    
    if(goldCollectionDic == nil){
        NSLog(@"Got goldCollection message but for some reason it goofed");
    }
    
    NSLog(@"Successfully parsed parsed from goldCollection message, now sending notificaion");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"goldCollection" object:goldCollectionDic];
    
  
    
}



@end
