//
//  Message.m
//  COMP2601class18
//
//  Created by John Marsh on 13-03-28.
//  Copyright (c) 2013 John Marsh. All rights reserved.
//

#import "Message.h"


@implementation Message

@synthesize head;
@synthesize body;


-(Message*) init{
    head = [[NSMutableDictionary alloc] init];
    body = [[NSMutableDictionary alloc] init];
    return [super init];
}

-(Message *)initWithType:(NSString*)type{
    head = [[NSMutableDictionary alloc] initWithObjectsAndKeys:type, @"type", nil];
    body = [[NSMutableDictionary alloc] init];
    return [super init];
}

-(Message *)initFromJSON:(NSData*)data {
    Message *msg = [[Message alloc] init];
    NSError *error;
    NSMutableDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    NSLog(@"JSON DATA: %@", json);
    
    msg.head = json;
    msg.body = json;
    
    return msg;
}

-(NSData*)toJSON{
    NSMutableDictionary *msg = [[NSMutableDictionary alloc] initWithObjectsAndKeys:self.head, @"head",self.body, @"body", nil];
    NSError *error;
    NSData *data = [NSJSONSerialization dataWithJSONObject:msg options:NSJSONWritingPrettyPrinted error:&error];
    
    return data;
}



@end
