//
//  SentMessage.m
//  3004iPhone
//
//  Created by Devin Lynch on 2014-03-15.
//
//

#import "SentMessage.h"

@implementation SentMessage
@synthesize messageId=_messageId;
@synthesize date=_date;
@synthesize content=_content;

+(void) addMessage: (SentMessage*) newMessage toArrayInOrderByDate: (NSMutableArray*) arr{
    BOOL didAdd=NO;
    for(int i=0; i< [arr count]; i++) {
        SentMessage *msg = [arr objectAtIndex:i];
        if([newMessage.date compare:msg.date] == NSOrderedAscending) {
            [arr insertObject:newMessage atIndex:i];
            didAdd = YES;
            break;
        }
    }
    if(!didAdd) {
        [arr addObject:newMessage];
    }
}

@end
