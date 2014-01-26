//
//  User.m
//  3004iPhone
//
//  Created by John Marsh on 1/20/2014.
//
//

#import "User.h"

@implementation User
@synthesize userID,username,password,hostName;

static User *instance;

/**
 Represents the user who is currently logged in
 */
+(User*) instance{
    @synchronized(self){
        return instance;
    }
}

+(User*) reInitInstance{
    @synchronized(self){
        instance = [[User alloc] init];
    }
    return instance;
}

+(void) setInstance: (User*) user{
    @synchronized(self){
        instance = user;
    }
}

-(id<JSONSerializable>)initFromJSON:(NSDictionary*) json{
    self=[super init];
    if(self && json) {
        [self setUsername:[json objectForKey:@"username"]];
        [self setUserID:[json objectForKey:@"userId"]];
    }
    return self;
}

@end
