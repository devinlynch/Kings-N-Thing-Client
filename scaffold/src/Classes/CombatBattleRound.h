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

@property NSMutableDictionary *magicAttackerPiecesTakingHits;
@property NSMutableDictionary *rangeAttackerPiecesTakingHits;
@property NSMutableDictionary *meleeAttackerPiecesTakingHits;

@property NSMutableDictionary *magicDefenderPiecesTakingHits;
@property NSMutableDictionary *rangeDefenderPiecesTakingHits;
@property NSMutableDictionary *meleeDefenderPiecesTakingHits;

-(void) newStepStarted: (NSString*) stepName withJson: (NSDictionary*) json;
-(void) player: (NSString*) playerid tookDamageToPieces: (NSArray*) piecesTakingHits forStep: (NSString*) stepName;
@end
