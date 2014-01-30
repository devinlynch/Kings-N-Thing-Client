//
//  Creature.h
//  3004iPhone
//
//  Created by John Marsh on 1/15/2014.
//
//

#import "Thing.h"
#import "CombatType.h"
#import "Terrain.h"

@interface Creature : Thing{
    NSInteger *_combatValue;
    CombatType *_combatType;
    Terrain *_terrain;
}

@property NSInteger *combatValue;
@property CombatType *combatType;
@property Terrain *terrain;

@end
