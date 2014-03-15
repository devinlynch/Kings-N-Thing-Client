//
//  MessagesEventHandler.m
//  3004iPhone
//
//  Created by Devin Lynch on 2014-03-15.
//
//

#import "MessagesEventHandler.h"
#import "Event.h"
#import "MessageHandler.h"
#import "SentMessage.h"

@implementation MessagesEventHandler

-(void) handleNewMessages:(Event*) event{
    if(event.msg.data == nil || event.msg.data.map == nil) {
        NSLog(@"Error, for some reason data map is nil in handleNewMessages");
    }
    
    NSArray* arr = [event.msg.data.map objectForKey:@"messages"];
    
    NSLog(@"Handling new batch of messages received");
    
    for(id o in arr) {
        if(![o isKindOfClass:[NSDictionary class]]){
            continue;
        }
        
        NSDictionary *dic = (NSDictionary*) o;
        NSString *jsonString = [dic objectForKey:@"json"];
        NSError *e;
        NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData: [jsonString dataUsingEncoding:NSUTF8StringEncoding]
                                        options: NSJSONReadingMutableContainers
                                          error: &e];
        SentMessage *message = [[SentMessage alloc] init];
        [message setContent:JSON];
        [message setMessageId:[dic objectForKey:@"messageId"]];
        
        NSNumber* ts = [dic objectForKey:@"sentDate"];
        if(ts != nil)
            [message setDate:[NSDate dateWithTimeIntervalSince1970:ts.integerValue/1000]];
        
        if(JSON == nil)
            continue;
        
        [MessageHandler queueMessageToBeHandled:message];
    }
}


@end
