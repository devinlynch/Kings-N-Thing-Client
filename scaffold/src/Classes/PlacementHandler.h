//
//  PlacementHandler.h
//  3004iPhone
//
//  Created by John Marsh on 2/9/2014.
//
//

#import <Foundation/Foundation.h>
#import "EventHandlerProtocol.h"

@interface PlacementHandler : NSObject<EventHandlerProtocol>

-(void) handleYourTurnToPlaceFort:(Event *)event;

-(void) handleYourTurnToPlaceControlMarker:(Event *)event;

-(void) handleTimeToPlaceFort:(Event *)event;

-(void) handlePlayerPlacedControlMarker:(Event *)event;

-(void) handlePlayerDidPlaceFort:(Event *)event;

-(void) handlePlacementPhaseOver:(Event *)event;


@end
