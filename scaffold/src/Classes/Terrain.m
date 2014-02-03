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

-(Terrain*) initWithTerrainName: (NSString*) name{
    _terrainName = [[NSString alloc] initWithString:name];
    return [super init];
}


@end
