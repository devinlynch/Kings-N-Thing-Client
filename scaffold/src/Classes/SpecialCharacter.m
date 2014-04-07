//
//  SpecialCharacter.m
//  3004iPhone
//
//  Created by John Marsh on 1/15/2014.
//
//

#import "SpecialCharacter.h"
#import "SpecialAbility.h"
#import "ScaledGamePiece.h"

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
    
    _pieceImage = [[ScaledGamePiece alloc] initWithContentsOfFile:filename andOwner:self];
    [_pieceImage addEventListener:@selector(creatureDoubleClick:) atObject:self forType:SP_EVENT_TYPE_TOUCH];

    
    return self;
}

-(void) creatureDoubleClick: (SPTouchEvent*) event
{
    NSArray *touches = [[event touchesWithTarget:[self pieceImage] andPhase:SPTouchPhaseBegan] allObjects];
    
    if (touches.count == 1)
    {
        //Double Click
        SPTouch *clicks = [touches objectAtIndex:0];
        if (clicks.tapCount == 2){
            NSLog(@"le double click");
            [[NSNotificationCenter defaultCenter] postNotificationName:@"pieceSelected" object:self];
        }
        
    }
    
}


+(NSMutableDictionary*) initializeAllSpecialCharacters{
    NSMutableDictionary * specialCharacters = [[NSMutableDictionary alloc] init];
    
    [specialCharacters setObject:[[SpecialCharacter alloc] initWithId:@"specialcharacter_01" andSpecialAbility: [SpecialAbility getmarkmanCounterInstance] andFilename:@"SC_395.png" andCombatType:[CombatType getRangeInstance] andCombatValue:5 andCanCharge:false andIsFlyingCreature:true] forKey:@"specialcharacter_01"];
    [specialCharacters setObject:[[SpecialCharacter alloc] initWithId:@"specialcharacter_06" andSpecialAbility: [SpecialAbility getmarkmanCounterInstance] andFilename:@"SC_383.png" andCombatType:[CombatType getMeleeInstance] andCombatValue:4 andCanCharge:false andIsFlyingCreature:false] forKey:@"specialcharacter_06"];
    [specialCharacters setObject:[[SpecialCharacter alloc] initWithId:@"specialcharacter_05" andSpecialAbility: [SpecialAbility geteliminatecounterNocombatInstance] andFilename:@"SC_397.png" andCombatType:[CombatType getMagicInstance] andCombatValue:4 andCanCharge:false andIsFlyingCreature:false] forKey:@"specialcharacter_05"];
    [specialCharacters setObject:[[SpecialCharacter alloc] initWithId:@"specialcharacter_08" andSpecialAbility: [SpecialAbility getmarkmanCounterInstance] andFilename:@"SC_385.png" andCombatType:[CombatType getRangeInstance] andCombatValue:6 andCanCharge:false andIsFlyingCreature:true] forKey:@"specialcharacter_08"];
    [specialCharacters setObject:[[SpecialCharacter alloc] initWithId:@"specialcharacter_07" andSpecialAbility: [SpecialAbility getmarkmanCounterInstance] andFilename:@"SC_391.png" andCombatType:[CombatType getMeleeInstance] andCombatValue:4 andCanCharge:false andIsFlyingCreature:false] forKey:@"specialcharacter_07"];
    [specialCharacters setObject:[[SpecialCharacter alloc] initWithId:@"specialcharacter_02" andSpecialAbility: [SpecialAbility getmarkmanCounterInstance] andFilename:@"SC_401.png" andCombatType:[CombatType getMeleeInstance] andCombatValue:5 andCanCharge:false andIsFlyingCreature:false] forKey:@"specialcharacter_02"];
    [specialCharacters setObject:[[SpecialCharacter alloc] initWithId:@"specialcharacter_04" andSpecialAbility: [SpecialAbility getmarkmanCounterInstance] andFilename:@"SC_403.png" andCombatType:[CombatType getMeleeInstance] andCombatValue:5 andCanCharge:false andIsFlyingCreature:false] forKey:@"specialcharacter_04"];
    [specialCharacters setObject:[[SpecialCharacter alloc] initWithId:@"specialcharacter_03" andSpecialAbility: [SpecialAbility getmarkmanCounterInstance] andFilename:@"SC_389.png" andCombatType:[CombatType getMagicInstance] andCombatValue:6 andCanCharge:false andIsFlyingCreature:false] forKey:@"specialcharacter_03"];
    [specialCharacters setObject:[[SpecialCharacter alloc] initWithId:@"specialcharacter_10" andSpecialAbility: [SpecialAbility getswordElimnatorInstance] andFilename:@"SC_399.png" andCombatType:[CombatType getMeleeInstance] andCombatValue:4 andCanCharge:false andIsFlyingCreature:false] forKey:@"specialcharacter_10"];
    [specialCharacters setObject:[[SpecialCharacter alloc] initWithId:@"specialcharacter_11" andSpecialAbility: [SpecialAbility getmarkmanCounterInstance] andFilename:@"SC_389.png" andCombatType:[CombatType getMagicInstance] andCombatValue:5 andCanCharge:false andIsFlyingCreature:false] forKey:@"specialcharacter_11"];
    [specialCharacters setObject:[[SpecialCharacter alloc] initWithId:@"specialcharacter_09" andSpecialAbility: [SpecialAbility getmasterCounterTheftInstance] andFilename:@"SC_393.png" andCombatType:[CombatType getMeleeInstance] andCombatValue:4 andCanCharge:false andIsFlyingCreature:false] forKey:@"specialcharacter_09"];
    
    [specialCharacters setObject:[[SpecialCharacter alloc] initWithId:@"specialcharacter_12" andSpecialAbility: [SpecialAbility getsupportingTerrainLordInstance] andFilename:@"SC_384.png" andCombatType:[CombatType getMeleeInstance] andCombatValue:4 andCanCharge:false andIsFlyingCreature:false] forKey:@"specialcharacter_12"];
    [specialCharacters setObject:[[SpecialCharacter alloc] initWithId:@"specialcharacter_13" andSpecialAbility: [SpecialAbility getsupportingTerrainLordInstance] andFilename:@"SC_386.png" andCombatType:[CombatType getMeleeInstance] andCombatValue:4 andCanCharge:false andIsFlyingCreature:false] forKey:@"specialcharacter_13"];
    [specialCharacters setObject:[[SpecialCharacter alloc] initWithId:@"specialcharacter_14" andSpecialAbility: [SpecialAbility getsupportingTerrainLordInstance] andFilename:@"SC_388.png" andCombatType:[CombatType getMeleeInstance] andCombatValue:4 andCanCharge:false andIsFlyingCreature:false] forKey:@"specialcharacter_14"];
    [specialCharacters setObject:[[SpecialCharacter alloc] initWithId:@"specialcharacter_15" andSpecialAbility: [SpecialAbility getsupportingTerrainLordInstance] andFilename:@"SC_396.png" andCombatType:[CombatType getMeleeInstance] andCombatValue:4 andCanCharge:false andIsFlyingCreature:false] forKey:@"specialcharacter_15"];
    [specialCharacters setObject:[[SpecialCharacter alloc] initWithId:@"specialcharacter_16" andSpecialAbility: [SpecialAbility getsupportingTerrainLordInstance] andFilename:@"SC_398.png" andCombatType:[CombatType getMeleeInstance] andCombatValue:4 andCanCharge:false andIsFlyingCreature:false] forKey:@"specialcharacter_16"];
    [specialCharacters setObject:[[SpecialCharacter alloc] initWithId:@"specialcharacter_17" andSpecialAbility: [SpecialAbility getsupportingTerrainLordInstance] andFilename:@"SC_400.png" andCombatType:[CombatType getMeleeInstance] andCombatValue:4 andCanCharge:false andIsFlyingCreature:false] forKey:@"specialcharacter_17"];
    [specialCharacters setObject:[[SpecialCharacter alloc] initWithId:@"specialcharacter_18" andSpecialAbility: [SpecialAbility getsupportingTerrainLordInstance] andFilename:@"SC_402.png" andCombatType:[CombatType getMeleeInstance] andCombatValue:4 andCanCharge:false andIsFlyingCreature:false] forKey:@"specialcharacter_18"];
    

    return specialCharacters;
}


@end
