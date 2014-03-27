//
//  SpecialAbility.h
//  3004iPhone
//
//  Created by John Marsh on 1/15/2014.
//
//

#import <Foundation/Foundation.h>

@interface SpecialAbility : NSObject{
    NSString *_specialAbilityID;
    NSString *_specialAbilityName;

}

@property NSString *specialAbilityID;
@property NSString *specialAbilityName;

-(SpecialAbility*) initWithId:(NSString*) abilityId andName:(NSString*) name;
+(SpecialAbility*) geteliminatecounterNocombatInstance;
+(SpecialAbility*) gethitsBeforeRoundStartsInstance;
+(SpecialAbility*) getmovementAnyTerrainInstance;
+(SpecialAbility*) getgoldValueDoubledInstance;
+(SpecialAbility*) getmarkmanCounterInstance;
+(SpecialAbility*) getmasterCounterTheftInstance;
+(SpecialAbility*) getswordElimnatorInstance;
+(SpecialAbility*) getsupportingTerrainLordInstance; +(SpecialAbility*) getwarlordJoinMySideInstance;

@end
