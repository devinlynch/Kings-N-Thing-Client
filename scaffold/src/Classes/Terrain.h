//
//  Terrain.h
//  3004iPhone
//
//  Created by John Marsh on 1/15/2014.
//
//

#import <Foundation/Foundation.h>

@interface Terrain : NSObject{
    NSString *_terrainID;
    NSString *_terrainName;
}

@property NSString *terrainID, *terrainName;

-(Terrain*) initWithID: (NSString*) terrainID andTerrainName: (NSString*) name;

+(Terrain*) getJungleInstance;
+(Terrain*) getSeaInstance;
+(Terrain*) getFrozenInstance;
+(Terrain*) getPlainesInstance;
+(Terrain*) getSwampInstance;
+(Terrain*) getMountainInstance;
+(Terrain*) getDesertInstance;
+(Terrain*) getForestInstance;


@end
