//
//  NonCityVill.m
//  3004iPhone
//
//  Created by John Marsh on 1/15/2014.
//
//

#import "NonCityVill.h"

@implementation NonCityVill

@synthesize terrain = _terrain;
@synthesize fileName = _fileName;


-(NonCityVill*) initWithId:(NSString*) nonCityVillId
               terrainType:(Terrain*) type
                 goldValue:(int) value
                  fileName:(NSString*) name{

    
    _gamePieceId = [[NSString alloc] initWithString:nonCityVillId];
    _terrain = type;
    _goldValue = &value;
    _fileName = [[NSString alloc] initWithString:name];
    
    return [super init];
}


+(NSMutableDictionary*) initializeAllNonCityVill{
    NSMutableDictionary *nonCityVill = [[NSMutableDictionary alloc]init];
    
    
    
    
    
    
    [nonCityVill setObject:[[NonCityVill alloc] initWithId:@"specialIncomeCounter_01"
                                               terrainType:[Terrain getForestInstance] goldValue:1 fileName:<#(NSString *)#>] forKey:@"specialIncomeCounter_01"]
    
    [nonCityVill setObject:[[NonCityVill alloc] initWithId:@"specialIncomeCounter_02"
                                               terrainType:[Terrain getFrozenInstance] goldValue:3 fileName:<#(NSString *)#>] forKey:@"specialIncomeCounter_02"]
    
    [nonCityVill setObject:[[NonCityVill alloc] initWithId:@"specialIncomeCounter_03"
                                               terrainType:[Terrain getSwampInstance] goldValue:1 fileName:<#(NSString *)#>] forKey:@"specialIncomeCounter_03"]
    
    [nonCityVill setObject:[[NonCityVill alloc] initWithId:@"specialIncomeCounter_04"
                                               terrainType:[Terrain getPlainesInstance] goldValue:1 fileName:<#(NSString *)#>] forKey:@"specialIncomeCounter_04"]
    
    [nonCityVill setObject:[[NonCityVill alloc] initWithId:@"specialIncomeCounter_05"
                                               terrainType:[Terrain getMountainInstance] goldValue:3 fileName:<#(NSString *)#>] forKey:@"specialIncomeCounter_05"]
    
    [nonCityVill setObject:[[NonCityVill alloc] initWithId:@"specialIncomeCounter_06"
                                               terrainType:[Terrain getJungleInstance] goldValue:3 fileName:<#(NSString *)#>] forKey:@"specialIncomeCounter_06"]
    
    [nonCityVill setObject:[[NonCityVill alloc] initWithId:@"specialIncomeCounter_07"
                                               terrainType:[Terrain getDesertInstance] goldValue:1 fileName:<#(NSString *)#>] forKey:@"specialIncomeCounter_07"]
    
    [nonCityVill setObject:[[NonCityVill alloc] initWithId:@"specialIncomeCounter_08"
                                               terrainType:[Terrain getMountainInstance] goldValue:1 fileName:<#(NSString *)#>] forKey:@"specialIncomeCounter_08"]
    
    map.put("specialIncomeCounter_01", new NonCityVill("specialIncomeCounter_01", "timberland",1,Terrain.FOREST_TERRAIN));//must have forest to get gold logic later added
    map.put("specialIncomeCounter_02", new NonCityVill("specialIncomeCounter_02", "oilField",3,Terrain.FROZEN_TERRAIN)); //only if you have frozen waste to get gold
    map.put("specialIncomeCounter_03", new NonCityVill("specialIncomeCounter_03", "peatBog",1,Terrain.SWAMP_TERRAIN)); //swamp only
    map.put("specialIncomeCounter_04", new NonCityVill("specialIncomeCounter_04", "farmlands",1,Terrain.PLAINS_TERRAIN)); //plains only
    map.put("specialIncomeCounter_05", new NonCityVill("specialIncomeCounter_05", "goldMine",3,Terrain.MOUNTAIN_TERRAIN)); //mountain only
    map.put("specialIncomeCounter_06", new NonCityVill("specialIncomeCounter_06", "elephantGraveyard",3,Terrain.JUNGLE_TERRAIN)); //jungle only
    map.put("specialIncomeCounter_07", new NonCityVill("specialIncomeCounter_07", "diamondField",1,Terrain.DESERT_TERRAIN)); //Desert Only
    map.put("specialIncomeCounter_08", new NonCityVill("specialIncomeCounter_08", "copperMine",1,Terrain.MOUNTAIN_TERRAIN)); //Mountain Only
    
    
    return nonCityVill;
}

@end
