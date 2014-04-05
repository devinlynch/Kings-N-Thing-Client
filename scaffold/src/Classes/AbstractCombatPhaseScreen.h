//
//  AnstractCombatPhaseScreen.h
//  3004iPhone
//
//  Created by Devin Lynch on 2014-04-04.
//
//

#import "SPSprite.h"
#import "AbstractInGameScreen.h"

@class CombatPhaseScreenController;
@interface AbstractCombatPhaseScreen : AbstractInGameScreen
{
    CombatPhaseScreenController *_combatController;
}

-(id) initFromCombatController: (CombatPhaseScreenController*) controller;

@end
