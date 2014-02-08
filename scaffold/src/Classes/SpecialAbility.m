//
//  SpecialAbility.m
//  3004iPhone
//
//  Created by John Marsh on 1/15/2014.
//
//

#import "SpecialAbility.h"

@implementation SpecialAbility

@synthesize specialAbilityID = _specialAbilityID;
@synthesize specialAbilityName = _specialAbilityName;


static SpecialAbility *eliminatecounterNocombat = nil;

+(SpecialAbility*) geteliminatecounterNocombatInstance {
    if(eliminatecounterNocombat == nil){
        eliminatecounterNocombat = [[SpecialAbility alloc] initWithId: @"SA_eliminatecounterNocombat" andName: @"eliminatecounterNocombat"];
    }
    return eliminatecounterNocombat;
}

static SpecialAbility *hitsBeforeRoundStarts = nil;

+(SpecialAbility*) gethitsBeforeRoundStartsInstance {
    if(hitsBeforeRoundStarts == nil){
        hitsBeforeRoundStarts = [[SpecialAbility alloc] initWithId: @"SA_hitsBeforeRoundStarts" andName: @"hitsBeforeRoundStarts"];
    }
    return hitsBeforeRoundStarts;
}

static SpecialAbility *movementAnyTerrain = nil;

+(SpecialAbility*) getmovementAnyTerrainInstance {
    if(movementAnyTerrain == nil){
        movementAnyTerrain = [[SpecialAbility alloc] initWithId: @"SA_movementAnyTerrain" andName: @"movementAnyTerrain"];
    }
    
    return movementAnyTerrain;
}
static SpecialAbility *goldValueDoubled = nil;

+(SpecialAbility*) getgoldValueDoubledInstance {
    if(goldValueDoubled == nil){
        goldValueDoubled = [[SpecialAbility alloc] initWithId: @"SA_goldValueDoubled" andName: @"goldValueDoubled"];
    }
    return goldValueDoubled;
}

static SpecialAbility *markmanCounter = nil;

+(SpecialAbility*) getmarkmanCounterInstance {
    if(markmanCounter == nil){
        markmanCounter = [[SpecialAbility alloc] initWithId: @"SA_markmanCounter" andName: @"markmanCounter"];
    }
    return markmanCounter;
}

static SpecialAbility *masterCounterTheft = nil;

+(SpecialAbility*) getmasterCounterTheftInstance {
    if(masterCounterTheft == nil){
        masterCounterTheft = [[SpecialAbility alloc] initWithId: @"SA_masterCounterTheft" andName: @"masterCounterTheft"];
    }
    return masterCounterTheft;
}

static SpecialAbility *swordElimnator = nil;

+(SpecialAbility*) getswordElimnatorInstance {
    if(swordElimnator == nil){
        swordElimnator = [[SpecialAbility alloc] initWithId: @"SA_swordElimnator" andName: @"swordElimnator"];
    }
    return swordElimnator;
}

static SpecialAbility *supportingTerrainLord = nil;

+(SpecialAbility*) getsupportingTerrainLordInstance {
    if(supportingTerrainLord == nil){
        supportingTerrainLord = [[SpecialAbility alloc] initWithId: @"SA_supportingTerrainLord" andName: @"supportingTerrainLord"];
    }
    return supportingTerrainLord;
}

static SpecialAbility *warlordJoinMySide = nil;

+(SpecialAbility*) getwarlordJoinMySideInstance {
    if(warlordJoinMySide == nil){
        warlordJoinMySide = [[SpecialAbility alloc] initWithId: @"SA_warlordJoinMySide" andName: @"warlordJoinMySide"];
    } 
    return warlordJoinMySide;
}

-(SpecialAbility*) initWithId:(NSString *)abilityId andName:(NSString *)name{
    _specialAbilityID = [[NSString alloc] initWithString:abilityId];
    _specialAbilityName = [[NSString alloc] initWithString:name];
    return [super init];
}

@end
