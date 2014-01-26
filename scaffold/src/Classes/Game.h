//
//  Game.h
//  3004iPhone
//
//  Created by John Marsh on 1/21/2014.
//
//

#import <Foundation/Foundation.h>
#import "Player.h"
#import "JSONSerializable.h"

@interface Game : NSObject <JSONSerializable>{
    NSMutableArray *_users;
}

@property NSMutableArray *users;

@end
