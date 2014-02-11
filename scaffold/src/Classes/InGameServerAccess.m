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
    
    NSString *targetUrl = [NSString stringWithFormat:@"http://172.20.10.6:8080/KingsNThings/%@", req];
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
         
         if( responseMessage != nil ){
             [delegateListener didGetIngameResponseFromServerForRequest:requestType andResponse:responseMessage];
         } else{
             NSLog(@"could not connect to server, doing call, got response code: %d and error: %@", responseStatusCode, error);
             if(errorCall != nil)
                 errorCall();
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

-(void) phasePost: (NSString*) phase type: (NSString*) type params: (NSMutableDictionary*) params requestType: (InGameRequestTypes) requestType {
    [self asynchronousRequestOfType:POSTREQUEST toUrl:[NSString stringWithFormat:@"phase/%@/%@", phase, type] withParams:params andDelegateListener:delegateListener andErrorCall:^{
        [delegateListener didGetIngameResponseFromServerForRequest:requestType andResponse:nil];
    }andSuccessCall:nil andRequestType:requestType];
}

// Setup
-(enum InGameRequestTypes) setupPhaseReadyForPlacement{
    [self phasePost:@"setup" type:@"readyForPlacement" params:nil requestType:SETUPPHASE_readyForPlacement];
    
    return SETUPPHASE_readyForPlacement;
}

// Placement
-(enum InGameRequestTypes) placementPhasePlaceControlMarkersFirst: (NSString*) hexLocation1Id second: (NSString*) hexLocation2Id third: (NSString*) hexLocation3Id{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:hexLocation1Id forKey:@"hexLocation1"];
    [params setObject:hexLocation3Id forKey:@"hexLocation2"];
    [params setObject:hexLocation3Id forKey:@"hexLocation3"];
    
    [self phasePost:@"placement" type:@"placeControlMarker" params:params requestType:SETUPPHASE_readyForPlacement];

    return PLACEMENTPHASE_placeControlMarker;
}

-(enum InGameRequestTypes) placementPhasePlaceFort: (NSString*) hexLocationId{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:hexLocationId forKey:@"hexLocation"];
    
    [self phasePost:@"placement" type:@"placeFort" params:params requestType:PLACEMENTPHASE_placeFort];
    
    return PLACEMENTPHASE_placeFort;
}


// Gold Collection
-(enum InGameRequestTypes) goldCollectionPhaseDidCollectGold{
    [self phasePost:@"gold" type:@"didCollectGold" params:nil requestType:GOLDCOLLECTIONPHASE_didCollectGold];

    return GOLDCOLLECTIONPHASE_didCollectGold;
}


// Recruit Things
-(enum InGameRequestTypes) recruitThingsPhaseRecruited: (NSString*) thingId palcedOnLocation: (NSString*) locationId wasBought:(BOOL) wasBought{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:thingId forKey:@"thingId"];
    [params setObject:locationId forKey:@"locationId"];
    [params setObject:wasBought == true ? @"true" : @"false" forKey:@"wasBought"];
    
    [self phasePost:@"recruitThings" type:@"recruitedAndPlacedThing" params:params requestType:RECRUITTHINGSPHASE_recruitedAndPlacedThing];
    
    return RECRUITTHINGSPHASE_recruitedAndPlacedThing;
}

-(enum InGameRequestTypes) recruitThingsPhaseReadyForNextPhase{
    [self phasePost:@"recruitThings" type:@"readyForNextPhase" params:nil requestType:RECRUITTHINGSPHASE_readyForNextPhase];

    return RECRUITTHINGSPHASE_readyForNextPhase;
}

// Movement
-(enum InGameRequestTypes) movementPhaseMoveStack: (NSString*) stackId toHex: (NSString*) hexLocationId{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:hexLocationId forKey:@"hexLocationId"];
    [params setObject:stackId forKey:@"stackId"];
    
    [self phasePost:@"movement" type:@"moveStack" params:params requestType:MOVEMENTPHASE_moveStack];
    
    return MOVEMENTPHASE_moveStack;
}

-(enum InGameRequestTypes) movementPhaseMoveGamePiece: (NSString*) gamePieceId toLocation: (NSString*) locationId{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:locationId forKey:@"locationId"];
    [params setObject:gamePieceId forKey:@"gamePieceId"];
    
    [self phasePost:@"movement" type:@"moveGamePiece" params:params requestType:MOVEMENTPHASE_moveGamePiece];
    
    return MOVEMENTPHASE_moveGamePiece;
}

-(enum InGameRequestTypes) movementPhaseCreateStack: (NSString*) hexLocationId withPieces: (NSArray*) gamePieceIds{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:hexLocationId forKey:@"hexLocationId"];
    
    int i = 1;
    for(NSString *gamePieceId in gamePieceIds) {
        [params setObject:gamePieceId forKey:[NSString stringWithFormat:@"gamePiece_%d", i]];
        i++;
    }
    
    [self phasePost:@"movement" type:@"createStack" params:params requestType:MOVEMENTPHASE_createStack];
    
    return MOVEMENTPHASE_createStack;
}

-(enum InGameRequestTypes) movementPhaseAddPiecesToStack: (NSString*) stackId pieces: (NSArray*) gamePieceIds{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:stackId forKey:@"stackId"];
    
    int i = 1;
    for(NSString *gamePieceId in gamePieceIds) {
        [params setObject:gamePieceId forKey:[NSString stringWithFormat:@"gamePiece_%d", i]];
        i++;
    }
    
    [self phasePost:@"movement" type:@"addPiecesToStack" params:params requestType:MOVEMENTPHASE_addPiecesToStack];
    
    return MOVEMENTPHASE_addPiecesToStack;
}

-(enum InGameRequestTypes) movementPhaseDoneMakingMoves{
    [self phasePost:@"movement" type:@"playerIsDoneMakingMoves" params:nil requestType:MOVEMENTPHASE_playerIsDoneMakingMoves];

    return MOVEMENTPHASE_playerIsDoneMakingMoves;
}


@end
