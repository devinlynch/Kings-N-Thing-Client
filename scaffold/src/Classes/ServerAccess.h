//
//  ServerAccess.h
//  3004iPhone
//
//  Created by Devin Lynch on 2014-01-21.
//
//

#import <Foundation/Foundation.h>
#import "LoginProtocol.h"
@class ClientReactor;

typedef void (^block_t)();
@interface ServerAccess : NSObject
{
    ClientReactor *reactor;
}
+(ServerAccess*) instance;

-(void) loginWithUsername: (NSString*) username andPassword: (NSString*) password andDelegateListener: (id<LoginProtocol>) delegateListener;
-(void) registerAndLoginWithUsername: (NSString*) username andPassword: (NSString*) password andDelegateListener: (id<LoginProtocol>) delegateListener;

@end
