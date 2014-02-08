//
//  HexTile.m
//  3004iPhone
//
//  Created by John Marsh on 1/15/2014.
//
//

#import "HexTile.h"
#import "Terrain.h"

@implementation HexTile

@synthesize terrain = _terrain;
@synthesize isHilighted = _isHilighted;
@synthesize tileNumber = _tileNumber;
@synthesize tileId;


//-(NSMutableDictionary*) initializeTiles{
//    
//    NSMutableDictionary *tiles = [[NSMutableDictionary alloc] init];
//    
//    [tiles setObject:[[HexTile alloc] initWithTerrain:Terrain.DESERT_TERRAIN andFileName: andId:"desert-tile-01"] forKey:];
//
//
//    [tiles setObject:[[HexTile alloc] initWithTerrain:Terrain.DESERT_TERRAIN andFileName: andId:"desert-tile-02"] forKey:\];
//
//
//    [tiles setObject:[[HexTile alloc] initWithTerrain:Terrain.DESERT_TERRAIN andFileName: andId:"desert-tile-03"] forKey:\];
//;
//
//    [tiles setObject:[[HexTile alloc] initWithTerrain:Terrain.DESERT_TERRAIN andFileName: andId:"desert-tile-04"] forKey:\];
//;
//
//    [tiles setObject:[[HexTile alloc] initWithTerrain:Terrain.DESERT_TERRAIN andFileName: andId:"desert-tile-05"] forKey:\];
//;
//
//    [tiles setObject:[[HexTile alloc] initWithTerrain:Terrain.DESERT_TERRAIN andFileName: andId:"desert-tile-06"] forKey:\];
//;
//
//    [tiles setObject:[[HexTile alloc] initWithTerrain:Terrain.FOREST_TERRAIN andFileName: andId:"forest-tile-01"] forKey:\];
//;
//
//    [tiles setObject:[[HexTile alloc] initWithTerrain:Terrain.FOREST_TERRAIN andFileName: andId:"forest-tile-02"] forKey:\];
//;
//
//    [tiles setObject:[[HexTile alloc] initWithTerrain:Terrain.FOREST_TERRAIN andFileName: andId:"forest-tile-03"] forKey:\];
//;
//
//    [tiles setObject:[[HexTile alloc] initWithTerrain:Terrain.FOREST_TERRAIN andFileName: andId:"forest-tile-04"] forKey:\];
//;
//
//    [tiles setObject:[[HexTile alloc] initWithTerrain:Terrain.FOREST_TERRAIN andFileName: andId:"forest-tile-05"] forKey:\];
//;
//[tiles setObject:[[HexTile alloc] initWithTerrain:Terrain.FOREST_TERRAIN andFileName: andId:"forest-tile-06"] forKey:\];
//;
//
//    [tiles setObject:[[HexTile alloc] initWithTerrain:Terrain.FROZEN_TERRAIN andFileName: andId:"frozen-tile-01"] forKey:\];
//;
//[tiles setObject:[[HexTile alloc] initWithTerrain:Terrain.FROZEN_TERRAIN andFileName: andId:"frozen-tile-02"] forKey:\];
//;
//[tiles setObject:[[HexTile alloc] initWithTerrain:Terrain.FROZEN_TERRAIN andFileName: andId:"frozen-tile-03"] forKey:\];
//;
//[tiles setObject:[[HexTile alloc] initWithTerrain:Terrain.FROZEN_TERRAIN andFileName: andId:"frozen-tile-04"] forKey:\];
//;
//[tiles setObject:[[HexTile alloc] initWithTerrain:Terrain.FROZEN_TERRAIN andFileName: andId:"frozen-tile-05"] forKey:\];
//;
//
//    [tiles setObject:[[HexTile alloc] initWithTerrain:Terrain.JUNGLE_TERRAIN andFileName: andId:"jungle-tile-01"] forKey:\];
//;
//[tiles setObject:[[HexTile alloc] initWithTerrain:Terrain.JUNGLE_TERRAIN andFileName: andId:"jungle-tile-02"] forKey:\];
//;
//[tiles setObject:[[HexTile alloc] initWithTerrain:Terrain.JUNGLE_TERRAIN andFileName: andId:"jungle-tile-03"] forKey:\];
//;
//[tiles setObject:[[HexTile alloc] initWithTerrain:Terrain.JUNGLE_TERRAIN andFileName: andId:"jungle-tile-04"] forKey:\];
//;
//[tiles setObject:[[HexTile alloc] initWithTerrain:Terrain.JUNGLE_TERRAIN andFileName: andId:"jungle-tile-05"] forKey:\];
//;
//
//    [tiles setObject:[[HexTile alloc] initWithTerrain:Terrain.MOUNTAIN_TERRAIN andFileName: andId:"mountain-tile-01"] forKey:\];
//;
//[tiles setObject:[[HexTile alloc] initWithTerrain:Terrain.MOUNTAIN_TERRAIN andFileName: andId:"mountain-tile-02"] forKey:\];
//;
//[tiles setObject:[[HexTile alloc] initWithTerrain:Terrain.MOUNTAIN_TERRAIN andFileName: andId:"mountain-tile-03"] forKey:\];
//;
//[tiles setObject:[[HexTile alloc] initWithTerrain:Terrain.MOUNTAIN_TERRAIN andFileName: andId:"mountain-tile-04"] forKey:\];
//;
//[tiles setObject:[[HexTile alloc] initWithTerrain:Terrain.MOUNTAIN_TERRAIN andFileName: andId:"mountain-tile-05"] forKey:\];
//;
//[tiles setObject:[[HexTile alloc] initWithTerrain:Terrain.MOUNTAIN_TERRAIN andFileName: andId:"mountain-tile-06"] forKey:\];
//;
//
//    [tiles setObject:[[HexTile alloc] initWithTerrain:Terrain.PLAINS_TERRAIN andFileName: andId:"plains-tile-01"] forKey:\];
//;
//[tiles setObject:[[HexTile alloc] initWithTerrain:Terrain.PLAINS_TERRAIN andFileName: andId:"plains-tile-02"] forKey:\];
//;
//[tiles setObject:[[HexTile alloc] initWithTerrain:Terrain.PLAINS_TERRAIN andFileName: andId:"plains-tile-03"] forKey:\];
//;
//[tiles setObject:[[HexTile alloc] initWithTerrain:Terrain.PLAINS_TERRAIN andFileName: andId:"plains-tile-04"] forKey:\];
//;
//[tiles setObject:[[HexTile alloc] initWithTerrain:Terrain.PLAINS_TERRAIN andFileName: andId:"plains-tile-05"] forKey:\];
//;
//[tiles setObject:[[HexTile alloc] initWithTerrain:Terrain.PLAINS_TERRAIN andFileName: andId:"plains-tile-06"] forKey:\];
//;
//
//    [tiles setObject:[[HexTile alloc] initWithTerrain:Terrain.SEA_TERRAIN andFileName: andId:"sea-tile-01"] forKey:\];
//;
//[tiles setObject:[[HexTile alloc] initWithTerrain:Terrain.SEA_TERRAIN andFileName: andId:"sea-tile-02"] forKey:\];
//;
//[tiles setObject:[[HexTile alloc] initWithTerrain:Terrain.SEA_TERRAIN andFileName: andId:"sea-tile-03"] forKey:\];
//;
//[tiles setObject:[[HexTile alloc] initWithTerrain:Terrain.SEA_TERRAIN andFileName: andId:"sea-tile-04"] forKey:\];
//;
//[tiles setObject:[[HexTile alloc] initWithTerrain:Terrain.SEA_TERRAIN andFileName: andId:"sea-tile-05"] forKey:\];
//;
//[tiles setObject:[[HexTile alloc] initWithTerrain:Terrain.SEA_TERRAIN andFileName: andId:"sea-tile-06"] forKey:\];
//;
//[tiles setObject:[[HexTile alloc] initWithTerrain:Terrain.SEA_TERRAIN andFileName: andId:"sea-tile-07"] forKey:\];
//;
//[tiles setObject:[[HexTile alloc] initWithTerrain:Terrain.SEA_TERRAIN andFileName: andId:"sea-tile-08"] forKey:\];
//;
//
//    [tiles setObject:[[HexTile alloc] initWithTerrain:Terrain.SWAMP_TERRAIN andFileName: andId:"swamp-tile-01"] forKey:\];
//;
//[tiles setObject:[[HexTile alloc] initWithTerrain:Terrain.SWAMP_TERRAIN andFileName: andId:"swamp-tile-02"] forKey:\];
//;
//[tiles setObject:[[HexTile alloc] initWithTerrain:Terrain.SWAMP_TERRAIN andFileName: andId:"swamp-tile-03"] forKey:\];
//;
//[tiles setObject:[[HexTile alloc] initWithTerrain:Terrain.SWAMP_TERRAIN andFileName: andId:"swamp-tile-04"] forKey:\];
//;
//[tiles setObject:[[HexTile alloc] initWithTerrain:Terrain.SWAMP_TERRAIN andFileName: andId:"swamp-tile-05"] forKey:\];
//;
//[tiles setObject:[[HexTile alloc] initWithTerrain:Terrain.SWAMP_TERRAIN andFileName: andId:"swamp-tile-06"] forKey:\];
//;
//
//    
//    
//}

