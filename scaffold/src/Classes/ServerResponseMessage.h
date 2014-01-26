//
//  ResponseMessage.h
//  3004iPhone
//
//  Created by Devin Lynch on 2014-01-21.
//
//

#import <Foundation/Foundation.h>
#import "JSONSerializable.h"
#import "Message.h"

enum ResponseStatus{
    OK_REQUEST =1,
    INVALID_REQUEST =2
} ResponseStatus;

@interface ServerResponseMessage : Message <JSONSerializable>
{
    NSString* _name;
    NSInteger _responseStatus;
}

@property NSString *name;
@property NSInteger responseStatus;

@end
