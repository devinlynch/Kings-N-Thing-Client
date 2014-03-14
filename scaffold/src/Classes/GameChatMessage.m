//
//  GameChatMessage.m
//  3004iPhone
//
//  Created by Devin Lynch on 2014-03-14.
//
//

#import "GameChatMessage.h"

@implementation GameChatMessage

@synthesize gameChatMessageId = _gameChatMessageId;
@synthesize createdDate = _createdDate;
@synthesize message = _message;

-(id<JSONSerializable>)initFromJSON:(NSDictionary*) json{
    self=[super init];
    if(self && json != nil) {
        [self setGameChatMessageId:[json objectForKey:@"gameChatMessageId"]];
        [self setMessage:@"message"];
        
        if([json objectForKey:@"createdDate"] != nil) {
            
            NSString *ts = [[NSString alloc] initWithString:[json objectForKey:@"myPlayerId"]];
            NSInteger i = ts.integerValue;
            
            NSTimeInterval timestamp = i;
            NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestamp];
            
            [self setCreatedDate:date];
        }
    }
    return self;
}


@end
