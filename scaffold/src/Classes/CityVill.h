//
//  CityVil.h
//  3004iPhone
//
//  Created by John Marsh on 1/15/2014.
//
//

#import "SpecialIncomeCounters.h"

@interface CityVill : SpecialIncomeCounters{
    int _combatValue;
    //NSString *_fileName;
}

@property int combatValue;
@property NSString *fileName;

-(CityVill*) initWithId:(NSString*) cityVillId
           andGoldValue:(int) value
         andCombatValue:(int) cValue
            andFilename:(NSString*) filename;

+(NSMutableDictionary*) initializeAllCityVill;




@end
