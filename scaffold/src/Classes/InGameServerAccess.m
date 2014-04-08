//
//  InGameServerAccess.m
//  3004iPhone
//
//  Created by Devin Lynch on 2014-02-09.
//
//

#import "InGameServerAccess.h"
#import "ServerAccess.h"
#import "IPManager.h"
#import "Utils.h"

@implementation InGameServerAccess
@synthesize delegateListener;

static InGameServerAccess *instance;


-(id) init{
    self= [super init];
    NSDictionary *mainDictionary = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"server_config" ofType:@"plist"]];
    ipAddress = [mainDictionary objectForKey:@"ip_address"];
    port=[mainDictionary objectForKey:@"port"];
    return self;
}

+(InGameServerAccess*) instance{
    @synchronized(self){
        if(!instance)
            instance = [[InGameServerAccess alloc] init];
    }
    return instance;
}

-(void) asynchronousRequestOfType: (HttpRequestMethods) method toUrl: (NSString*) req withParams: (NSMutableDictionary*) params  andDelegateListener: (id) delegateListener andErrorCall:(block_t) errorCall andSuccessCall: (block_t) successCall andRequestType: (InGameRequestTypes) requestType{
    
    // Always send hostname and port number that we are listneing on
    [params setValue:[IPManager getIPAddress: YES] forKey:@"hostName"];
    [params setValue:@"3004" forKey:@"port"];
    
    NSString *postBody = [Utils httpParamsFromDictionary:params];
    NSLog(@"Doing post:%@ with params: %@", req, postBody);
    NSData *postData = [postBody dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSString *targetUrl = [NSString stringWithFormat:@"http://%@:%@/KingsNThings/%@", ipAddress,port,req];
    NSURL *url = [NSURL URLWithString:targetUrl];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod: [self httpethodToString:method]];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:postData];
    [request setTimeoutInterval:20];
    //TODO: handle timeout
    NSOperationQueue *queue =[[NSOperationQueue alloc] init];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:queue
                           completionHandler:
     ^(NSURLResponse *response, NSData *data, NSError *error) {
         
         NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
         int responseStatusCode = [httpResponse statusCode];
         
         ServerResponseMessage *responseMessage;
         if(data != nil && responseStatusCode == 200 && error == nil){
             @try{
                 responseMessage = [Utils serverResponseMessageFromJSONData:data];
             } @catch (NSException *e) {
                 NSLog(@"Error parsing response message: %@", e);
             }
         }
         
         if( responseMessage != nil && responseMessage.error == nil ){
             [delegateListener didGetIngameResponseFromServerForRequest:requestType andResponse:responseMessage];
             if (successCall != nil) {
                successCall(responseMessage);
             }
         } else if([responseMessage.error.responseError isEqualToString:@"NOT_LOGGED_IN"]){
             @try{
                 dispatch_async(dispatch_get_main_queue(), ^{
                     [[NSNotificationCenter defaultCenter] postNotificationName:@"gameOver" object:nil];
                 });
             } @catch (NSException *e) {
                 NSLog(@"Error sending game over notification because user is not logged in: %@", e);
             }
             return;
         } else{
             NSLog(@"could not connect to server, doing call, got response code: %d and error: %@", responseStatusCode, error);
             if(errorCall != nil)
                 errorCall(responseMessage);
         }
     }];
}

-(NSString*) httpethodToString: (HttpRequestMethods) method {
    if(method == GETREQUEST) {
        return @"GET";
    } else{
        return @"POST";
    }
}

-(void) phasePost: (NSString*) phase type: (NSString*) type params: (NSMutableDictionary*) params requestType: (InGameRequestTypes) requestType withSuccess:( void (^)(ServerResponseMessage * message))success{
    [self asynchronousRequestOfType:POSTREQUEST toUrl:[NSString stringWithFormat:@"phase/%@/%@", phase, type] withParams:params andDelegateListener:delegateListener andErrorCall:^{
        [delegateListener didGetIngameResponseFromServerForRequest:requestType andResponse:nil];
    }andSuccessCall:success andRequestType:requestType];
}

