//
//  RandomEventHandler.m
//  3004iPhone
//
//  Created by Devin Lynch on 2014-04-07.
//
//

#import "RandomEventHandler.h"
#import "Event.h"
#import "Game.h"
#import "Utils.h"
#import "User.h"

@implementation RandomEventHandler

-(void) handlePhaseStarted:(Event*) e{
    [Utils notifyOnMainQueue:@"randomEventsStarted" withObject:nil];
}


-(void)handleRandomEventMove:(Event*) e {
    NSDictionary* dataDic = [Utils getDataDictionaryFromGameMessageEvent:e];
    
    NSDictionary *playerDic = [dataDic objectForKey:@"player"];
    NSString *clientLog = [dataDic objectForKey:@"clientLog"];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if(clientLog != nil)
            [Game addLogMessageToCurrentGame:clientLog];
        
        GameState *gs = [[Game currentGame] gameState];
        
        Player *p = [gs getPlayerById:[playerDic objectForKey:@"playerId"]];
        [p updateFromSerializedJson:playerDic];
    });
}

@end
