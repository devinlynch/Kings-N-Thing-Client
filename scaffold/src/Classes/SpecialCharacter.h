//
//  SpecialCharacter.h
//  3004iPhone
//
//  Created by John Marsh on 1/15/2014.
//
//

#import "Counter.h"
#import "SpecialAbility.h"
#import "CombatType.h"

@interface SpecialCharacter : Counter{
    SpecialAbility *_specialAbility;
    NSString *_characterId;
    int _combatValue;
    CombatType *_combatType;
    BOOL _isFlyingCreature;
    BOOL _canCharge;
}

@property SpecialAbility *specialAbility;
@property NSString *characterId;
@property int combatValue;
@property CombatType *combatType;
@property BOOL isFlyingCreature,canCharge;



-(SpecialCharacter*) initWithId:(NSString*) characterId andSpecialAbility:(SpecialAbility*) ability andFilename: (NSString*) filename;


+(NSMutableDictionary*) initializeAllSpecialCharacters;

@end
