//
//  Message.h
//  COMP2601class18
//
//  Created by John Marsh on 13-03-28.
//  Copyright (c) 2013 John Marsh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ServerMessageError.h"
#import "ServerMessageData.h"

@interface Message : NSObject
{
    ServerMessageData *_data;
    ServerMessageError *_error;
    NSString *_type;
    NSDate *_createdDate;
}

@property NSString *type;
@property NSDate *createdDate;

@property ServerMessageError *error;
@property ServerMessageData *data;

@end
