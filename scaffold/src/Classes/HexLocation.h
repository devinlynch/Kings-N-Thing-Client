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
    int _tileNumber;
    NSMutableDictionary *_stacks;
    NSArray *_neighbourIds;
    Player *_owner;
    BOOL _isStartingPoint;
}

@property HexTile *tile;
@property Player  *owner;
@property int tileNumber;
@property NSArray *neighbourIds;
@property NSMutableDictionary *stacks;
@property BOOL isStartingPoint;

-(void) changeOwnerToPlayer: (Player*) player;

-(void) addStack: (Stack*) stack;
-(void) removeStack: (Stack*) stack;

-(BOOL) hasNeighbourOwnedByPlayer: (Player*) player;



@end
