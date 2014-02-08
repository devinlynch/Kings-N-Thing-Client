//
//  Player.h
//  3004iPhone
//
//  Created by John Marsh on 1/15/2014.
//
//

#import <Foundation/Foundation.h>
#import "User.h"
#import "Rack.h"

@interface Player : NSObject <JSONSerializable>
{
    User *_user;
    NSString *_playerId;
    NSMutableDictionary *_gamePieces;
    Rack *_rack1;
    Rack *_rack2;
    int   _gold;
    
}

@property User *user;

@property Rack *rack1;

@property Rack *rack2;

@property int gold;

@property NSString *username;

@property NSString *playerId;

@property NSMutableDictionary *gamePieces;


@end
