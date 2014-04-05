//
//  CombatBattleStepMenu.h
//  3004iPhone
//
//  Created by Devin Lynch on 2014-04-04.
//
//

#import "SPSprite.h"
#import "AbstractCombatPhaseBattleScreen.h"

@interface CombatBattleStepMenu : AbstractCombatPhaseBattleScreen
{
    CombatBattleRound *_round;
}

-(id) initWithRound:(CombatBattleRound *)round andController:(CombatPhaseScreenController *)contoller;

@end
