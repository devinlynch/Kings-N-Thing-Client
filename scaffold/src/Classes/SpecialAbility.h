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

-(SpecialAbility*) initWithId:(NSString*) abilityId andName:(NSString*) name;

@end
