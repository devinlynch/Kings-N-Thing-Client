//
//  HttpResponseError.h
//  3004iPhone
//
//  Created by Devin Lynch on 2014-01-21.
//
//

#import <Foundation/Foundation.h>
#import "JSONSerializable.h"
typedef enum ResponseError {
    BAD_USERNAME_AND_PASSWORD,
    ALREADY_LOGGED_IN,
    ALREADY_REGISTERED,
    GENERIC_ERROR,
    NOT_LOGGED_IN
} ResponseError;

@interface ServerMessageError : NSObject<JSONSerializable>
{
    NSInteger _responseError;
}

@property NSInteger responseError;
@end
