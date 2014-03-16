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
    
    NSMutableArray *messages = [[NSMutableArray alloc] init];
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
        if(JSON == nil)
            continue;
        if(ts != nil){
            double milliseconds = ts.integerValue/1000.0;
            [message setDate:[NSDate dateWithTimeIntervalSince1970:milliseconds]];
            /*double timestamp = [message.date timeIntervalSince1970];
            int64_t timeInMilisInt64 = (int64_t)(timestamp*1000);
            NSLog(@"%@", timeInMilisInt64);*/
        }
        
        
        
        [SentMessage addMessage:message toArrayInOrderByDate:messages];
    }
    
    for(SentMessage *sm in messages) {
        [MessageHandler queueMessageToBeHandled:sm];
    }
}


@end
