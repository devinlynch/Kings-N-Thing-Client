//
//  SentMessage.h
//  3004iPhone
//
//  Created by Devin Lynch on 2014-03-15.
//
//

#import <Foundation/Foundation.h>

@interface SentMessage : NSObject
{
    NSString *_messageId;
    NSDate *_date;
    NSDictionary *_content;
}

@property NSString *messageId;
@property NSDate *date;
@property NSDictionary *content;

@end
