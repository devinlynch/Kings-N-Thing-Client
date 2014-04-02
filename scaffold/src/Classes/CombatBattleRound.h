//
//  CombatBattleRound.h
//  3004iPhone
//
//  Created by Devin Lynch on 2014-03-31.
//
//

#import <Foundation/Foundation.h>
#import "CombatBattleRoundStepData.h"

typedef enum CombatRoundState {
    NOT_STARTED,
    MAGIC_STEP,
    RANGE_STEP,
    MELEE_STEP,
    WAITING_ON_RETREAT_OR_CONTINUE,
    ROUND_ENDED
} CombatRoundState;

@class CombatBattle;
@interface CombatBattleRound : NSObject

@property CombatRoundState state;
@property CombatBattle *battle;
@property NSString *roundId;
@property int roundNumber;

@property CombatBattleRoundStepData *magicData;
@property CombatBattleRoundStepData *rangeData;
@property CombatBattleRoundStepData *meleeData;

@property NSMutableDictionary *magicPiecesTakingHits;
@property NSMutableDictionary *rangePiecesTakingHits;
@property NSMutableDictionary *meleePiecesTakingHits;



@end
