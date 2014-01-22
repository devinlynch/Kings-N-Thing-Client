//
//  ServerAccess.h
//  3004iPhone
//
//  Created by Devin Lynch on 2014-01-21.
//
//

#import <Foundation/Foundation.h>
@class ClientReactor;

typedef void (^block_t)();
@interface ServerAccess : NSObject
{
    ClientReactor *reactor;
}
-(void) loginWithUsername: (NSString*) username andPassword: (NSString*) password;

@end
