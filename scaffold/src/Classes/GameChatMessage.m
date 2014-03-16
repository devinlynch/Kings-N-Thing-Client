//
//  GameChatMessage.m
//  3004iPhone
//
//  Created by Devin Lynch on 2014-03-14.
//
//

#import "GameChatMessage.h"
#import "Game.h"

@implementation GameChatMessage

@synthesize gameChatMessageId = _gameChatMessageId;
@synthesize createdDate = _createdDate;
@synthesize message = _message;
@synthesize user = _user;

-(id<JSONSerializable>)initFromJSON:(NSDictionary*) json{
    self=[super init];
    if(self && json != nil) {
        [self setGameChatMessageId:[json objectForKey:@"gameChatMessageId"]];
        [self setMessage:[json objectForKey:@"message"]];
        
        NSNumber* ts = [json objectForKey:@"createdDate"];
        if(ts != nil){
            double seconds = ts.integerValue/1000.0;
            [self setCreatedDate:[NSDate dateWithTimeIntervalSince1970:seconds]];
        }
        
        User *u = [[Game currentGame] getUserByUserId:[json objectForKey:@"userId"]];
        [self setUser: u];
    }
    
    return self;
}


@end
