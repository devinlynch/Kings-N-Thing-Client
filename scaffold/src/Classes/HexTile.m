//
//  HexTile.m
//  3004iPhone
//
//  Created by John Marsh on 1/15/2014.
//
//

#import "TileImage.h"
#import "HexTile.h"
#import "Terrain.h"

@implementation HexTile

@synthesize terrain = _terrain;
@synthesize isHilighted = _isHilighted;
@synthesize tileNumber = _tileNumber;
@synthesize tileId = _tileId;
@synthesize image = _tileImage;
@synthesize hilightImage = _hilightImage;

static NSDictionary* textureCache;

-(void) changeOwnerTo: (NSString*) playerId{
    
    _isHilighted = NO;
    
    SPTexture *texture;
    if ([playerId isEqualToString:@"player1"]) {
        texture = [HexTile getOrCreateTexture:[NSString stringWithFormat:@"red-%@.png",_fileName]];
        //[_tileImage addEventListener:@selector(onTileClick:) atObject:container.parent.parent forType:SP_EVENT_TYPE_TOUCH];
    } else if ([playerId isEqualToString:@"player2"]) {
        texture = [HexTile getOrCreateTexture: [NSString stringWithFormat:@"yellow-%@.png",_fileName]];
        
    } else if ([playerId isEqualToString:@"player3"]) {
        texture = [HexTile getOrCreateTexture: [NSString stringWithFormat:@"green-%@.png",_fileName]];
       
    } else if ([playerId isEqualToString:@"player4"]) {
        texture = [HexTile getOrCreateTexture: [NSString stringWithFormat:@"blue-%@.png",_fileName]];
        
    }
    
    if(texture != nil) {
        [_tileImage setTexture:texture];
    }
}

+(SPTexture*) getOrCreateTexture: (NSString*) fileName{
    @synchronized(self){
        if(textureCache == nil) {
            textureCache = [[NSMutableDictionary alloc] init];
        }
        
        SPTexture* txt = [textureCache objectForKey:fileName];
        if(txt == nil) {
            txt = [[SPTexture alloc] initWithContentsOfFile:fileName];
            if(txt != nil)
                [textureCache setValue:txt forKeyPath:fileName];
        }
        return txt;
    }
}


+(NSMutableDictionary*) initializeTiles{
    
    NSMutableDictionary *tiles = [[NSMutableDictionary alloc] init];
    
    [tiles setObject:[[HexTile alloc] initWithTerrain:[Terrain getDesertInstance] andFileName:@"desert-tile" andId:@"desert-tile-01"]forKey:@"desert-tile-01"];
    
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
    
    [tiles setObject:[[HexTile alloc] initWithTerrain:[Terrain getForestInstance]  andFileName:@"forest-tile" andId:@"forest-tile-07"] forKey:@"forest-tile-07"];
    
    [tiles setObject:[[HexTile alloc] initWithTerrain:[Terrain getForestInstance]  andFileName:@"forest-tile" andId:@"forest-tile-08"] forKey:@"forest-tile-08"];
    
    [tiles setObject:[[HexTile alloc] initWithTerrain:[Terrain getForestInstance]  andFileName:@"forest-tile" andId:@"forest-tile-09"] forKey:@"forest-tile-09"];
    
    [tiles setObject:[[HexTile alloc] initWithTerrain:[Terrain getForestInstance]  andFileName:@"forest-tile" andId:@"forest-tile-10"] forKey:@"forest-tile-10"];
    
    
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
    
    _terrain = t;
    
    _tileId = [[NSString alloc] initWithString:tileId];
    _gamePieceId = [[NSString alloc] initWithString:tileId];

    _fileName = [[NSString alloc] initWithString:file];
    
    NSString *terrainName = [t terrainName];
    
    if ([terrainName isEqualToString:@"Sea"]) {
        _tileImage = [[TileImage alloc] initWithContentsOfFile:@"sea-tile.png"];
        _tileImage.owner = self;
        
    } else if ([terrainName isEqualToString:@"Desert"]) {
        _tileImage = [[TileImage alloc] initWithContentsOfFile:@"desert-tile.png"];
        _tileImage.owner = self;

    } else if ([terrainName isEqualToString:@"Forest"]) {
        _tileImage = [[TileImage alloc] initWithContentsOfFile:@"forest-tile.png"];
        _tileImage.owner = self;

    } else if ([terrainName isEqualToString:@"Mountain"]) {
        _tileImage = [[TileImage alloc] initWithContentsOfFile:@"mountain-tile.png"];
        _tileImage.owner = self;

    } else if ([terrainName isEqualToString:@"Swamp"]) {
        _tileImage = [[TileImage alloc] initWithContentsOfFile:@"swamp-tile.png"];
        _tileImage.owner = self;

    } else if ([terrainName isEqualToString:@"Frozen"]) {
        _tileImage = [[TileImage alloc] initWithContentsOfFile:@"frozen-tile.png"];
        _tileImage.owner = self;

    } else if ([terrainName isEqualToString:@"Jungle"]) {
        _tileImage = [[TileImage alloc] initWithContentsOfFile:@"jungle-tile.png"];
        _tileImage.owner = self;

    } else if ([terrainName isEqualToString:@"Plaines"]) {
        _tileImage = [[TileImage alloc] initWithContentsOfFile:@"plains-tile.png"];
        _tileImage.owner = self;

    } else{
        _tileImage = [[TileImage alloc] initWithContentsOfFile:@"back-tile.png"];
        _tileImage.owner = self;

    }
    
    _hilightImage = [[SPImage alloc] initWithContentsOfFile:@"hilight.png"];
    [_hilightImage setTouchable:NO];
    [_hilightImage setVisible:NO];
    
    return self;
}

- (void)unhilight{
    _isHilighted = NO;
    [_hilightImage setVisible:NO];
}

- (void)hilight{
    if(![self.terrain isEqual:[Terrain getSeaInstance]]){
        _isHilighted = YES;
        [_hilightImage setVisible:YES];
    }
}

@end
