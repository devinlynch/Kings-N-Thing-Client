//
//  Utils.m
//  3004iPhone
//
//  Created by Devin Lynch on 2014-01-21.
//
//

#import "Utils.h"
#import "ServerResponseMessage.h"
#import "MBProgressHUD.h"
#import "GameMessage.h"
#import "Event.h"

@implementation Utils

+(NSDictionary*) dictionaryFromJSONData: (NSData* ) data{
    NSError *error;
    NSMutableDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    if (error != nil) {
        NSLog(@"Error parsing JSON: %@", error);
    }
    return json;
}

+(ServerResponseMessage*) serverResponseMessageFromJSONData: (NSData* ) data{
    NSDictionary *json = [self dictionaryFromJSONData:data];
    NSLog(@"Got json: %@", json);
    ServerResponseMessage *msg = nil;
    if(json != nil)
        msg = [[ServerResponseMessage alloc] initFromJSON:json];
    return msg;
}

+(GameMessage*) gameResponseMessageFromJSONData: (NSData* ) data{
    NSDictionary *json = [self dictionaryFromJSONData:data];
    NSLog(@"Got json: %@", json);
    GameMessage *msg = nil;
    if(json != nil)
        msg = [[GameMessage alloc] initFromJSON:json];
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

+(void) showAlertWithTitle: (NSString* ) title message: (NSString*) message delegate: (id) delegate cancelButtonTitle: (NSString*) cancelButtonTitle {
    runOnMainQueueWithoutDeadlocking(^{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:delegate
                                              cancelButtonTitle:cancelButtonTitle
                                              otherButtonTitles: nil];
        @try {
            [alert show];
        }
        @catch (NSException *exception) {
        }
        
    });
}

+(void) showLoaderOnView: (UIView*) view animated: (BOOL) animated{
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD showHUDAddedTo:view animated:animated];
    });
}

+(void) removeLoaderOnView: (UIView*) view animated: (BOOL) animated{
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:view animated:animated];
    });
}


+(NSDictionary*) getDataDictionaryFromGameMessageEvent: (Event*) event{
    GameMessage *message = (GameMessage*) event.msg;
    if (message == nil || message.jsonDictionnary == nil){
        NSLog(@"Message is nil or json dic is nil while getting data dic for type [%@]", event.type);
        return nil;
    }
    NSDictionary* dataDic = [message.jsonDictionnary objectForKey:@"data"];
    return dataDic;
}

+(void) notifyOnMainQueue: (NSString*) notificationName withObject: (id) object{
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:notificationName object:object];
    });
}

void runOnMainQueueWithoutDeadlocking(void (^block)(void))
{
    if ([NSThread isMainThread])
    {
        block();
    }
    else
    {
        dispatch_sync(dispatch_get_main_queue(), block);
    }
}

@end
