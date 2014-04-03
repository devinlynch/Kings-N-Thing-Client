//
//  CombatBattleRoundStepData.h
//  3004iPhone
//
//  Created by Devin Lynch on 2014-04-01.
//
//

#import <Foundation/Foundation.h>

@class GameState;

@interface CombatBattleRoundStepData : NSObject

@property NSMutableDictionary *attackerGamePiecesToRolls;
@property NSMutableDictionary *defenderGamePiecesToRolls;

@property int attackerHitCount;
@property int defenderHitCount;

@property NSMutableDictionary *attackerDamageablePieces;
@property NSMutableDictionary *defenderDamageablePieces;

-(id) initFromJson: (NSDictionary*) json forGameState:(GameState*) gameState;

@end
