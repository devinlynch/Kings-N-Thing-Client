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
    NSMutableArray *_neighbourIds;

}

@property HexTile *tile;
@property int tileNumber;
@property NSMutableArray *neighbourIds;
@property NSMutableDictionary *stacks;


-(void) addStack: (Stack*) stack;
-(void) removeStack: (Stack*) stack;




@end
