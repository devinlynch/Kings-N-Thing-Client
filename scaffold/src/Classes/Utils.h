//
//  Utils.h
//  3004iPhone
//
//  Created by Devin Lynch on 2014-01-21.
//
//

#import <Foundation/Foundation.h>
@class ServerResponseMessage;

@interface Utils : NSObject

+(NSDictionary*) dictionaryFromJSONData: (NSData* ) data;
+(ServerResponseMessage*) responseMessageFromJSONData: (NSData* ) data;
+(NSString*) httpParamsFromDictionary: (NSDictionary*) dict;

@end
