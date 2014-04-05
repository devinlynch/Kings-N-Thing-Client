//
//  AbstractCombatPhaseBattleScreen.m
//  3004iPhone
//
//  Created by Devin Lynch on 2014-04-04.
//
//

#import "AbstractCombatPhaseBattleScreen.h"

@implementation AbstractCombatPhaseBattleScreen

-(id) initWithBattle: (CombatBattle*) battle andController: (CombatPhaseScreenController*) contoller{
    self = [super initFromCombatController:contoller];
    if(self) {
        _battle = battle;
    }
    return self;
}

-(void) showPiecesForBattleForMe{
    if([_battle amIAttacker]) {
        [self showPiecesMenuForPlayer:_battle.attacker onLocation:(BoardLocation*)_battle.locationOfBattle isOpposingPlayer:NO];
    } else{
        [self showPiecesMenuForPlayer:_battle.defender onLocation:(BoardLocation*)_battle.locationOfBattle isOpposingPlayer:NO];
    }
}

-(void) showPiecesForOpposingPlayer{
    if([_battle amIAttacker]) {
        [self showPiecesMenuForPlayer:_battle.defender onLocation:(BoardLocation*)_battle.locationOfBattle isOpposingPlayer:YES];
    } else{
        [self showPiecesMenuForPlayer:_battle.attacker onLocation:(BoardLocation*)_battle.locationOfBattle isOpposingPlayer:YES];
    }
}

@end
