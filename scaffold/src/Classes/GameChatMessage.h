//
//  GameChatMessage.h
//  3004iPhone
//
//  Created by Devin Lynch on 2014-03-14.
//
//

#import <Foundation/Foundation.h>
#import "JSONSerializable.h"

@class User;

@interface GameChatMessage : NSObject<JSONSerializable>
{
    NSString* _gameChatMessageId;
    NSString* _message;
    NSDate * _createdDate;
    User *_user;
}

@property NSString *gameChatMessageId, *message;
@property NSDate *createdDate;
@property User *user;



@end
