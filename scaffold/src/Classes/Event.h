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

@interface Event : NSObject

@property(strong) NSString *type;
@property(strong) Message  *msg;


-(id) initForType: (NSString*)t withMessage:(Message*)m ;

@end
     