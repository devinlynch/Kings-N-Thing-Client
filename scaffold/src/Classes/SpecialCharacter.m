//
//  SpecialCharacter.m
//  3004iPhone
//
//  Created by John Marsh on 1/15/2014.
//
//

#import "SpecialCharacter.h"
#import "SpecialAbility.h"

@implementation SpecialCharacter

@synthesize specialAbility = _specialAbility;
@synthesize characterId = _characterId;
@synthesize combatType = _combatType;
@synthesize combatValue = _combatValue;
@synthesize canCharge = _canCharge;
@synthesize isFlyingCreature = _isFlyingCreature;

-(SpecialCharacter*) initWithId:(NSString*) characterId andSpecialAbility:(SpecialAbility*) ability andFilename: (NSString*) filename andCombatType: (CombatType*) combatType andCombatValue: (int) combatValue andCanCharge: (BOOL) canCharge andIsFlyingCreature: (BOOL) isFlyingCreature{
    self = [super init];
    _gamePieceId = [[NSString alloc] initWithString:characterId];
    _specialAbility = ability;
    _fileName = filename;
    _combatValue = combatValue;
    _combatType = combatType;
    _canCharge = canCharge;
    _isFlyingCreature = isFlyingCreature;
    return self;
}


+(NSMutableDictionary*) initializeAllSpecialCharacters{
    NSMutableDictionary * specialCharacters = [[NSMutableDictionary alloc] init];
    
    [specialCharacters setObject:[[SpecialCharacter alloc] initWithId:@"specialcharacter_01" andSpecialAbility: [SpecialAbility getmarkmanCounterInstance] andFilename:@"SC_395.png" andCombatType:[CombatType getRangeInstance] andCombatValue:4 andCanCharge:false andIsFlyingCreature:true] forKey:@"specialcharacter_01"];
    [specialCharacters setObject:[[SpecialCharacter alloc] initWithId:@"specialcharacter_06" andSpecialAbility: [SpecialAbility getmarkmanCounterInstance] andFilename:@"SC_383.png" andCombatType:[CombatType getMeleeInstance] andCombatValue:4 andCanCharge:false andIsFlyingCreature:false] forKey:@"specialcharacter_06"];
    [specialCharacters setObject:[[SpecialCharacter alloc] initWithId:@"specialcharacter_05" andSpecialAbility: [SpecialAbility geteliminatecounterNocombatInstance] andFilename:@"SC_397.png" andCombatType:[CombatType getMagicInstance] andCombatValue:4 andCanCharge:false andIsFlyingCreature:false] forKey:@"specialcharacter_05"];
    [specialCharacters setObject:[[SpecialCharacter alloc] initWithId:@"specialcharacter_08" andSpecialAbility: [SpecialAbility getmarkmanCounterInstance] andFilename:@"SC_385.png" andCombatType:[CombatType getRangeInstance] andCombatValue:4 andCanCharge:false andIsFlyingCreature:true] forKey:@"specialcharacter_08"];
    [specialCharacters setObject:[[SpecialCharacter alloc] initWithId:@"specialcharacter_07" andSpecialAbility: [SpecialAbility getmarkmanCounterInstance] andFilename:@"SC_391.png" andCombatType:[CombatType getMeleeInstance] andCombatValue:4 andCanCharge:false andIsFlyingCreature:false] forKey:@"specialcharacter_07"];
    [specialCharacters setObject:[[SpecialCharacter alloc] initWithId:@"specialcharacter_02" andSpecialAbility: [SpecialAbility getmarkmanCounterInstance] andFilename:@"SC_401.png" andCombatType:[CombatType getMeleeInstance] andCombatValue:4 andCanCharge:false andIsFlyingCreature:false] forKey:@"specialcharacter_02"];
    [specialCharacters setObject:[[SpecialCharacter alloc] initWithId:@"specialcharacter_04" andSpecialAbility: [SpecialAbility getmarkmanCounterInstance] andFilename:@"SC_403.png" andCombatType:[CombatType getMeleeInstance] andCombatValue:4 andCanCharge:false andIsFlyingCreature:false] forKey:@"specialcharacter_04"];
    [specialCharacters setObject:[[SpecialCharacter alloc] initWithId:@"specialcharacter_03" andSpecialAbility: [SpecialAbility getmarkmanCounterInstance] andFilename:@"SC_389.png" andCombatType:[CombatType getMagicInstance] andCombatValue:4 andCanCharge:false andIsFlyingCreature:false] forKey:@"specialcharacter_03"];
    [specialCharacters setObject:[[SpecialCharacter alloc] initWithId:@"specialcharacter_10" andSpecialAbility: [SpecialAbility getswordElimnatorInstance] andFilename:@"SC_399.png" andCombatType:[CombatType getMeleeInstance] andCombatValue:4 andCanCharge:false andIsFlyingCreature:false] forKey:@"specialcharacter_10"];
    [specialCharacters setObject:[[SpecialCharacter alloc] initWithId:@"specialcharacter_11" andSpecialAbility: [SpecialAbility getmarkmanCounterInstance] andFilename:@"SC_389.png" andCombatType:[CombatType getMagicInstance] andCombatValue:4 andCanCharge:false andIsFlyingCreature:false] forKey:@"specialcharacter_11"];
    [specialCharacters setObject:[[SpecialCharacter alloc] initWithId:@"specialcharacter_09" andSpecialAbility: [SpecialAbility getmasterCounterTheftInstance] andFilename:@"SC_393.png" andCombatType:[CombatType getMeleeInstance] andCombatValue:4 andCanCharge:false andIsFlyingCreature:false] forKey:@"specialcharacter_09"];

    return specialCharacters;
}


@end
