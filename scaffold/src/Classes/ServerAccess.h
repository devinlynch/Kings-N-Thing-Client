//
//  ServerAccess.h
//  3004iPhone
//
//  Created by Devin Lynch on 2014-01-21.
//
//

#import <Foundation/Foundation.h>
#import "LoginProtocol.h"
#import "LobbyProtocol.h"

@class ClientReactor;

typedef void (^block_t)();
@interface ServerAccess : NSObject
{
    ClientReactor *reactor;
    NSString *ipAddress;
    NSString *port;
}

typedef enum HttpRequestMethods {
    POSTREQUEST,
    GETREQUEST
} HttpRequestMethods;

+(ServerAccess*) instance;
-(void) asynchronousRequestOfType: (HttpRequestMethods) method toUrl: (NSString*) req withParams: (NSMutableDictionary*) params  andDelegateListener: (id) delegateListener andErrorCall:(block_t) errorCall andSuccessCall: (block_t) successCall;

-(void) loginWithUsername: (NSString*) username andPassword: (NSString*) password andDelegateListener: (id<LoginProtocol>) delegateListener;
-(void) registerAndLoginWithUsername: (NSString*) username andPassword: (NSString*) password andDelegateListener: (id<LoginProtocol>) delegateListener;
-(void) findAnyLobby: (int) numberPreferredPlayers andDelegateListener: (id<LobbyProtocol>) delegateListener;
-(void) searchLobby: (NSString*) usernameOfHost andDelegateListener: (id<LobbyProtocol>) delegateListener;
-(void) hostLobby: (int) numberPreferredPlayers andDelegateListener: (id<LobbyProtocol>) delegateListener;
-(void) unregisterFromLobby;
-(void) getLobbyState: (NSString*) gameLobbyId;
-(void) leaveGame;
-(void) getNewMessagesFrom: (NSDate*) date;
-(void) getQueuedMessage;
-(void) tellServerWeGotMessage: (NSString*) messageId;

@end
