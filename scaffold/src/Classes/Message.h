//
//  Message.h
//  COMP2601class18
//
//  Created by John Marsh on 13-03-28.
//  Copyright (c) 2013 John Marsh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Message : NSObject

@property NSMutableDictionary *head, *body;

-(Message *)initWithType:(NSString*)type;
-(Message *)initFromJSON:(NSData*)data;
-(NSData*)toJSON;

@end