-(void) phasePost: (NSString*) phase type: (NSString*) type params: (NSMutableDictionary*) params requestType: (InGameRequestTypes) requestType withSuccess:( void (^)(ServerResponseMessage * message))success andError: ( void (^)(ServerResponseMessage * message))error{
    [self asynchronousRequestOfType:POSTREQUEST toUrl:[NSString stringWithFormat:@"phase/%@/%@", phase, type] withParams:params andDelegateListener:delegateListener andErrorCall:error andSuccessCall:success andRequestType:requestType];
}

// Setup
-(enum InGameRequestTypes) setupPhaseReadyForPlacement{
    [self phasePost:@"setup" type:@"readyForPlacement" params:nil requestType:SETUPPHASE_readyForPlacement withSuccess:nil];
    
    return SETUPPHASE_readyForPlacement;
}

// Placement
-(enum InGameRequestTypes) placementPhasePlaceControlMarkersFirst: (NSString*) hexLocation1Id second: (NSString*) hexLocation2Id third: (NSString*) hexLocation3Id withSuccess:( void (^)(ServerResponseMessage * message))success{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:hexLocation1Id forKey:@"hexLocation1"];
    [params setObject:hexLocation2Id forKey:@"hexLocation2"];
    [params setObject:hexLocation3Id forKey:@"hexLocation3"];
    
    [self phasePost:@"placement" type:@"placeControlMarker" params:params requestType:SETUPPHASE_readyForPlacement withSuccess:success];

    return PLACEMENTPHASE_placeControlMarker;
}

-(enum InGameRequestTypes) placementPhasePlaceFort: (NSString*) hexLocationId withSuccess:( void (^)(ServerResponseMessage * message))success{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:hexLocationId forKey:@"hexLocation"];
    
    [self phasePost:@"placement" type:@"placeFort" params:params requestType:PLACEMENTPHASE_placeFort withSuccess:success];
    
    return PLACEMENTPHASE_placeFort;
}


// Gold Collection
-(enum InGameRequestTypes) goldCollectionPhaseDidCollectGold{
    [self phasePost:@"gold" type:@"didCollectGold" params:nil requestType:GOLDCOLLECTIONPHASE_didCollectGold withSuccess:nil];

    return GOLDCOLLECTIONPHASE_didCollectGold;
}


// Recruit Things
-(enum InGameRequestTypes) recruitThingsPhaseRecruited: (NSString*) thingId palcedOnLocation: (NSString*) locationId wasBought:(BOOL) wasBought withSuccess:( void (^)(ServerResponseMessage * message))success{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:thingId forKey:@"thingId"];
    [params setObject:locationId forKey:@"locationId"];
    [params setObject:wasBought == true ? @"true" : @"false" forKey:@"wasBought"];
    
    [self phasePost:@"recruitThings" type:@"recruitedAndPlacedThing" params:params requestType:RECRUITTHINGSPHASE_recruitedAndPlacedThing withSuccess:success];
    
    return RECRUITTHINGSPHASE_recruitedAndPlacedThing;
}

-(enum InGameRequestTypes) recruitThingsTradePiece: (NSString*) oldPieceId forPiece: (NSString*) newPieceId withSuccess:( void (^)(ServerResponseMessage * message))success{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:oldPieceId forKey:@"oldThingId"];
    [params setObject:newPieceId forKey:@"newThingId"];
    
    [self phasePost:@"recruitThings" type:@"tradedThing" params:params requestType:RECRUITTHINGSPHASE_tradingPiece withSuccess:success];
    
    return RECRUITTHINGSPHASE_tradingPiece;
}

-(enum InGameRequestTypes) recruitThingsPhaseReadyForNextPhase{
    [self phasePost:@"recruitThings" type:@"readyForNextPhase" params:nil requestType:RECRUITTHINGSPHASE_readyForNextPhase withSuccess:nil];

    return RECRUITTHINGSPHASE_readyForNextPhase;
}

// Movement
-(enum InGameRequestTypes) movementPhaseMoveStack: (NSString*) stackId toHex: (NSString*) hexLocationId withSuccess:( void (^)(ServerResponseMessage * message))success{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:hexLocationId forKey:@"hexLocationId"];
    [params setObject:stackId forKey:@"stackId"];
    
    [self phasePost:@"movement" type:@"moveStack" params:params requestType:MOVEMENTPHASE_moveStack withSuccess:success];
    
    return MOVEMENTPHASE_moveStack;
}

