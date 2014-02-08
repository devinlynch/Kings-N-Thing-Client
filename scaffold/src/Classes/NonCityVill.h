//
//  NonCityVill.h
//  3004iPhone
//
//  Created by John Marsh on 1/15/2014.
//
//

#import "SpecialIncomeCounters.h"
#import "Terrain.h"

@interface NonCityVill : SpecialIncomeCounters{
    Terrain *_terrain;
    NSString *_fileName;
}

@property Terrain *terrain;
@property NSString *fileName;

-(NonCityVill*) initWithId:(NSString*) nonCityVillId
               terrainType:(Terrain*) type
                 goldValue:(int) value
                  fileName:(NSString*) name;


+(NSMutableDictionary*) initializeAllNonCityVill;

@end
