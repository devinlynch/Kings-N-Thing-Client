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

@class Player, HexLocation, GameState, CombatBattleRound, CombatPhase;
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
@property BOOL isAIDefender;
@property CombatBattleState state;
@property NSMutableArray *battleLog;
@property CombatPhase *combatPhase;


-(id) initWithCombatPhase: (CombatPhase*) cp;
-(CombatBattleRound*) createNewRoundFromSerializedJson: (NSDictionary*) json;
-(BOOL) amIInTheBattle;
-(void) didEndWithJson: (NSDictionary*) json;
+(void) subscribeToBattleNotifications: (id) subscriber andSelector: (SEL)selector;
+(void) unsubscribeToBattleNotifications: (id) subscriber;

+(void) updateGameState: (GameState*) gameState FromBattleJson:(NSDictionary*) json;
-(void) addMessageToBattleLog: (NSString *) string;
-(void) handlePlayerRetreated: (NSDictionary*) json;

@end
