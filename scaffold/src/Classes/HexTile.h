//
//  HexTile.h
//  3004iPhone
//
//  Created by John Marsh on 1/15/2014.
//
//

#import "GamePiece.h"
#import "Terrain.h"

@interface HexTile : GamePiece{
    Terrain *_terrain;
    BOOL    _isHilighted;
    NSArray *_neighbours;
}

@property Terrain *terrain;
@property BOOL isHilighted;
@property NSArray *neighbours;

-(void) unhilight;
-(void)  hilight;

@end
