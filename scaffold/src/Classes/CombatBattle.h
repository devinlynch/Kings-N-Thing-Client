//
//  CombatBattle.h
//  3004iPhone
//
//  Created by Devin Lynch on 2014-03-31.
//
//

#import <Foundation/Foundation.h>

typedef enum CombatBattleState {
    IN_PROGRESS,
    ATTACKER_RETREATED,
    DEFENDER_REREATED,
    ATTACKER_WON,
    DEFENDER_WON
} CombatBattleState;

@class Player, HexLocation, GameState, CombatBattleRound;
@interface CombatBattle : NSObject
{
}

@property NSString *battleId;
@property Player *attacker;
@property Player *defender;
@property HexLocation *locationOfBattle;
@property GameState *gameState;
@property CombatBattleRound *currentRound;
@property BOOL amIAttacker;
@property BOOL isStarted;
@property BOOL isEnded;
@property CombatBattleState state;

-(CombatBattleRound*) createNewRoundFromSerializedJson: (NSDictionary*) json;

@end
