//
//  ServerAccess.m
//  3004iPhone
//
//  Created by Devin Lynch on 2014-01-21.
//
//

#import "ServerAccess.h"
#import "ClientReactor.h"
#import "ServerResponseMessage.h"
#import "Utils.h"
#import "Event.h"

@implementation ServerAccess

-(id) init{
    self = [super init];
    if(self) {
        reactor = [[ClientReactor alloc] initWithProperties];
        return self;
    }
    return nil;
}

static ServerAccess *instance;

+(ServerAccess*) instance{
    @synchronized(self){
        if(!instance)
            instance = [[ServerAccess alloc] init];
    }
    return instance;
}


typedef enum HttpRequestMethods {
    POSTREQUEST,
    GETREQUEST
} HttpRequestMethods;

-(void) asynchronousRequestOfType: (HttpRequestMethods) method toUrl: (NSString*) req withParams: (NSDictionary*) params  andDelegateListener: (id) delegateListener andErrorCall:(block_t) call{
    NSString *postBody = [Utils httpParamsFromDictionary:params];
    NSLog(@"Doing post:%@ with params: %@", req, postBody);
    NSData *postData = [postBody dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSString *targetUrl = [NSString stringWithFormat:@"http://localhost:8080/KingsNThings/%@", req];
    NSURL *url = [NSURL URLWithString:targetUrl];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod: [self httpethodToString:method]];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:postData];
    [request setTimeoutInterval:20];
    //TODO: handle timeout
    NSOperationQueue *queue =[[NSOperationQueue alloc] init];
    
    __block block_t theCall = call;
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:queue
                           completionHandler:
     ^(NSURLResponse *response, NSData *data, NSError *error) {
         
         NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
         int responseStatusCode = [httpResponse statusCode];
         
         if(responseStatusCode == 200 && data != nil && error == nil){
             ServerResponseMessage *responseMessage = [Utils responseMessageFromJSONData:data];
             
             if(responseMessage == nil) {
                 // TODO: How do we want to handle a bad reponse?
             }
             Event *e = [[Event alloc] initForType:responseMessage.type withMessage:responseMessage];
             [e setRequestParams:params];
             [e setDelegateListener:delegateListener];
             [reactor dispatch:e];
         } else{
             NSLog(@"could not connect to server, doing call, got response code: %d and error: %@", responseStatusCode, error);
             if(theCall != nil)
                 theCall();
         }
         
     }];
}

-(NSString*) httpethodToString: (HttpRequestMethods) method {
    if(method == GETREQUEST) {
        return @"GET";
    } else{
        return @"POST";
    }
}

-(void) loginWithUsername: (NSString*) username andPassword: (NSString*) password andDelegateListener:(id<LoginProtocol>)delegateListener{
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys: username,@"username",password,@"password", nil];
    [self asynchronousRequestOfType:POSTREQUEST toUrl:@"account/login" withParams:dic andDelegateListener: delegateListener andErrorCall:^{
        NSLog(@"Error doing login post request");
        [delegateListener didLoginWithSuccess:NO andError:nil];
    }];
}

-(void) registerAndLoginWithUsername: (NSString*) username andPassword: (NSString*) password andDelegateListener:(id<LoginProtocol>)delegateListener{
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys: username,@"username",password,@"password", nil];
    [self asynchronousRequestOfType:POSTREQUEST toUrl:@"register" withParams:dic andDelegateListener: delegateListener andErrorCall:^{
        NSLog(@"Error doing login post request");
        [delegateListener didRegisterWithSuccess:NO andError:nil];
    }];
}

@end
