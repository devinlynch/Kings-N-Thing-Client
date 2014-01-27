//
//  HexLocation.h
//  3004iPhone
//
//  Created by John Marsh on 1/15/2014.
//
//

#import "BoardContainer.h"
#import "HexTile.h"

@interface HexLocation : BoardContainer{
    HexTile *_tile;
    NSMutableDictionary *_neighbours;
}

@property HexTile *tile;
@property NSMutableDictionary *neighbours;

@end
