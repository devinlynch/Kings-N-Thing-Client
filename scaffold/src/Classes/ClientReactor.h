//
//  ClientReactor.h
//  Reactor
//
//  Created by Tony White on 12-03-22.
//  Copyright (c) 2012 Carleton University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReactorProtocol.h"

@interface ClientReactor : NSObject <ReactorProtocol>

@property(strong) NSMutableDictionary *handlers;

-(id)initWithProperties;
-(id)initWithDictionary: (NSDictionary*) dictionary;

@end
