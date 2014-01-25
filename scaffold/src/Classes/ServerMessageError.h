//
//  HttpResponseError.h
//  3004iPhone
//
//  Created by Devin Lynch on 2014-01-21.
//
//

#import <Foundation/Foundation.h>
#import "JSONSerializable.h"

@interface ServerMessageError : NSObject<JSONSerializable>
{
    NSString* _responseError;
}

@property NSString* responseError;
@end
