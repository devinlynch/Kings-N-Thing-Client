//
//  CombatPhase.h
//  3004iPhone
//
//  Created by Devin Lynch on 2014-04-01.
//
//

#import <Foundation/Foundation.h>
@class GameState, CombatBattle;

@interface CombatPhase : NSObject

@property NSMutableDictionary *battles;
@property GameState *gameState;
@property CombatBattle *currentBattle;
@property NSMutableArray *combatPhaseLog;


-(CombatBattle*) updateOrCreateBattleFromJson: (NSDictionary*) json;
-(id) initWithGameState: (GameState*) _gameState;
-(void) addLogMessage: (NSString*) message;

@end
