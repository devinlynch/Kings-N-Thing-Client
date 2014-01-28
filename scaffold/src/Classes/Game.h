//
//  Game.h
//  3004iPhone
//
//  Created by John Marsh on 1/21/2014.
//
//

#import <Foundation/Foundation.h>
#import "Player.h"
#import "HexTile.h"
#import "Bank.h"
#import "Rack.h"
#import "HexLocation.h"
#import "JSONSerializable.h"

@interface Game : NSObject <JSONSerializable>{
    Bank *_bank;
    Rack *_rack;
    NSMutableDictionary *_hexLocations;
    NSMutableArray *_users;
}

@property Bank *bank;
@property Rack *rack;
@property NSMutableDictionary *hexLocations;
@property NSMutableArray *users;

-(void) findPathFromLocation: (HexLocation *) location withMoves: (int) moves;

@end