-(HexTile*) initWithTerrain: (Terrain *) t andFileName: (NSString*) file andId:(NSString *)tileId{

    
    NSString *terrainName = [t terrainName];
    
    if ([terrainName isEqualToString:@"Sea"]) {
        _tileImage = [[SPImage alloc] initWithContentsOfFile:@"sea-tile.png"];
    } else if ([terrainName isEqualToString:@"Desert"]) {
        _tileImage = [[SPImage alloc] initWithContentsOfFile:@"desert-tile.png"];
    } else if ([terrainName isEqualToString:@"Forest"]) {
        _tileImage = [[SPImage alloc] initWithContentsOfFile:@"forest-tile.png"];
    } else if ([terrainName isEqualToString:@"Mountain"]) {
        _tileImage = [[SPImage alloc] initWithContentsOfFile:@"mountain-tile.png"];
    } else if ([terrainName isEqualToString:@"Swamp"]) {
        _tileImage = [[SPImage alloc] initWithContentsOfFile:@"swamp-tile.png"];
    } else if ([terrainName isEqualToString:@"Frozen"]) {
        _tileImage = [[SPImage alloc] initWithContentsOfFile:@"frozen-tile.png"];
    } else if ([terrainName isEqualToString:@"Jungle"]) {
        _tileImage = [[SPImage alloc] initWithContentsOfFile:@"jungle-tile.png"];
    } else if ([terrainName isEqualToString:@"Plaines"]) {
        _tileImage = [[SPImage alloc] initWithContentsOfFile:@"[plaines-tile.png"];
    } else{
        _tileImage = [[SPImage alloc] initWithContentsOfFile:@"[back-tile.png"];
    }
    
    return [super init];
}

- (void)unhilight{
    _isHilighted = NO;
}

- (void)hilight{
    _isHilighted = YES;
}

@end
