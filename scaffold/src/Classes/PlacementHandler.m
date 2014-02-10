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

@implementation PlacementHandler
-(void) handleEvent:(Event *)event{
    
}

-(void) handleYourTurnToPlaceFort:(Event *)event{
    GameMessage *message = (GameMessage*) event.msg;
    NSLog(@"Got place fort  message");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"yourTurnFort" object:nil];
}

-(void) handleYourTurnToPlaceControlMarker:(Event *)event{
    GameMessage *message = (GameMessage*) event.msg;
    NSLog(@"Got place marker message");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"yourTurnCM" object:nil];
}

-(void) handleTimeToPlaceFort:(Event *)event{
    GameMessage *message = (GameMessage*) event.msg;
    NSLog(@"Got time to place fort message");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"timeToPlaceFort" object:nil];
}

-(void) handlePlayerPlacedControlMarker:(Event *)event{
    GameMessage *message = (GameMessage*) event.msg;
    NSLog(@"Got player placed control marked message");

    
    if (message == nil || message.jsonDictionnary == nil){
        NSLog(@"For some reason the game was not provided in the data for a GameStarted message.  WHY????? idk devin");
        
        return;
    }
    
    
    
    
    NSDictionary* placedCMDic = [message.jsonDictionnary objectForKey:@"data"];
    
    
    if(placedCMDic == nil){
        NSLog(@"Got placed control marker message but for some reason it goofed");
    }
    
    NSLog(@"Successfully parsed parsed from goldCollection message, now sending notificaion");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"playerPlacedCM" object:placedCMDic];
    
    
}

-(void) handlePlayerDidPlaceFort:(Event *)event{
    GameMessage *message = (GameMessage*) event.msg;
    NSLog(@"Got player placed fort message");
    
    if (message == nil || message.jsonDictionnary == nil){
        NSLog(@"For some reason the game was not provided in the data for a GameStarted message.  WHY????? idk devin");
        
        return;
    }
    
    
    
    
    NSDictionary* placedFortDic = [message.jsonDictionnary objectForKey:@"data"];
    
    
    if(placedFortDic == nil){
        NSLog(@"Got placed fort message but for some reason it goofed");
    }
    
    NSLog(@"Successfully parsed parsed from goldCollection message, now sending notificaion");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"playerPlacedFort" object:placedFortDic];
    
    
    
}

-(void) handlePlacementPhaseOver:(Event *)event{
    GameMessage *message = (GameMessage*) event.msg;
    NSLog(@"Got player placementphase over message");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"placementOver" object:nil];
}

@end
