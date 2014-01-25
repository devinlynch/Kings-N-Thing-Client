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
+(void) showAlertWithTitle: (NSString* ) title message: (NSString*) message delegate: (id) delegate cancelButtonTitle: (NSString*) cancelButtonTitle;
+(void) showLoaderOnView: (UIView*) view animated: (BOOL) animated;
+(void) removeLoaderOnView: (UIView*) view animated: (BOOL) animated;
@end
