//
//  Terrain.m
//  3004iPhone
//
//  Created by John Marsh on 1/15/2014.
//
//

#import "Terrain.h"

@implementation Terrain

@synthesize terrainID   = _terrainID;
@synthesize terrainName = _terrainName;

static Terrain *jungle = nil;
static Terrain *sea = nil;
static Terrain *frozen = nil;
static Terrain *plaines = nil;
static Terrain *swamp = nil;
static Terrain *mountain = nil;
static Terrain *desert = nil;
static Terrain *forest = nil;

+(Terrain*) getJungleInstance{
    if (jungle == nil) {
        jungle = [[Terrain alloc] initWithID:@"jungle-tile" andTerrainName:@"Jungle"];
    }
    return jungle;
}

+(Terrain*) getSeaInstance{
    if (sea == nil) {
        sea = [[Terrain alloc] initWithID:@"sea-tile" andTerrainName:@"Sea"];
    }
    return sea;
}

+(Terrain*) getFrozenInstance{
    if (frozen == nil) {
        frozen = [[Terrain alloc] initWithID:@"frozen-tile" andTerrainName:@"Frozen"];
    }
    return frozen;
}

+(Terrain*) getPlainesInstance{
    if (plaines == nil) {
        plaines = [[Terrain alloc] initWithID:@"plaines-tile" andTerrainName:@"Plaines"];
        
    }
    return plaines;
}

+(Terrain*) getSwampInstance{
    if (swamp == nil) {
        swamp = [[Terrain alloc] initWithID:@"swamp-tile" andTerrainName:@"Swamp"];
        
    }
    return swamp;
}

+(Terrain*) getMountainInstance{
    if (mountain == nil) {
        mountain = [[Terrain alloc] initWithID:@"mountain-tile" andTerrainName:@"Mountain"];
        
    }
    return mountain;
}

+(Terrain*) getDesertInstance{
    if (desert == nil) {
        desert = [[Terrain alloc] initWithID:@"desert-tile" andTerrainName:@"Desert"];
        
    }
    return desert;
}

+(Terrain*) getForestInstance{
    if (forest == nil) {
        forest = [[Terrain alloc] initWithID:@"forest-tile" andTerrainName:@"Forest"];
        
    }
    return forest;
}



-(Terrain*) initWithID: (NSString*) terrainID andTerrainName: (NSString*) name{
    _terrainID = [[NSString alloc] initWithString:terrainID];
    _terrainName = [[NSString alloc] initWithString:name];
    return [super init];
}


@end
