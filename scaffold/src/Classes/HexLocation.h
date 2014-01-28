//
//  HexLocation.h
//  3004iPhone
//
//  Created by John Marsh on 1/15/2014.
//
//

#import "BoardLocation.h"
#import "HexTile.h"
#import "Stack.h"

@interface HexLocation : BoardLocation{
    HexTile *_tile;
    NSMutableDictionary *_neighbours;
    NSMutableArray *_stacks;
}

@property HexTile *tile;
@property NSMutableDictionary *neighbours;
@property NSMutableArray *stacks;

@end
