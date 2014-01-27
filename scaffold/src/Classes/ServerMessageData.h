//
//  HttpResponseData.h
//  3004iPhone
//
//  Created by Devin Lynch on 2014-01-21.
//
//

#import <Foundation/Foundation.h>
#import "JSONSerializable.h"
@interface ServerMessageData : NSObject <JSONSerializable> {
    NSMutableDictionary* _map;
}

@property NSMutableDictionary *map;

@end
