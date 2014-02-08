//
//  HexLocation.h
//  3004iPhone
//
//  Created by John Marsh on 1/15/2014.
//
//

#import "BoardLocation.h"

@class HexTile, Stack, Player, Terrain;

@interface HexLocation : BoardLocation{
    HexTile *_tile;
    NSMutableDictionary *_neighbours;
    NSMutableDictionary *_stacks;
}

@property HexTile *tile;
@property Player  *owner;
@property NSMutableDictionary *neighbours;
@property NSMutableDictionary *stacks;


-(void) addStack: (Stack*) stack;
-(void) removeStack: (Stack*) stack;

@end
