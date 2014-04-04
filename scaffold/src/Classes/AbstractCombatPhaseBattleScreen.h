//
//  AbstractCombatPhaseBattleScreen.h
//  3004iPhone
//
//  Created by Devin Lynch on 2014-04-04.
//
//

#import "SPSprite.h"
#import "AbstractCombatPhaseScreen.h"
#import "CombatBattle.h"
#import "CombatBattleRound.h"

@interface AbstractCombatPhaseBattleScreen : AbstractCombatPhaseScreen
{
    CombatBattle *_battle;
}
-(id) initWithBattle: (CombatBattle*) battle andController: (CombatPhaseScreenController*) contoller;
-(void) showPiecesForOpposingPlayer;
-(void) showPiecesForBattleForMe;

@end
