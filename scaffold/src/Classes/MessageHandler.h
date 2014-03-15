//
//  MessageHandler.h
//  3004iPhone
//
//  Created by Devin Lynch on 2014-01-25.
//
//

#import <Foundation/Foundation.h>

@class SentMessage;

@interface MessageHandler : NSObject

+(void) handleHttpResponseJSONData: (NSData*) data delegate: (id) delegate requestParams: (NSDictionary*) params;
+(void) handleUDPReceivedJSONData: (NSData*) data;
+(void) handleGetNewMessage;
+(void) handleMessageFromMap: (NSDictionary*) json;
+(NSMutableArray*) getQueuedMessages;
+(void) queueMessageToBeHandled: (SentMessage*) json;
+(void) handleMessageFromQueue;
+ (void) startMessageHandlerQueue;

@end
