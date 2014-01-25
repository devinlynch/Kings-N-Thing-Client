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
#import "ClientReactor.h"

@implementation MessageHandler

+(void) handleReceivedJSONData: (NSData*) data{
    
}

+(void) handleHttpResponseJSONData: (NSData*) data delegate: (id) delegate requestParams: (NSDictionary*) params{
    ServerResponseMessage *responseMessage = [Utils responseMessageFromJSONData:data];
    
    if(responseMessage == nil) {
        // TODO: How do we want to handle a bad reponse?
    }
    Event *e = [[Event alloc] initForType:responseMessage.type withMessage:responseMessage];
    [e setRequestParams:params];
    [e setDelegateListener:delegate];
    [e setReceivedMessageType:HTTP_MESSAGE_TYPE];
    [[ClientReactor instance] dispatch:e];
}

+(void) handleUDPReceivedJSONData: (NSData*) data{
    ServerResponseMessage *responseMessage = [Utils responseMessageFromJSONData:data];
    
    if(responseMessage == nil) {
        // TODO: How do we want to handle a bad reponse?
    }
    Event *e = [[Event alloc] initForType:responseMessage.type withMessage:responseMessage];
    [e setReceivedMessageType:UDP_MESSAGE_TYPE];
    [[ClientReactor instance] dispatch:e];
}


@end
