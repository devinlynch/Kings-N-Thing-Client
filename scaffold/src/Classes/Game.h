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

@interface Game : NSObject{
    NSMutableDictionary *_players;
    Bank *_bank;
    Rack *_rack;
    NSMutableDictionary *_hexLocations;
}

@property NSMutableDictionary *players;
@property Bank *bank;
@property Rack *rack;
@property NSMutableDictionary *hexLocations;


-(void) findPathFromLocation: (HexLocation *) location withMoves: (int) moves;

@end
