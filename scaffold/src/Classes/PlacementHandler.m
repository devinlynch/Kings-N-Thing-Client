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

}

-(void) handleYourTurnToPlaceControlMarker:(Event *)event{
    GameMessage *message = (GameMessage*) event.msg;
    NSLog(@"Got place marker message");

}

-(void) handleTimeToPlaceFort:(Event *)event{
    GameMessage *message = (GameMessage*) event.msg;
    NSLog(@"Got time to place fort message");

}

-(void) handlePlayerPlacedControlMarker:(Event *)event{
    GameMessage *message = (GameMessage*) event.msg;
    NSLog(@"Got player placed control marked message");

}

-(void) handlePlayerDidPlaceFort:(Event *)event{
    GameMessage *message = (GameMessage*) event.msg;
    NSLog(@"Got player placed fort message");

}

-(void) handlePlacementPhaseOver:(Event *)event{
    GameMessage *message = (GameMessage*) event.msg;
    NSLog(@"Got player placementphase over message");

}

@end
