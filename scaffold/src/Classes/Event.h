//
//  Event.h
//  Reactor
//
//  Created by Tony White on 12-03-22.
//  Copyright (c) 2012 Carleton University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Message.h"

@class Client;

typedef enum ReceivedMessageType{
    HTTP_MESSAGE_TYPE,
    UDP_MESSAGE_TYPE
} ReceivedMessageType;

@interface Event : NSObject

@property(strong) NSString *type;
@property(strong) Message  *msg;
@property(weak) id delegateListener;
@property(strong) NSDictionary *requestParams;
@property ReceivedMessageType receivedMessageType;


-(id) initForType: (NSString*)t withMessage:(Message*)m ;

@end
     