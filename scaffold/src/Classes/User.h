//
//  User.h
//  3004iPhone
//
//  Created by John Marsh on 1/20/2014.
//
//

#import "JSONSerializable.h"
@interface User : NSObject<JSONSerializable>{
    NSString *_userID, *_username, *_password, *_hostName;
    int *_port;
}

@property NSString *userID, *username, *password, *hostName;
+(User*) instance;
+(User*) reInitInstance;
+(void) setInstance: (User*) user;

@end
