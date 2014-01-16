//
//  SpecialCharacter.h
//  3004iPhone
//
//  Created by John Marsh on 1/15/2014.
//
//

#import "Counter.h"
#import "SpecialAbility.h"

@interface SpecialCharacter : Counter{
    SpecialAbility *_specialAbility;
}

@property SpecialAbility *specialAbility;

@end
