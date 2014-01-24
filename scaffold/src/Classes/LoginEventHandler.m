//
//  LoginEventHandler.m
//  3004iPhone
//
//  Created by Devin Lynch on 2014-01-23.
//
//

#import "LoginEventHandler.h"
#import "Event.h"
#import "LoginProtocol.h"
#import "User.h"
#import "ServerResponseMessage.h"
@implementation LoginEventHandler

-(void)handleEvent: (Event*) event{
    ServerResponseMessage *message = (ServerResponseMessage*)event.msg;
    ServerMessageError *error = message.error;
    if([event.delegateListener conformsToProtocol:@protocol(LoginProtocol)]){
        NSLog(@"FOR SOME REASON THE DELEGATE LISTENER OF A LOGIN EVENT IS NOT IMPLEMENTING LOGINPROTOCOL.  WHYYYYYYYYY?");
    }
    id<LoginProtocol> delegateListener = event.delegateListener;
    if(error != nil) {
        NSLog(@"Did login with error");
        [delegateListener didLoginWithSuccess:NO andError:error];
        return;
    }
    
    NSLog(@"Did login with success");
    NSDictionary *userJSON = [message.data.map objectForKey:@"user"];
    User *user = [[User alloc] initFromJSON:userJSON];
    [User setInstance:user];
    
    NSLog(@"Received User: %@", user.username);
    [delegateListener didLoginWithSuccess:YES andError:nil];
}

@end
