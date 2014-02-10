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
@synthesize image = _tileImage;


+(NSMutableDictionary*) initializeTiles{
    
    NSMutableDictionary *tiles = [[NSMutableDictionary alloc] init];
    
    [tiles setObject:[[HexTile alloc] initWithTerrain:[Terrain getDesertInstance] andFileName:@"desert-tile-01" andId:@"desert-tile-01"]forKey:@"desert-tile-01"];
    
    [tiles setObject:[[HexTile alloc] initWithTerrain:[Terrain getDesertInstance] andFileName:@"desert-tile" andId:@"desert-tile-02"] forKey:@"desert-tile-02"];
    
    
    
    [tiles setObject:[[HexTile alloc] initWithTerrain:[Terrain getDesertInstance] andFileName:@"desert-tile" andId:@"desert-tile-03"] forKey:@"desert-tile-03"];
    
    
    
    [tiles setObject:[[HexTile alloc] initWithTerrain:[Terrain getDesertInstance] andFileName:@"desert-tile" andId:@"desert-tile-04"] forKey:@"desert-tile-04"];
    
    
    
    [tiles setObject:[[HexTile alloc] initWithTerrain:[Terrain getDesertInstance] andFileName:@"desert-tile" andId:@"desert-tile-05"] forKey:@"desert-tile-05"];
    
    
    
    [tiles setObject:[[HexTile alloc] initWithTerrain:[Terrain getDesertInstance] andFileName:@"desert-tile" andId:@"desert-tile-06"] forKey:@"desert-tile-06"];
    
    
    
    [tiles setObject:[[HexTile alloc] initWithTerrain:[Terrain getForestInstance]  andFileName:@"forest-tile" andId:@"forest-tile-01"] forKey:@"forest-tile-01"];
    
    
    
    [tiles setObject:[[HexTile alloc] initWithTerrain:[Terrain getForestInstance]  andFileName:@"forest-tile" andId:@"forest-tile-02"] forKey:@"forest-tile-02"];
    
    
    
    [tiles setObject:[[HexTile alloc] initWithTerrain:[Terrain getForestInstance]  andFileName:@"forest-tile" andId:@"forest-tile-03"] forKey:@"forest-tile-03"];
    
    
    
    [tiles setObject:[[HexTile alloc] initWithTerrain:[Terrain getForestInstance]  andFileName:@"forest-tile" andId:@"forest-tile-04"] forKey:@"forest-tile-04"];
    
    
    
    [tiles setObject:[[HexTile alloc] initWithTerrain:[Terrain getForestInstance]  andFileName:@"forest-tile" andId:@"forest-tile-05"] forKey:@"forest-tile-05"];
    
    
    
    [tiles setObject:[[HexTile alloc] initWithTerrain:[Terrain getForestInstance]  andFileName:@"forest-tile" andId:@"forest-tile-06"] forKey:@"forest-tile-06"];
    
    
    
    [tiles setObject:[[HexTile alloc] initWithTerrain:[Terrain getFrozenInstance]  andFileName:@"frozen-tile" andId:@"frozen-tile-01"] forKey:@"frozen-tile-01"];
    
    
    
    [tiles setObject:[[HexTile alloc] initWithTerrain:[Terrain getFrozenInstance]  andFileName:@"frozen-tile" andId:@"frozen-tile-02"] forKey:@"frozen-tile-02"];
    
    
    
    [tiles setObject:[[HexTile alloc] initWithTerrain:[Terrain getFrozenInstance]  andFileName:@"frozen-tile" andId:@"frozen-tile-03"] forKey:@"frozen-tile-03"];
    
    
    
    [tiles setObject:[[HexTile alloc] initWithTerrain:[Terrain getFrozenInstance]  andFileName:@"frozen-tile" andId:@"frozen-tile-04"] forKey:@"frozen-tile-04"];
    
    
    
    [tiles setObject:[[HexTile alloc] initWithTerrain:[Terrain getFrozenInstance]  andFileName:@"frozen-tile" andId:@"frozen-tile-05"] forKey:@"frozen-tile-05"];
    
    
    
    [tiles setObject:[[HexTile alloc] initWithTerrain:[Terrain getJungleInstance]  andFileName:@"jungle-tile" andId:@"jungle-tile-01"] forKey:@"jungle-tile-01"];
    
    
    
    [tiles setObject:[[HexTile alloc] initWithTerrain:[Terrain getJungleInstance]  andFileName:@"jungle-tile" andId:@"jungle-tile-02"] forKey:@"jungle-tile-02"];
    
    
    
    [tiles setObject:[[HexTile alloc] initWithTerrain:[Terrain getJungleInstance]  andFileName:@"jungle-tile" andId:@"jungle-tile-03"] forKey:@"jungle-tile-03"];
    
    
    
    [tiles setObject:[[HexTile alloc] initWithTerrain:[Terrain getJungleInstance]  andFileName:@"jungle-tile" andId:@"jungle-tile-04"] forKey:@"jungle-tile-04"];
    
    
    
    [tiles setObject:[[HexTile alloc] initWithTerrain:[Terrain getJungleInstance]  andFileName:@"jungle-tile" andId:@"jungle-tile-05"] forKey:@"jungle-tile-05"];
    
    
    
    [tiles setObject:[[HexTile alloc] initWithTerrain:[Terrain getMountainInstance]  andFileName:@"mountain-tile" andId:@"mountain-tile-01"] forKey:@"mountain-tile-01"];
    
    
    
    [tiles setObject:[[HexTile alloc] initWithTerrain:[Terrain getMountainInstance]  andFileName:@"mountain-tile" andId:@"mountain-tile-02"] forKey:@"mountain-tile-02"];
    
    
    
    [tiles setObject:[[HexTile alloc] initWithTerrain:[Terrain getMountainInstance]  andFileName:@"mountain-tile" andId:@"mountain-tile-03"] forKey:@"mountain-tile-03"];
    
    
    
    [tiles setObject:[[HexTile alloc] initWithTerrain:[Terrain getMountainInstance]  andFileName:@"mountain-tile" andId:@"mountain-tile-04"] forKey:@"mountain-tile-04"];
    
    
    
    [tiles setObject:[[HexTile alloc] initWithTerrain:[Terrain getMountainInstance]  andFileName:@"mountain-tile" andId:@"mountain-tile-05"] forKey:@"mountain-tile-05"];
    
    
    
    [tiles setObject:[[HexTile alloc] initWithTerrain:[Terrain getMountainInstance]  andFileName:@"mountain-tile" andId:@"mountain-tile-06"] forKey:@"mountain-tile-06"];
    
    
    
    
    [tiles setObject:[[HexTile alloc] initWithTerrain:[Terrain getPlainesInstance]  andFileName:@"plains-tile" andId:@"plains-tile-01"] forKey:@"plains-tile-01"];
    
    
    
    [tiles setObject:[[HexTile alloc] initWithTerrain:[Terrain getPlainesInstance]  andFileName:@"plains-tile" andId:@"plains-tile-02"] forKey:@"plains-tile-02"];
    
    
    
    [tiles setObject:[[HexTile alloc] initWithTerrain:[Terrain getPlainesInstance]  andFileName:@"plains-tile" andId:@"plains-tile-03"] forKey:@"plains-tile-03"];
    
    
    
    [tiles setObject:[[HexTile alloc] initWithTerrain:[Terrain getPlainesInstance]  andFileName:@"plains-tile" andId:@"plains-tile-04"] forKey:@"plains-tile-04"];
    
    
    
    [tiles setObject:[[HexTile alloc] initWithTerrain:[Terrain getPlainesInstance]  andFileName:@"plains-tile" andId:@"plains-tile-05"] forKey:@"plains-tile-05"];
    
    
    
    [tiles setObject:[[HexTile alloc] initWithTerrain:[Terrain getPlainesInstance]  andFileName:@"plains-tile" andId:@"plains-tile-06"] forKey:@"plains-tile-06"];
    
    
    
    [tiles setObject:[[HexTile alloc] initWithTerrain:[Terrain getSeaInstance]  andFileName:@"sea-tile" andId:@"sea-tile-01"] forKey:@"sea-tile-01"];
    
    
    
    [tiles setObject:[[HexTile alloc] initWithTerrain:[Terrain getSeaInstance]  andFileName:@"sea-tile" andId:@"sea-tile-02"] forKey:@"sea-tile-02"];
    
    
    
    [tiles setObject:[[HexTile alloc] initWithTerrain:[Terrain getSeaInstance]  andFileName:@"sea-tile" andId:@"sea-tile-03"] forKey:@"sea-tile-03"];
    
    
    
    [tiles setObject:[[HexTile alloc] initWithTerrain:[Terrain getSeaInstance]  andFileName:@"sea-tile" andId:@"sea-tile-04"] forKey:@"sea-tile-04"];
    
    
    
    [tiles setObject:[[HexTile alloc] initWithTerrain:[Terrain getSeaInstance]  andFileName:@"sea-tile" andId:@"sea-tile-05"] forKey:@"sea-tile-05"];
    
    
    
    [tiles setObject:[[HexTile alloc] initWithTerrain:[Terrain getSeaInstance]  andFileName:@"sea-tile" andId:@"sea-tile-06"] forKey:@"sea-tile-06"];
    
    
    
    [tiles setObject:[[HexTile alloc] initWithTerrain:[Terrain getSeaInstance]  andFileName:@"sea-tile" andId:@"sea-tile-07"] forKey:@"sea-tile-07"];
    
    
    
    [tiles setObject:[[HexTile alloc] initWithTerrain:[Terrain getSeaInstance]  andFileName:@"sea-tile" andId:@"sea-tile-08"] forKey:@"sea-tile-08"];
    
    
    
    [tiles setObject:[[HexTile alloc] initWithTerrain:[Terrain getSwampInstance]  andFileName:@"swamp-tile" andId:@"swamp-tile-01"] forKey:@"swamp-tile-01"];
    
    
    
    [tiles setObject:[[HexTile alloc] initWithTerrain:[Terrain getSwampInstance]  andFileName:@"swamp-tile" andId:@"swamp-tile-02"] forKey:@"swamp-tile-02"];
    
    
    
    [tiles setObject:[[HexTile alloc] initWithTerrain:[Terrain getSwampInstance]  andFileName:@"swamp-tile" andId:@"swamp-tile-03"] forKey:@"swamp-tile-03"];
    
    
    
    [tiles setObject:[[HexTile alloc] initWithTerrain:[Terrain getSwampInstance]  andFileName:@"swamp-tile" andId:@"swamp-tile-04"] forKey:@"swamp-tile-04"];
    
    
    
    [tiles setObject:[[HexTile alloc] initWithTerrain:[Terrain getSwampInstance]  andFileName:@"swamp-tile" andId:@"swamp-tile-05"] forKey:@"swamp-tile-05"];
    
    
    
    [tiles setObject:[[HexTile alloc] initWithTerrain:[Terrain getSwampInstance]  andFileName:@"swamp-tile" andId:@"swamp-tile-06"] forKey:@"swamp-tile-06"];
    
    
    return tiles;
}
        
-(HexTile*) initWithTerrain: (Terrain *) t andFileName: (NSString*) file andId:(NSString *)tileId{
    self = [super init];
    
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
        _tileImage = [[SPImage alloc] initWithContentsOfFile:@"plaines-tile.png"];
    } else{
        _tileImage = [[SPImage alloc] initWithContentsOfFile:@"back-tile.png"];
    }
    
    return self;
}

- (void)unhilight{
    _isHilighted = NO;
}

- (void)hilight{
    _isHilighted = YES;
}

@end
