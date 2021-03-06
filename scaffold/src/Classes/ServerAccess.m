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
#import "IPManager.h"
#import "GameConfig.h"

@implementation ServerAccess

-(id) init{
    self = [super init];
    if(self) {
        reactor = [[ClientReactor alloc] initWithProperties];
        
        NSDictionary *mainDictionary = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"server_config" ofType:@"plist"]];
        ipAddress = [mainDictionary objectForKey:@"ip_address"];
        port=[mainDictionary objectForKey:@"port"];
        
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


-(void) asynchronousRequestOfType: (HttpRequestMethods) method toUrl: (NSString*) req withParams: (NSMutableDictionary*) params  andDelegateListener: (id) delegateListener andErrorCall:(block_t) errorCall andSuccessCall: (block_t) successCall{
    
    // Always send hostname and port number that we are listneing on
    [params setValue:[IPManager getIPAddress: YES] forKey:@"hostName"];
    [params setValue:@"3004" forKey:@"port"];
    
    NSString *postBody = [Utils httpParamsFromDictionary:params];
    NSLog(@"Doing post:%@ with params: %@", req, postBody);
    NSData *postData = [postBody dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    
    
    
    NSString *targetUrl = [NSString stringWithFormat:@"http://%@:%@/KingsNThings/%@", ipAddress, port, req];
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
                  responseMessage = [Utils serverResponseMessageFromJSONData:data];
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
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObjectsAndKeys: username,@"username",password,@"password", nil];
    [self asynchronousRequestOfType:POSTREQUEST toUrl:@"account/login" withParams:dic andDelegateListener: delegateListener andErrorCall:^{
        NSLog(@"Error doing login post request");
        [delegateListener didLoginWithSuccess:NO andError:nil];
    } andSuccessCall:nil];
}

-(void) logout{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObjectsAndKeys: nil];
    [self asynchronousRequestOfType:POSTREQUEST toUrl:@"account/logout" withParams:dic andDelegateListener: nil andErrorCall:^{
        NSLog(@"Error doing logout request");
    } andSuccessCall:nil];
}

-(void) registerAndLoginWithUsername: (NSString*) username andPassword: (NSString*) password andDelegateListener:(id<LoginProtocol>)delegateListener{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObjectsAndKeys: username,@"username",password,@"password", nil];
    [self asynchronousRequestOfType:POSTREQUEST toUrl:@"register" withParams:dic andDelegateListener: delegateListener andErrorCall:^{
        NSLog(@"Error doing login post request");
        [delegateListener didRegisterWithSuccess:NO andError:nil];
    } andSuccessCall:nil];
}

-(void) findAnyLobby: (int) numberPreferredPlayers andDelegateListener: (id<LobbyProtocol>) delegateListener{
    NSString *isDemo = @"false";
    if([GameConfig isDemo]) {
        isDemo = @"true";
    }
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObjectsAndKeys: [NSString stringWithFormat:@"%d", numberPreferredPlayers] , @"numberOfPreferredPlayers", isDemo, @"isDemo", nil];
    [self handleJoinLobbyWithParams:dic type:@"joinLobby" delegateListener:delegateListener];
}

-(void) searchLobby: (NSString*) usernameOfHost andDelegateListener: (id<LobbyProtocol>) delegateListener{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObjectsAndKeys: usernameOfHost , @"usernameOfHost", nil];
    [self handleJoinLobbyWithParams:dic type:@"searchLobby" delegateListener:delegateListener];
}

-(void) hostLobby: (int) numberPreferredPlayers andDelegateListener: (id<LobbyProtocol>) delegateListener{
    NSString *isDemo = @"false";
    if([GameConfig isDemo]) {
        isDemo = @"true";
    }
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObjectsAndKeys: [NSString stringWithFormat:@"%d", numberPreferredPlayers] , @"numberOfPreferredPlayers", isDemo, @"isDemo", nil];
    [self handleJoinLobbyWithParams:dic type:@"hostLobby" delegateListener:delegateListener];
}

-(void) handleJoinLobbyWithParams: (NSMutableDictionary*) params type: (NSString*) type delegateListener: (id<LobbyProtocol>) delegateListener {
    [self asynchronousRequestOfType:POSTREQUEST toUrl:[NSString stringWithFormat:@"lobby/%@",type] withParams:params andDelegateListener: delegateListener andErrorCall:^{
        NSLog(@"Error joining a lobby");
        [delegateListener didStartSearchingForLobbyAndWasError:YES];
    } andSuccessCall:^{
        NSLog(@"Returned success from server when telling it we want to join a lobby, UDP messages should now be sent once we are in one");
        [delegateListener didStartSearchingForLobbyAndWasError:NO];
    }];
}

-(void) unregisterFromLobby{
    [self asynchronousRequestOfType:POSTREQUEST toUrl:@"lobby/unregisterFromLobby" withParams:[[NSMutableDictionary alloc] init] andDelegateListener: nil andErrorCall:^{
    } andSuccessCall:^{
        NSLog(@"Unregistered from lobby");
    }];
}

-(void) getLobbyState : (NSString*) gameLobbyId{
    [self asynchronousRequestOfType:POSTREQUEST toUrl:@"lobby/getLobbyState" withParams:[[NSMutableDictionary alloc] initWithObjectsAndKeys: gameLobbyId, @"gameLobbyId", nil] andDelegateListener: nil andErrorCall:^{
        NSLog(@"Error getting lobby state");
    } andSuccessCall:nil];
}

-(void) leaveGame{
    [self asynchronousRequestOfType:POSTREQUEST toUrl:@"game/leaveGame" withParams:[[NSMutableDictionary alloc] init] andDelegateListener: nil andErrorCall:^{
        NSLog(@"Error leaving game");
    } andSuccessCall:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"gameOver" object:nil];
        });
    }];
}

-(void) getNewMessagesFrom: (NSDate*) date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss.SSS"];
    
    NSString *lastDate = [dateFormatter stringFromDate:date];
    NSLog(@"Getting messages since  %@", lastDate);
    
    [self asynchronousRequestOfType:POSTREQUEST toUrl:@"messages/newMessages" withParams:[[NSMutableDictionary alloc] initWithObjectsAndKeys:lastDate, @"lastMessageDate", nil] andDelegateListener: nil andErrorCall:^{
        NSLog(@"Error getting new messages");
    } andSuccessCall:nil];
}

-(void) getQueuedMessage{
    [self asynchronousRequestOfType:POSTREQUEST toUrl:@"messages/queuedMessages" withParams:[[NSMutableDictionary alloc] init] andDelegateListener: nil andErrorCall:^{
        NSLog(@"Error getting new messages");
    } andSuccessCall:nil];
}

-(void) tellServerWeGotMessage: (NSString*) messageId {
    [self asynchronousRequestOfType:POSTREQUEST toUrl:@"messages/gotMessage" withParams:[[NSMutableDictionary alloc] initWithObjectsAndKeys: messageId, @"messageId", nil] andDelegateListener: nil andErrorCall:^{
        NSLog(@"Error telling server we got new message");
    } andSuccessCall:^{
        NSLog(@"Told server that we got message with id [%@]", messageId);
    }];
}




@end
