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
//@synthesize fileName = _fileName;




-(CityVill*) initWithId:(NSString*) cityVillId
           andGoldValue:(int) value
         andCombatValue:(int) cValue
            andFilename:(NSString*) filename{
    self=[super init];
    
    _gamePieceId = [[NSString alloc] initWithString:cityVillId];
    _goldValue = value;
    _combatValue = cValue;
    _fileName = [[NSString alloc] initWithString:filename];

    return self;
}

+(NSMutableDictionary*) initializeAllCityVill{

    NSMutableDictionary *cityVill = [[NSMutableDictionary alloc]init];
    
    [cityVill setObject:[[CityVill alloc] initWithId:@"city_01"
                                        andGoldValue:2 andCombatValue:2 andFilename:@"C_City.png"] forKey:@"city_01"];
    [cityVill setObject:[[CityVill alloc] initWithId:@"city_02"
                                        andGoldValue:2 andCombatValue:2 andFilename:@"C_City.png"] forKey:@"city_02"];
    [cityVill setObject:[[CityVill alloc] initWithId:@"city_03"
                                        andGoldValue:2 andCombatValue:2 andFilename:@"C_City.png"] forKey:@"city_03"];
    [cityVill setObject:[[CityVill alloc] initWithId:@"city_04"
                                        andGoldValue:2 andCombatValue:2 andFilename:@"C_City.png"] forKey:@"city_04"];
    [cityVill setObject:[[CityVill alloc] initWithId:@"city_05"
                                        andGoldValue:2 andCombatValue:2 andFilename:@"C_City.png"] forKey:@"city_05"];
    
    [cityVill setObject:[[CityVill alloc] initWithId:@"village_01"
                                        andGoldValue:2 andCombatValue:2 andFilename:@"C_Village.png"] forKey:@"village_01"];
    [cityVill setObject:[[CityVill alloc] initWithId:@"village_02"
                                        andGoldValue:2 andCombatValue:2 andFilename:@"C_Village.png"] forKey:@"village_02"];
    [cityVill setObject:[[CityVill alloc] initWithId:@"village_03"
                                        andGoldValue:2 andCombatValue:2 andFilename:@"C_Village.png"] forKey:@"village_03"];
    [cityVill setObject:[[CityVill alloc] initWithId:@"village_04"
                                        andGoldValue:2 andCombatValue:2 andFilename:@"C_Village.png"] forKey:@"village_04"];
    [cityVill setObject:[[CityVill alloc] initWithId:@"village_05"
                                        andGoldValue:2 andCombatValue:2 andFilename:@"C_Village.png"] forKey:@"village_05"];
    
    return cityVill;


};

@end
