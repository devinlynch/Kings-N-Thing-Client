//
//  HexLocation.h
//  3004iPhone
//
//  Created by John Marsh on 1/15/2014.
//
//

#import "BoardLocation.h"

@class HexTile, Stack, Player, Terrain, SPTween;

@interface HexLocation : BoardLocation{
    HexTile *_tile;
    int _tileNumber;
    NSMutableDictionary *_stacks;
    NSArray *_neighbourIds;
    Player *_owner;
    BOOL _isStartingPoint;
    BOOL _visited;
}

@property HexTile *tile;
@property Player  *owner;
@property int tileNumber;
@property NSArray *neighbourIds;
@property NSMutableDictionary *stacks;
@property BOOL isStartingPoint;
@property BOOL visited;
-(void) changeOwnerToPlayer: (Player*) player;

-(void) addStack: (Stack*) stack;
-(void) removeStack: (Stack*) stack;

-(BOOL) hasNeighbourOwnedByPlayer: (Player*) player;

-(void) updateLocationWithStacks: (NSArray*) array;

-(void) hilightPossibleMoves;
-(NSArray*) getAllPiecesForPlayerIncludingPiecesInStacks: (Player*) p;
@end
