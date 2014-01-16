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
}

@property Terrain *terrain;

@end
