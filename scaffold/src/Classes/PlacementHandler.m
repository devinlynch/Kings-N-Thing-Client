//
//  PlacementHandler.m
//  3004iPhone
//
//  Created by John Marsh on 2/9/2014.
//
//

#import "PlacementHandler.h"
#import "GameMessage.h"
#import "Event.h"
#import "Game.h"

@implementation PlacementHandler
-(void) handleEvent:(Event *)event{
    
}

-(void) handleYourTurnToPlaceFort:(Event *)event{
    [Game addLogMessageToCurrentGame:@"It is your turn to place your fort."];
    
    GameMessage *message = (GameMessage*) event.msg;
    NSLog(@"Got place fort  message");
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"yourTurnFort" object:nil];
    });
}

-(void) handleYourTurnToPlaceControlMarker:(Event *)event{
    [Game addLogMessageToCurrentGame:@"It is your turn to place your control markers"];
    
    GameMessage *message = (GameMessage*) event.msg;
    NSLog(@"Got place marker message");
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"yourTurnCM" object:nil];
    });
}

-(void) handleTimeToPlaceFort:(Event *)event{
    [Game addLogMessageToCurrentGame:@"It's time to place forts.  Please wait your turn."];
    
    GameMessage *message = (GameMessage*) event.msg;
    NSLog(@"Got time to place fort message");
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"timeToPlaceFort" object:nil];
    });
}

-(void) handlePlayerPlacedControlMarker:(Event *)event{
    GameMessage *message = (GameMessage*) event.msg;
    NSLog(@"Got player placed control marked message");

    
    if (message == nil || message.jsonDictionnary == nil || [Game currentGame] == nil){
        NSLog(@"For some reason the game was not provided in the data for a GameStarted message.  WHY????? idk devin");
        
        return;
    }
    
    
    
    
    NSDictionary* placedCMDic = [message.jsonDictionnary objectForKey:@"data"];
    Player *p = [[Game currentGame] getPlayerById:[placedCMDic objectForKey:@"playerId"]];
    
    if(p != nil) {
        [Game addLogMessageToCurrentGame:[NSString stringWithFormat:@"%@ placed their control markers", p.username]];
    }
    
    if(placedCMDic == nil){
        NSLog(@"Got placed control marker message but for some reason it goofed");
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"Successfully parsed your turn to place fort, now sending notificaion");
        [[NSNotificationCenter defaultCenter] postNotificationName:@"playerPlacedCM" object:placedCMDic];
    });
    
}

-(void) handlePlayerDidPlaceFort:(Event *)event{
    GameMessage *message = (GameMessage*) event.msg;
    NSLog(@"Got player placed fort message");
    
    if (message == nil || message.jsonDictionnary == nil || [Game currentGame] == nil){
        NSLog(@"For some reason the game was not provided in the data for a GameStarted message.  WHY????? idk devin");
        
        return;
    }
    
    NSDictionary* placedFortDic = [message.jsonDictionnary objectForKey:@"data"];
    
    
    if(placedFortDic == nil){
        NSLog(@"Got placed fort message but for some reason it goofed");
    }
    
    Player *p = [[Game currentGame] getPlayerById:[placedFortDic objectForKey:@"playerId"]];
    if(p != nil) {
        [Game addLogMessageToCurrentGame:[NSString stringWithFormat:@"%@ placed their fort", p.username]];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"Successfully parsed parsed from goldCollection message, now sending notificaion");
        [[NSNotificationCenter defaultCenter] postNotificationName:@"playerPlacedFort" object:placedFortDic];
    });
    
}

-(void) handlePlacementPhaseOver:(Event *)event{
    GameMessage *message = (GameMessage*) event.msg;
    NSLog(@"Got player placementphase over message");
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"placementOver" object:nil];
    });
}

@end