-(enum InGameRequestTypes) movementPhaseMoveGamePiece: (NSString*) gamePieceId toLocation: (NSString*) locationId withSuccess:( void (^)(ServerResponseMessage * message))success{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:locationId forKey:@"locationId"];
    [params setObject:gamePieceId forKey:@"gamePieceId"];
    
    [self phasePost:@"movement" type:@"moveGamePiece" params:params requestType:MOVEMENTPHASE_moveGamePiece withSuccess:success];
    
    return MOVEMENTPHASE_moveGamePiece;
}

-(enum InGameRequestTypes) movementPhaseCreateStack: (NSString*) hexLocationId withPieces: (NSArray*) gamePieceIds withSuccess:( void (^)(ServerResponseMessage * message))success{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:hexLocationId forKey:@"hexLocationId"];
    
    int i = 1;
    for(NSString *gamePieceId in gamePieceIds) {
        [params setObject:gamePieceId forKey:[NSString stringWithFormat:@"gamePiece_%d", i]];
        i++;
    }
    
    [self phasePost:@"movement" type:@"createStack" params:params requestType:MOVEMENTPHASE_createStack withSuccess:success];
    
    return MOVEMENTPHASE_createStack;
}

-(enum InGameRequestTypes) movementPhaseAddPiecesToStack: (NSString*) stackId pieces: (NSArray*) gamePieceIds withSuccess:( void (^)(ServerResponseMessage * message))success{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:stackId forKey:@"stackId"];
    
    int i = 1;
    for(NSString *gamePieceId in gamePieceIds) {
        [params setObject:gamePieceId forKey:[NSString stringWithFormat:@"gamePiece_%d", i]];
        i++;
    }
    
    [self phasePost:@"movement" type:@"addPiecesToStack" params:params requestType:MOVEMENTPHASE_addPiecesToStack withSuccess:success];
    
    return MOVEMENTPHASE_addPiecesToStack;
}

-(enum InGameRequestTypes) movementPhaseExploreHex: (NSString*) hexLocationId withStack: (NSString*) stackId andPiece: (NSString*) pieceId withSuccess:( void (^)(ServerResponseMessage * message))success{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:hexLocationId forKey:@"hexLocationId"];
    if(stackId != nil)
        [params setObject:stackId forKey:@"stackId"];
    if(pieceId != nil)
        [params setObject:pieceId forKey:@"gamePieceId"];
    
    [self phasePost:@"movement" type:@"exploreHex" params:params requestType:MOVEMENTPHASE_exploreHex withSuccess:success];
    
    return MOVEMENTPHASE_exploreHex;
}


-(enum InGameRequestTypes) movementPhaseDoneMakingMoves{
    [self phasePost:@"movement" type:@"playerIsDoneMakingMoves" params:nil requestType:MOVEMENTPHASE_playerIsDoneMakingMoves withSuccess:nil];
    
    return MOVEMENTPHASE_playerIsDoneMakingMoves;
}


/*
 Recruit Characters
 */

-(enum InGameRequestTypes) recruitCharactersMakeRoll: (NSString*) recruitingCharacterId andNumPreRolls: (int) numPreRolls withSuccess:( void (^)(ServerResponseMessage * message))success{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:recruitingCharacterId forKey:@"recruitingCharacterId"];
    [params setObject:[NSNumber numberWithInt: numPreRolls] forKey:@"numPreRolls"];
    
    [self phasePost:@"recruitCharacters" type:@"makeRollForPlayer" params:params requestType:RECRUITCHARS_MAKEROLLFORPLAYER withSuccess:success];
    
    return RECRUITCHARS_MAKEROLLFORPLAYER;
}

-(enum InGameRequestTypes) recruitCharactersPostRollWithNumPostRolls: (int) numPostRolls withSuccess:( void (^)(ServerResponseMessage * message))success{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:[NSNumber numberWithInt: numPostRolls] forKey:@"numPostRolls"];
    
    [self phasePost:@"recruitCharacters" type:@"postRoll" params:params requestType:RECRUITCHARS_POSTROLL withSuccess:success];
    
    return RECRUITCHARS_POSTROLL;
}


