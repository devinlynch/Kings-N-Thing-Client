//
//  User.h
//  3004iPhone
//
//  Created by John Marsh on 1/20/2014.
//
//

#import "Player.h"

@interface User : Player{
    NSString *_userID, *_username, *_password, *_hostName;
    NSInteger *_port;
}

@property NSString *userID, *username, *password, *hostName;
@property NSInteger *port;

@end
