//
//  Utils.h
//  3004iPhone
//
//  Created by Devin Lynch on 2014-01-21.
//
//

#import <Foundation/Foundation.h>
@class ServerResponseMessage;
@class GameMessage;
@class Event;

@interface Utils : NSObject

+(NSDictionary*) dictionaryFromJSONData: (NSData* ) data;
+(ServerResponseMessage*) serverResponseMessageFromJSONData: (NSData* ) data;
+(GameMessage*) gameResponseMessageFromJSONData: (NSData* ) data;
+(NSString*) httpParamsFromDictionary: (NSDictionary*) dict;
+(void) showAlertWithTitle: (NSString* ) title message: (NSString*) message delegate: (id) delegate cancelButtonTitle: (NSString*) cancelButtonTitle;
+(void) showLoaderOnView: (UIView*) view animated: (BOOL) animated;
+(void) removeLoaderOnView: (UIView*) view animated: (BOOL) animated;
+(NSDictionary*) getDataDictionaryFromGameMessageEvent: (Event*) event;

@end
