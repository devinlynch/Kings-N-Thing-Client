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


        
-(HexTile*)initWithTerrain:(Terrain *)terrain andTileNumber:(int)number{
    
    
    _terrain    = terrain;
    _tileNumber = number;
    
    
    NSString *terrainName = [terrain terrainName];
    
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
