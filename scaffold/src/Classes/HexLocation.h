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
    NSMutableArray *_neighbourIds;
    Player *_owner;
}

@property HexTile *tile;
@property Player  *owner;
@property int tileNumber;
@property NSMutableArray *neighbourIds;
@property NSMutableDictionary *stacks;

-(void) changeOwnerToPlayer: (Player*) player;

-(void) addStack: (Stack*) stack;
-(void) removeStack: (Stack*) stack;




@end