//// CHAT /////
-(enum InGameRequestTypes) sendChatMessage: (NSString*) message withSuccess:( void (^)(ServerResponseMessage * message))success{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:message forKey:@"message"];
    
    [self asynchronousRequestOfType:POSTREQUEST toUrl:@"game/sendChat" withParams:params andDelegateListener:delegateListener andErrorCall:^{
        [delegateListener didGetIngameResponseFromServerForRequest:CHAT_SENDMESSAGE andResponse:nil];
    }andSuccessCall:success andRequestType:CHAT_SENDMESSAGE];
    
    return CHAT_SENDMESSAGE;
}


//// COMBAT //////


-(enum InGameRequestTypes) combatDidRetreatOrContinue: (BOOL) isRetreating forBattle: (NSString*) battleId andRound: (NSString*) roundId withSuccess:( void (^)(ServerResponseMessage * message))success{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:isRetreating == true ? @"true" : @"false" forKey:@"isRetreating"];
    [params setObject:battleId forKey:@"battleId"];
    [params setObject:roundId forKey:@"roundId"];
    
    [self phasePost:@"combat" type:@"didRetreatOrContinue" params:params requestType:COMBAT_didRetreatOrContinue withSuccess:success];
    
    return COMBAT_didRetreatOrContinue;
}

-(enum InGameRequestTypes) combatLockedInRollAndDamageWithPiecesTakingDamage: (NSArray*) pieceIds forBattle: (NSString*) battleId andRound: (NSString*) roundId andRoundState: (NSString*) state withSuccess:( void (^)(ServerResponseMessage * message))success{
    
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:battleId forKey:@"battleId"];
    [params setObject:roundId forKey:@"roundId"];
    [params setObject:state forKey:@"roundState"];
    
    int i = 0;
    for(NSString *pieceId in pieceIds) {
        [params setObject:pieceId forKey:[NSString stringWithFormat:@"piceIdTakingHit_%d", i]];
        i++;
    }
    
    [self phasePost:@"combat" type:@"lockedInRollAndDamage" params:params requestType:COMBAT_lockedInRollAndDamage withSuccess:success];
    
    return COMBAT_lockedInRollAndDamage;
}

-(enum InGameRequestTypes) constructionBuiltFortOnHex: (NSString*) hexId withSuccess:( void (^)(ServerResponseMessage * message))success andError: ( void (^)(ServerResponseMessage * message))error{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:hexId forKey:@"hexId"];
    
    [self phasePost:@"construction" type:@"didBuyFort" params:params requestType:CONS_BUILD_FORT withSuccess:success andError:error];
    
    return CONS_BUILD_FORT;
}

-(enum InGameRequestTypes) constructionUpgradedFort: (NSString*) fortId withSuccess:( void (^)(ServerResponseMessage * message))success andError: ( void (^)(ServerResponseMessage * message))error{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:fortId forKey:@"fortId"];
    
    [self phasePost:@"construction" type:@"didUpgradeFort" params:params requestType:CONS_UPGRADE_FORT withSuccess:success andError:error];
    
    return CONS_UPGRADE_FORT;
}

-(enum InGameRequestTypes) constructionReadyForNextPhaseWithSuccess:( void (^)(ServerResponseMessage * message))success{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [self phasePost:@"construction" type:@"readyForNextPhase" params:params requestType:CONS_READY_FOR_NEXT_PHASE withSuccess:success];
    
    return CONS_READY_FOR_NEXT_PHASE;
}

-(enum InGameRequestTypes) randomEventPlacedDefection: (NSString*) defectionPieceId recruitingForId: (NSString*) recruitingForId andDidRecruit: (BOOL) didRecruit andSuccess: ( void (^)(ServerResponseMessage * message))success{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:defectionPieceId forKey:@"randomEventPieceId"];
    [params setObject:recruitingForId forKey:@"recruitingForId"];
    [params setObject:didRecruit ? @"true" : @"false" forKey:@"didRecruit"];
    
    [self phasePost:@"RandomEvent" type:@"playDefection" params:params requestType:RANDOME_PLAYEDDEFECTION withSuccess:success];
    return RANDOME_PLAYEDDEFECTION;
}
-(enum InGameRequestTypes) randomEventReadyForNextPhase:( void (^)(ServerResponseMessage * message))success{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [self phasePost:@"RandomEvent" type:@"doneMakingMoves" params:params requestType:RANDOME_DONEMAKINGMOVE withSuccess:success];
    return RANDOME_DONEMAKINGMOVE;
}


@end
