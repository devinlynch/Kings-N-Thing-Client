//
//  CombatBattle.m
//  3004iPhone
//
//  Created by Devin Lynch on 2014-03-31.
//
//

#import "CombatBattle.h"
#import "CombatBattleRound.h"

@implementation CombatBattle
@synthesize attacker, battleId, defender, gameState, locationOfBattle, amIAttacker, currentRound, isEnded, isStarted, state;


-(CombatBattleRound*) createNewRoundFromSerializedJson: (NSDictionary*) json{
    if(json != nil && [json isKindOfClass:[NSDictionary class]]) {
        int lastRoundNum = 0;
        if(currentRound != nil) {
            lastRoundNum = currentRound.roundNumber;
        }
        lastRoundNum++;
        
        CombatBattleRound *round = [[CombatBattleRound alloc] init];
        [round setRoundNumber:lastRoundNum];
        [round setBattle:self];
        [round setRoundId:[json objectForKey:@"roundId"]];
        
        currentRound = round;
    }
    
    return nil;
}

@end
