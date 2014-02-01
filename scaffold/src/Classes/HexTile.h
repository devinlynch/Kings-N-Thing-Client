//
//  HexTile.h
//  3004iPhone
//
//  Created by John Marsh on 1/15/2014.
//
//

#import "GamePiece.h"

@class Terrain;

@interface HexTile : GamePiece{
    NSInteger _tileNumber;
    Terrain *_terrain;
    SPImage *_tileImage;
    BOOL    _isHilighted;
}

@property Terrain *terrain;
@property BOOL isHilighted;
@property NSInteger tileNumber;

-(HexTile*) initWithTerrain: (Terrain *) terrain andTileNumber:(int) number;

-(void) unhilight;
-(void)  hilight;

@end
