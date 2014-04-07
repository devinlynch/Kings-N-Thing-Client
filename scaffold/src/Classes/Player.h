//
//  Player.h
//  3004iPhone
//
//  Created by John Marsh on 1/15/2014.
//
//

#import <Foundation/Foundation.h>
#import "JSONSerializable.h"

@class User, Rack, Creature, GamePiece, HexLocation;

@interface Player : NSObject <JSONSerializable>
{
    User *_user;
    NSString *_playerId;
    NSMutableDictionary *_gamePieces;
    NSString *_username;
    Rack *_rack1;
    int   _gold;
    
}

@property User *user;

@property Rack *rack1;

@property NSString *username;

@property NSString *playerId;

@property NSMutableDictionary *gamePieces;


-(void) addGold: (int) g;

-(void) assignPiece: (GamePiece*) gamePiece;

-(void) updateFromSerializedJson: (NSDictionary*) json;

-(int) gold;
-(void) setGold: (int) g;

-(BOOL) canSupportCreature: (Creature*) creature atLocation: (HexLocation*) hexLocation;

@end
