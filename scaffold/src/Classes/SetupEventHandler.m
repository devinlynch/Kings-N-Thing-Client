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
#import "GameMessage.h"
#import "Game.h"

@implementation SetupEventHandler

-(void) handleEvent:(Event *)event{
    
}

-(void) handleSetupOver:(Event *)event;{
    NSLog(@"Got Setup Over message");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"setupOver" object:nil];
}


-(void) handleGameSetup:(Event *)event{
    GameMessage *message = (GameMessage*) event.msg;
    
    NSLog(@"Got game started message");
    
    if(message == nil){
        NSLog(@"For some reason the game was not provided in the data for a GameStarted message.  WHY?????");
        return;
    }
    
    
    GameState *gameState;

    NSDictionary* setupDic= [[message jsonDictionnary]  objectForKey:@"data"];
    
    @try{
        gameState = [[GameState alloc] initFromJSON:setupDic];
        [[Game currentGame] setGameState:gameState];
    } @catch (NSException *e) {
        NSLog(@"%@",e);
    }
    
    if(gameState == nil) {
        NSLog(@"Got gameSetup message but for some reason game could not be parsed");
        return;
    }
    
    NSLog(@"Successfully parsed game from gameSetup message, now sending notification");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"gameSetup" object:gameState];
}

@end
