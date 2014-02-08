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

    
    _gamePieceID = [[NSString alloc] initWithString:nonCityVillId];
    _terrain = type;
    _goldValue = &value;
    _fileName = [[NSString alloc] initWithString:name];
    
    return [super init];
}


+(NSMutableDictionary*) initializeAllNonCityVill{
    NSMutableDictionary *nonCityVill = [[NSMutableDictionary alloc]init];
    
    
    
    
    return nonCityVill;
}

@end
