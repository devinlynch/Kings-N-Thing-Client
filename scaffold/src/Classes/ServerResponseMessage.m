//
//  ResponseMessage.m
//  3004iPhone
//
//  Created by Devin Lynch on 2014-01-21.
//
//

#import "ServerResponseMessage.h"

@implementation ServerResponseMessage
@synthesize name=_name;
@synthesize responseStatus=_responseStatus;

-(id<JSONSerializable>)initFromJSON:(NSDictionary*) json {
    self = [self init];
    
    if(json == nil)
        return self;
    
    self.name = [json objectForKey:@"name"];
    self.type = [json objectForKey:@"type"];
    _messageId = [json objectForKey:@"messageId"];
    NSString *responseStatusNumberAsString = [json objectForKey:@"responseStatus"];
    self.responseStatus = [responseStatusNumberAsString integerValue];
    
    NSDictionary *dataDic = [json objectForKey:@"data"];
    if( dataDic != nil && [dataDic isKindOfClass:[NSDictionary class]])
    {
        self.data = [[ServerMessageData alloc] initFromJSON:dataDic];
    }
    
    NSDictionary *errorDic = [json objectForKey:@"error"];
    if( errorDic != nil && ([errorDic isKindOfClass:[NSDictionary class]]) )
    {
        self.error = [[ServerMessageError alloc] initFromJSON:errorDic];
    }
    
    return self;
}

@end
