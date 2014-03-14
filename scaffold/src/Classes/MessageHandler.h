//
//  MessageHandler.h
//  3004iPhone
//
//  Created by Devin Lynch on 2014-01-25.
//
//

#import <Foundation/Foundation.h>

@interface MessageHandler : NSObject

+(void) handleHttpResponseJSONData: (NSData*) data delegate: (id) delegate requestParams: (NSDictionary*) params;
+(void) handleUDPReceivedJSONData: (NSData*) data;
+(void) handleGetNewMessage;


@end
