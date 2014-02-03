//
//  Creature.h
//  3004iPhone
//
//  Created by John Marsh on 1/15/2014.
//
//

#import "Thing.h"


@class Terrain, CombatType;

@interface Creature : Thing{
    int _combatValue;
    CombatType *_combatType;
    Terrain *_terrain;
}

@property int combatValue;
@property CombatType *combatType;
@property Terrain *terrain;


-(Creature*) initWithId:(NSString*) creatureId andCombatValue: (int) value andCombatType: (CombatType*) type andTerrain: (Terrain*) t andFilename: (NSString*) filename;

+(NSMutableDictionary*) initializeAllCreatures;

@end
