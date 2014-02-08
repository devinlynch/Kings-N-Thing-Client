//
//  CityVil.m
//  3004iPhone
//
//  Created by John Marsh on 1/15/2014.
//
//

#import "CityVill.h"

@implementation CityVill

@synthesize combatValue = _combatValue;
@synthesize fileName = _fileName;




-(CityVill*) initWithId:(NSString*) cityVillId
           andGoldValue:(int) value
         andCombatValue:(int) cValue
            andFilename:(NSString*) filename{

    
    _gamePieceID = [[NSString alloc] initWithString:cityVillId];
    _goldValue = &value;
    _combatValue = &cValue;
    _fileName = [[NSString alloc] initWithString:filename];

    return [super init];
}

+(NSMutableDictionary*) initializeAllCityVill{

    NSMutableDictionary *cityVill = [[NSMutableDictionary alloc]init];
    
    
    return cityVill;


};

@end
