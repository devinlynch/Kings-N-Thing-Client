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
    int _tileNumber;
    NSString    *_tileId;
    Terrain *_terrain;
    SPImage *_tileImage;
    BOOL    _isHilighted;
}

@property Terrain *terrain;
@property BOOL isHilighted;
@property int tileNumber;
@property NSString *tileId;

-(HexTile*) initWithTerrain: (Terrain *) t andFileName: (NSString*) file andId: (NSString*) tileId;

-(NSMutableDictionary*) initializeTiles;

-(void) unhilight;
-(void)  hilight;

@end
