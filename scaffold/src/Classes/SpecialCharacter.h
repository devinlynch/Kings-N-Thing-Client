//
//  SpecialCharacter.h
//  3004iPhone
//
//  Created by John Marsh on 1/15/2014.
//
//

#import "CounterType.h"
#import "SpecialAbility.h"

@interface SpecialCharacter : CounterType{
    SpecialAbility *_specialAbility;
}

@property SpecialAbility *specialAbility;

@end
