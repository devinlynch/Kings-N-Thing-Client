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
    RECRUITTHINGSPHASE_tradingPiece,
    MOVEMENTPHASE_moveStack,
    MOVEMENTPHASE_moveGamePiece,
    MOVEMENTPHASE_createStack,
    MOVEMENTPHASE_addPiecesToStack,
    MOVEMENTPHASE_playerIsDoneMakingMoves,
    MOVEMENTPHASE_exploreHex,
    RECRUITCHARS_MAKEROLLFORPLAYER,
    RECRUITCHARS_POSTROLL,
    CHAT_SENDMESSAGE,
    COMBAT_lockedInRollAndDamage,
    COMBAT_didRetreatOrContinue,
    
    CONS_UPGRADE_FORT,
    CONS_BUILD_FORT,
    CONS_READY_FOR_NEXT_PHASE,
    
    RANDOME_DONEMAKINGMOVE,
    RANDOME_PLAYEDDEFECTION
} InGameRequestTypes;


@protocol InGameServerProtocol <NSObject>

-(void) didGetIngameResponseFromServerForRequest: (InGameRequestTypes) requestType andResponse: (ServerResponseMessage*) responseMessage;

@end

@class ServerResponseMessage;

void (^successBlock)(ServerResponseMessage*);

@interface InGameServerAccess : NSObject
{
    NSString *ipAddress;
    NSString *port;
}


@property id<InGameServerProtocol> delegateListener;

+(InGameServerAccess*) instance;

// Setup
-(enum InGameRequestTypes) setupPhaseReadyForPlacement;

// Placement
-(enum InGameRequestTypes) placementPhasePlaceControlMarkersFirst: (NSString*) hexLocation1Id second: (NSString*) hexLocation2Id third: (NSString*) hexLocation3Id withSuccess:( void (^)(ServerResponseMessage * message))success;
-(enum InGameRequestTypes) placementPhasePlaceFort: (NSString*) hexLocationId withSuccess:( void (^)(ServerResponseMessage * message))success;

// Gold Collection
-(enum InGameRequestTypes) goldCollectionPhaseDidCollectGold;

// Recruit Things
-(enum InGameRequestTypes) recruitThingsPhaseRecruited: (NSString*) thingId palcedOnLocation: (NSString*) locationId wasBought:(BOOL) wasBought withSuccess:( void (^)(ServerResponseMessage * message))success;
-(enum InGameRequestTypes) recruitThingsTradePiece: (NSString*) oldPieceId forPiece: (NSString*) newPieceId withSuccess:( void (^)(ServerResponseMessage * message))success;
-(enum InGameRequestTypes) recruitThingsPhaseReadyForNextPhase;

// Movement
-(enum InGameRequestTypes) movementPhaseMoveStack: (NSString*) stackId toHex: (NSString*) hexLocationId withSuccess:( void (^)(ServerResponseMessage * message))success;
-(enum InGameRequestTypes) movementPhaseMoveGamePiece: (NSString*) gamePieceId toLocation: (NSString*) locationId withSuccess:( void (^)(ServerResponseMessage * message))success;
-(enum InGameRequestTypes) movementPhaseCreateStack: (NSString*) hexLocationId withPieces: (NSArray*) gamePieceIds withSuccess:( void (^)(ServerResponseMessage * message))success;
-(enum InGameRequestTypes) movementPhaseAddPiecesToStack: (NSString*) stackId pieces: (NSArray*) gamePieceIds withSuccess:( void (^)(ServerResponseMessage * message))success;
-(enum InGameRequestTypes) movementPhaseExploreHex: (NSString*) hexLocationId withStack: (NSString*) stackId andPiece: (NSString*) pieceId withSuccess:( void (^)(ServerResponseMessage * message))success;
-(enum InGameRequestTypes) movementPhaseDoneMakingMoves;

// Recruit Characters
-(enum InGameRequestTypes) recruitCharactersMakeRoll: (NSString*) recruitingCharacterId andNumPreRolls: (int) numPreRolls withSuccess:( void (^)(ServerResponseMessage * message))success;
-(enum InGameRequestTypes) recruitCharactersPostRollWithNumPostRolls: (int) numPostRolls withSuccess:( void (^)(ServerResponseMessage * message))success;


// Chat
-(enum InGameRequestTypes) sendChatMessage: (NSString*) message withSuccess:( void (^)(ServerResponseMessage * message))success;


// Combat
-(enum InGameRequestTypes) combatDidRetreatOrContinue: (BOOL) isRetreating forBattle: (NSString*) battleId andRound: (NSString*) roundId withSuccess:( void (^)(ServerResponseMessage * message))success;
-(enum InGameRequestTypes) combatLockedInRollAndDamageWithPiecesTakingDamage: (NSArray*) pieceIds forBattle: (NSString*) battleId andRound: (NSString*) roundId andRoundState: (NSString*) state withSuccess:( void (^)(ServerResponseMessage * message))success;

// Construction

-(enum InGameRequestTypes) constructionBuiltFortOnHex: (NSString*) hexId withSuccess:( void (^)(ServerResponseMessage * message))success andError: ( void (^)(ServerResponseMessage * message))error;
-(enum InGameRequestTypes) constructionUpgradedFort: (NSString*) fortId withSuccess:( void (^)(ServerResponseMessage * message))success andError: ( void (^)(ServerResponseMessage * message))error;
-(enum InGameRequestTypes) constructionReadyForNextPhaseWithSuccess:( void (^)(ServerResponseMessage * message))success;

// Random events
-(enum InGameRequestTypes) randomEventPlacedDefection: (NSString*) defectionPieceId recruitingForId: (NSString*) recruitingForId andDidRecruit: (BOOL) didRecruit andSuccess: ( void (^)(ServerResponseMessage * message))success;
-(enum InGameRequestTypes) randomEventReadyForNextPhase:( void (^)(ServerResponseMessage * message))success;

@end
