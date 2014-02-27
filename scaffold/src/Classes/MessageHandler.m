//
//  MessageHandler.m
//  3004iPhone
//
//  Created by Devin Lynch on 2014-01-25.
//
//

#import "MessageHandler.h"
#import "Utils.h"
#import "Event.h"
#import "ServerResponseMessage.h"
#import "GameMessage.h"
#import "ClientReactor.h"

@implementation MessageHandler

+(void) handleReceivedJSONData: (NSData*) data{
    
}

static NSMutableSet* receivedMessageIds;

+(NSMutableSet*) receivedMessageIdsInstance{
    if(receivedMessageIds == nil)
        receivedMessageIds = [[NSMutableSet alloc] init];
    return receivedMessageIds;
}

+(void) handleHttpResponseJSONData: (NSData*) data delegate: (id) delegate requestParams: (NSDictionary*) params{
    
    NSDictionary *json = [Utils dictionaryFromJSONData:data];
    
    Message *responseMessage;
    if([json objectForKey:@"responseStatus"] == nil){
        responseMessage = [[GameMessage alloc] initFromJSON:json];
    } else{
        responseMessage = [[ServerResponseMessage alloc] initFromJSON:json];
    }
    
    if(responseMessage == nil) {
        // TODO: How do we want to handle a bad reponse?
    }
    
    if([[MessageHandler receivedMessageIdsInstance] containsObject:responseMessage.messageId]) {
        NSLog(@"Got a duplicate message id [%@], not handling", responseMessage.messageId);
        return;
    }
    
    Event *e = [[Event alloc] initForType:responseMessage.type withMessage:responseMessage];
    [e setRequestParams:params];
    [e setDelegateListener:delegate];
    [e setReceivedMessageType:HTTP_MESSAGE_TYPE];
    [[ClientReactor instance] dispatch:e];
}

+(void) handleUDPReceivedJSONData: (NSData*) data{
    NSDictionary *json = [Utils dictionaryFromJSONData:data];
    

    Message *responseMessage;
    
    
    if([json objectForKey:@"responseStatus"] == nil){
        responseMessage = [[GameMessage alloc] initFromJSON:json];
    } else{
        responseMessage = [[ServerResponseMessage alloc] initFromJSON:json];
    }
    
    if([[MessageHandler receivedMessageIdsInstance] containsObject:responseMessage.messageId]) {
        NSLog(@"Got a duplicate message id [%@], not handling", responseMessage.messageId);
        return;
    }

    Event *e = [[Event alloc] initForType:responseMessage.type withMessage:responseMessage];
    [e setReceivedMessageType:UDP_MESSAGE_TYPE];
    [[ClientReactor instance] dispatch:e];
}


@end
