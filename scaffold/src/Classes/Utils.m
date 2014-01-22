//
//  Utils.m
//  3004iPhone
//
//  Created by Devin Lynch on 2014-01-21.
//
//

#import "Utils.h"
#import "ServerResponseMessage.h"

@implementation Utils

+(NSDictionary*) dictionaryFromJSONData: (NSData* ) data{
    NSError *error;
    NSMutableDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    return json;
}

+(ServerResponseMessage*) responseMessageFromJSONData: (NSData* ) data{
    NSDictionary *json = [self dictionaryFromJSONData:data];
    
    ServerResponseMessage *msg = nil;
    if(json != nil)
        msg = [[ServerResponseMessage alloc] initFromJSON:json];
    return msg;
}

+(NSString*) httpParamsFromDictionary: (NSDictionary*) dict{
    NSString *returnS = @"";

    if(dict == nil)
        return returnS;
    
    NSArray *keyArray =  [dict allKeys];
    int count = [keyArray count];
    for (int i=0; i < count; i++) {
        id tmp = [dict objectForKey:[keyArray objectAtIndex:i]];
        
        if(i != count-1)
            returnS = [returnS stringByAppendingFormat:@"%@=%@&", [keyArray objectAtIndex:i], tmp];
        else
            returnS = [returnS stringByAppendingFormat:@"%@=%@", [keyArray objectAtIndex:i], tmp];
    }
    
    return returnS;
}

@end
