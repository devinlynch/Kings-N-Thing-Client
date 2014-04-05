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
#import "Game.h"
#import "ServerAccess.h"
#import "SentMessage.h"

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
    Message *responseMessage;
    @try {
        NSDictionary *json = [Utils dictionaryFromJSONData:data];
        
        
        if([json objectForKey:@"responseStatus"] == nil){
            responseMessage = [[GameMessage alloc] initFromJSON:json];
            NSString *gameId = [json objectForKey:@"gameId"];
            if( ! [[[Game currentGame] gameID] isEqualToString:gameId] ){
                NSLog(@"We got a message with game id [%@] but our current game id is [%@] so we're ignoring it", gameId, [[Game currentGame] gameID]);
                return;
            }
        } else{
            responseMessage = [[ServerResponseMessage alloc] initFromJSON:json];
        }
        
        if(responseMessage == nil) {
            // TODO: How do we want to handle a bad reponse?
            return;
        }
        
        NSMutableSet *receivedMessageIds =[MessageHandler receivedMessageIdsInstance];
        if([receivedMessageIds containsObject:responseMessage.messageId]) {
            NSLog(@"Got a duplicate message id [%@], not handling", responseMessage.messageId);
            return;
        }
        
        [self didHandleMessage:responseMessage];
        
        Event *e = [[Event alloc] initForType:responseMessage.type withMessage:responseMessage];
        [e setRequestParams:params];
        [e setDelegateListener:delegate];
        [e setReceivedMessageType:HTTP_MESSAGE_TYPE];
        [[ClientReactor instance] dispatch:e];
        
        
    } @catch (NSException *exception) {
        [self didNOTHandleMessage:responseMessage];
        NSLog(@"ERROR HANDLING MESSAGE:  %@", exception);
    }
}

+(void) handleUDPReceivedJSONData: (NSData*) data{
    NSDictionary *json = [Utils dictionaryFromJSONData:data];
    [self handleMessageFromMap:json];
}

+(void) handleMessageFromMap: (NSDictionary*) json{
    Message *responseMessage;
    @try {
        if([json objectForKey:@"responseStatus"] == nil){
            responseMessage = [[GameMessage alloc] initFromJSON:json];
            NSString *gameId = [json objectForKey:@"gameId"];
            if( ! [[[Game currentGame] gameID] isEqualToString:gameId] ){
                NSLog(@"We got a message with game id [%@] but our current game id is [%@] so we're ignoring it", gameId, [[Game currentGame] gameID]);
                return;
            }
        } else{
            responseMessage = [[ServerResponseMessage alloc] initFromJSON:json];
        }
        
        NSMutableSet *receivedMessageIds =[MessageHandler receivedMessageIdsInstance];
        if([receivedMessageIds containsObject:responseMessage.messageId]) {
            NSLog(@"Got a duplicate message id [%@], not handling", responseMessage.messageId);
            return;
        }
        
        [self didHandleMessage:responseMessage];
        
        Event *e = [[Event alloc] initForType:responseMessage.type withMessage:responseMessage];
        [e setReceivedMessageType:UDP_MESSAGE_TYPE];
        [[ClientReactor instance] dispatch:e];
        
    }
    @catch (NSException *exception) {
        [self didNOTHandleMessage:responseMessage];
        NSLog(@"ERROR HANDLING MESSAGE:  %@", exception);
    }
}

+(void) didHandleMessage: (Message*) message{
    if(message.messageId){
        [[MessageHandler receivedMessageIdsInstance] addObject:message.messageId];
        [[ServerAccess instance] tellServerWeGotMessage:message.messageId];
    }
    
}

+(void) didNOTHandleMessage: (Message*) message{
    if(message != nil && message.messageId){
        [[MessageHandler receivedMessageIdsInstance] removeObject:message.messageId];
    }
    
}

+(void) handleGetNewMessage {
    if([User instance] != nil)
        [[ServerAccess instance] getQueuedMessage];
}

// Message Queue
static NSMutableArray *queuedMessages;
+(NSMutableArray*) getQueuedMessages{
    if(queuedMessages == nil) {
        queuedMessages = [[NSMutableArray alloc] init];
    }
    return queuedMessages;
}

+(void) queueMessageToBeHandled: (SentMessage*) newMessage {
    @synchronized(self) {
        [SentMessage addMessage:newMessage toArrayInOrderByDate:[self getQueuedMessages]];
    }
}

+(void) handleMessageFromQueue{
    if([[self getQueuedMessages] count] <= 0) {
        return;
    }
    
    SentMessage *msg = [[self getQueuedMessages] objectAtIndex:0];
    [[self getQueuedMessages] removeObjectAtIndex:0];
    
    NSLog(@"Message Handler Queue - Handling message with ID [%@] from [%@]", msg.messageId, msg.date);
    [self handleMessageFromMap:msg.content];
}

+ (void) startMessageHandlerQueue
{
    [NSThread detachNewThreadSelector:@selector(startQueue) toTarget:[MessageHandler class] withObject:nil];
}

+(void) startQueue{
    while( ! [[NSThread currentThread] isCancelled] ) {
        [self handleMessageFromQueue];
        [NSThread sleepForTimeInterval:3.0f];
    }
}


@end
