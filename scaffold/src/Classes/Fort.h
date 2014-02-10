//
//  Fort.h
//  3004iPhone
//
//  Created by John Marsh on 1/15/2014.
//
//

#import "Counter.h"
#import "FortLevel.h"
#import "ScaledGamePiece.h"
#import "CombatType.h"

@interface Fort : Counter{
    NSInteger *_combatValue;
    FortLevel *_fortLevel;
    NSString *_fileName;
}

@property NSInteger *combatValue;
@property NSString *fileName;
@property FortLevel *fortLevel;



-(void) takeHit: (int) damage;

-(Fort*) initWithId:(NSString*) fortId andCombatValue:(int) value
        andCombatType:(CombatType*) combat
        andFortLevel:(FortLevel*) level
        andFileName:(NSString*) fileName;

+(NSMutableDictionary*)initializeAllForts;

@end
