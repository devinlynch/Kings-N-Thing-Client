//
//  HttpResponseError.m
//  3004iPhone
//
//  Created by Devin Lynch on 2014-01-21.
//
//

#import "ServerMessageError.h"

@implementation ServerMessageError

@synthesize responseError=_responseError;

-(id<JSONSerializable>)initFromJSON:(NSDictionary*) json {
    self = [self init];
    
    NSString *responseErrorNumberAsString = [json objectForKey:@"responseError"];
    self.responseError = [responseErrorNumberAsString integerValue];
    
    return self;
}

@end
