//
//  SetupEventHandler.m
//  3004iPhone
//
//  Created by John Marsh on 2/3/2014.
//
//

#import "SetupEventHandler.h"
#import "Event.h"
#import "GameState.h"

@implementation SetupEventHandler

-(void) handleEvent:(Event *)event{
    
}

-(void) handleGameSetup:(Event *)event{
    Message *message = event.msg;
    NSLog(@"Got game started message");
    if(message == nil || message.data == nil || message.data.map == nil){
        NSLog(@"For some reason the game was not provided in the data for a GameStarted message.  WHY?????");
        return;
    }
    
    
    GameState *gameState;

    NSDictionary* setupDic= [message.data.map objectForKey:@"data"];
    
    @try{
        gameState = [[GameState alloc] initFromJSON:setupDic];
    } @catch (NSException *e) {
        NSLog(@"%@",e);
    }
    
    if(gameState == nil) {
        NSLog(@"Got gameSetup message but for some reason game could not be parsed");
        return;
    }
    
    NSLog(@"Successfully parsed game from gameSetup message, now sending notification");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"gameSetup" object:gameState];}

@end
