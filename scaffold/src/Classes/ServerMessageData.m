//
//  HttpResponseData.m
//  3004iPhone
//
//  Created by Devin Lynch on 2014-01-21.
//
//

#import "ServerMessageData.h"

@implementation ServerMessageData
@synthesize map = _map;

-(id<JSONSerializable>)initFromJSON:(NSDictionary*) json {
    self = [self init];
    
    NSObject *o = [json objectForKey:@"map"];
    if([o isKindOfClass: [NSDictionary class]])
        self.map = [NSMutableDictionary dictionaryWithDictionary: (NSDictionary*) o];
    
    return self;
}

@end
