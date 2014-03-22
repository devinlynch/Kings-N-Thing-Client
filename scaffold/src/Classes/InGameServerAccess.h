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

@interface InGameServerAccess : NSObject

@property id<InGameServerProtocol> delegateListener;

+(InGameServerAccess*) instance;

// Setup
-(enum InGameRequestTypes) setupPhaseReadyForPlacement;

// Placement
-(enum InGameRequestTypes) placementPhasePlaceControlMarkersFirst: (NSString*) hexLocation1Id second: (NSString*) hexLocation2Id third: (NSString*) hexLocation3Id withSuccess:( void (^)())success;
-(enum InGameRequestTypes) placementPhasePlaceFort: (NSString*) hexLocationId withSuccess:( void (^)())success;

// Gold Collection
-(enum InGameRequestTypes) goldCollectionPhaseDidCollectGold;

// Recruit Things
-(enum InGameRequestTypes) recruitThingsPhaseRecruited: (NSString*) thingId palcedOnLocation: (NSString*) locationId wasBought:(BOOL) wasBought withSuccess:( void (^)())success;
-(enum InGameRequestTypes) recruitThingsPhaseReadyForNextPhase;

// Movement
-(enum InGameRequestTypes) movementPhaseMoveStack: (NSString*) stackId toHex: (NSString*) hexLocationId withSuccess:( void (^)())success;
-(enum InGameRequestTypes) movementPhaseMoveGamePiece: (NSString*) gamePieceId toLocation: (NSString*) locationId withSuccess:( void (^)())success;
-(enum InGameRequestTypes) movementPhaseCreateStack: (NSString*) hexLocationId withPieces: (NSArray*) gamePieceIds withSuccess:( void (^)())success;
-(enum InGameRequestTypes) movementPhaseAddPiecesToStack: (NSString*) stackId pieces: (NSArray*) gamePieceIds withSuccess:( void (^)())success;
-(enum InGameRequestTypes) movementPhaseDoneMakingMoves;



@end
