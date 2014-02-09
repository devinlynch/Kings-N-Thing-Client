//
//  InGameServerAccess.h
//  3004iPhone
//
//  Created by Devin Lynch on 2014-02-09.
//
//

#import <Foundation/Foundation.h>
#import "ServerResponseMessage.h"





typedef enum InGameRequestTypes {
    SETUPPHASE_readyForPlacement,
    PLACEMENTPHASE_placeControlMarker,
    PLACEMENTPHASE_placeFort,
    GOLDCOLLECTIONPHASE_didCollectGold,
    RECRUITTHINGSPHASE_recruitedAndPlacedThing,
    RECRUITTHINGSPHASE_readyForNextPhase,
    MOVEMENTPHASE_moveStack,
    MOVEMENTPHASE_moveGamePiece,
    MOVEMENTPHASE_createStack,
    MOVEMENTPHASE_addPiecesToStack,
    MOVEMENTPHASE_playerIsDoneMakingMoves
} InGameRequestTypes;


@protocol InGameServerProtocol <NSObject>

-(void) didGetIngameResponseFromServerForRequest: (InGameRequestTypes) requestType andResponse: (ServerResponseMessage*) responseMessage;

@end

@interface InGameServerAccess : NSObject<InGameServerProtocol>

@property id<InGameServerProtocol> delegateListener;

// Setup
-(enum InGameRequestTypes) setupPhaseReadyForPlacement;

// Placement
-(enum InGameRequestTypes) placementPhasePlaceControlMarkersFirst: (NSString*) hexLocation1Id second: (NSString*) hexLocation2Id third: (NSString*) hexLocation3Id;
-(enum InGameRequestTypes) placementPhasePlaceFort: (NSString*) hexLocationId;

// Gold Collection
-(enum InGameRequestTypes) goldCollectionPhaseDidCollectGold;

// Recruit Things
-(enum InGameRequestTypes) recruitThingsPhaseRecruited: (NSString*) thingId palcedOnLocation: (NSString*) locationId wasBought:(BOOL) wasBought;
-(enum InGameRequestTypes) recruitThingsPhaseReadyForNextPhase;

// Movement
-(enum InGameRequestTypes) movementPhaseMoveStack: (NSString*) stackId toHex: (NSString*) hexLocationId;
-(enum InGameRequestTypes) movementPhaseMoveGamePiece: (NSString*) gamePieceId toLocation: (NSString*) locationId;
-(enum InGameRequestTypes) movementPhaseCreateStack: (NSString*) hexLocationId withPieces: (NSArray*) gamePieceIds;
-(enum InGameRequestTypes) movementPhaseAddPiecesToStack: (NSString*) stackId pieces: (NSArray*) gamePieceIds;
-(enum InGameRequestTypes) movementPhaseDoneMakingMoves;



@end
