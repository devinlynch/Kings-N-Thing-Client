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
#import "MessageHandler.h"

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

-(void) asynchronousRequestOfType: (HttpRequestMethods) method toUrl: (NSString*) req withParams: (NSDictionary*) params  andDelegateListener: (id) delegateListener andErrorCall:(block_t) errorCall andSuccessCall: (block_t) successCall{
    NSString *postBody = [Utils httpParamsFromDictionary:params];
    NSLog(@"Doing post:%@ with params: %@", req, postBody);
    NSData *postData = [postBody dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSString *targetUrl = [NSString stringWithFormat:@"http://localhost:5000/KingsNThings/%@", req];
    NSURL *url = [NSURL URLWithString:targetUrl];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod: [self httpethodToString:method]];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:postData];
    [request setTimeoutInterval:20];
    //TODO: handle timeout
    NSOperationQueue *queue =[[NSOperationQueue alloc] init];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:queue
                           completionHandler:
     ^(NSURLResponse *response, NSData *data, NSError *error) {
         
         NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
         int responseStatusCode = [httpResponse statusCode];
         
         ServerResponseMessage *responseMessage;
         if(data != nil && responseStatusCode == 200 && error == nil){
             @try{
                  responseMessage = [Utils responseMessageFromJSONData:data];
             } @catch (NSException *e) {
                 NSLog(@"Error parsing response message: %@", e);
             }
         }
         
         // TODO SOMEHOW HANDLE ERRORS LIKE NOT LOGGED IN
         
         if( responseMessage != nil ){
             if(successCall != nil){
                 successCall();
             } else{
                 [MessageHandler handleHttpResponseJSONData:data delegate:delegateListener requestParams:params];
             }
         } else{
             NSLog(@"could not connect to server, doing call, got response code: %d and error: %@", responseStatusCode, error);
             if(errorCall != nil)
                 errorCall();
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
    } andSuccessCall:nil];
}

-(void) registerAndLoginWithUsername: (NSString*) username andPassword: (NSString*) password andDelegateListener:(id<LoginProtocol>)delegateListener{
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys: username,@"username",password,@"password", nil];
    [self asynchronousRequestOfType:POSTREQUEST toUrl:@"register" withParams:dic andDelegateListener: delegateListener andErrorCall:^{
        NSLog(@"Error doing login post request");
        [delegateListener didRegisterWithSuccess:NO andError:nil];
    } andSuccessCall:nil];
}

-(void) findAnyLobby: (int) numberPreferredPlayers andDelegateListener: (id<LobbyProtocol>) delegateListener{
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys: [NSString stringWithFormat:@"%d", numberPreferredPlayers] , @"numberOfPreferredPlayers", nil];
    [self handleJoinLobbyWithParams:dic type:@"joinLobby" delegateListener:delegateListener];
}

-(void) searchLobby: (NSString*) usernameOfHost andDelegateListener: (id<LobbyProtocol>) delegateListener{
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys: usernameOfHost , @"usernameOfHost", nil];
    [self handleJoinLobbyWithParams:dic type:@"searchLobby" delegateListener:delegateListener];
}

-(void) hostLobby: (int) numberPreferredPlayers andDelegateListener: (id<LobbyProtocol>) delegateListener{
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys: [NSString stringWithFormat:@"%d", numberPreferredPlayers] , @"numberOfPreferredPlayers", nil];
    [self handleJoinLobbyWithParams:dic type:@"hostLobby" delegateListener:delegateListener];
}

-(void) handleJoinLobbyWithParams: (NSDictionary*) params type: (NSString*) type delegateListener: (id<LobbyProtocol>) delegateListener {
    [self asynchronousRequestOfType:POSTREQUEST toUrl:[NSString stringWithFormat:@"lobby/%@",type] withParams:params andDelegateListener: delegateListener andErrorCall:^{
        NSLog(@"Error joining a lobby");
        [delegateListener didStartSearchingForLobbyAndWasError:YES];
    } andSuccessCall:^{
        NSLog(@"Returned success from server when telling it we want to join a lobby, UDP messages should now be sent once we are in one");
        [delegateListener didStartSearchingForLobbyAndWasError:NO];
    }];
}

@end
