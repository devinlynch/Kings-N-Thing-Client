//
//  Player.h
//  3004iPhone
//
//  Created by John Marsh on 1/15/2014.
//
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface Player : NSObject <JSONSerializable>
{
    User *_user;
}

@property User *user;

@end
