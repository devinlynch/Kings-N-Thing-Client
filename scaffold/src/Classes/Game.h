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

@interface Game : NSObject{
    NSArray *_players;
}

@property NSArray *players;


-(void) findPathFromTile: (HexTile *) location withMoves: (int) moves;

@end
