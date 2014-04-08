//
//  CombatPhaseHandler.m
//  3004iPhone
//
//  Created by Devin Lynch on 2014-03-29.
//
//

#import "CombatPhaseHandler.h"
#import "Event.h"
#import "Game.h"
#import "CombatPhase.h"
#import "Utils.h"
#import "CombatBattle.h"
#import "CombatBattleRound.h"
#import "User.h"
#import "GameResource.h"

@implementation CombatPhaseHandler

-(void) handleCombatPhaseStarted: (Event*) event{
    NSLog(@"Succesfully handled handleCombatPhaseStarted message");
    
    [Game addLogMessageToCurrentGame:@"The combat phase has started, prepare for battle!"];
    
    [[[Game currentGame] gameState] startNewCombatPhase];
}

-(void) handleBattleStarted: (Event*) event{
    NSLog(@"Handling handleBattleStarted message");

    NSDictionary* dataDic = [Utils getDataDictionaryFromGameMessageEvent:event];
    NSDictionary *battleDic = [dataDic objectForKey:@"battle"];
    
    runOnMainQueueWithoutDeadlocking(^{
        CombatPhase *combatPhase = [[[Game currentGame] gameState] getOrCreateCombatPhase];
        CombatBattle *battle = [combatPhase updateOrCreateBattleFromJson: battleDic];
        combatPhase.currentBattle = battle;
        
        if(battle != nil && [battle amIInTheBattle]){
            [Utils notifyOnMainQueue:@"combatBattleStarted" withObject:battle];
        }
        
        if(battle != nil){
            [battle addMessageToBattleLog:[NSString stringWithFormat:@"A battle between %@ and %@ has started on %@", battle.attacker.user.username, battle.defender.user.username, battle.locationOfBattle.locationName]];
        }
        
        NSLog(@"Finished handling handleBattleStarted message");
    });
}


-(void) handleCombatRoundStarted: (Event*) event{
    NSLog(@"Handling handleCombatRoundStarted message");
    
    NSDictionary* dataDic = [Utils getDataDictionaryFromGameMessageEvent:event];
   
    CombatBattle* battle = [self getBattleOrRaiseExceptionFromJson:dataDic];
    if(battle == nil)
        return;
    
    runOnMainQueueWithoutDeadlocking(^{
        CombatBattleRound *round = [battle createNewRoundFromSerializedJson:dataDic];
        if(round==nil) {
            [NSException raise:@"Round could not be created!" format:@""];
            return;
        }
        
         NSLog(@"Finished handling handleCombatRoundStarted message");
    });
}

-(void) handleCombatStepStarted: (Event*) event{
    NSLog(@"Handling handleCombatStepStarted message");
    
    NSDictionary* dataDic = [Utils getDataDictionaryFromGameMessageEvent:event];
    
    CombatBattle* battle = [self getBattleOrRaiseExceptionFromJson:dataDic];
    if(battle == nil)
        return;
    
    CombatBattleRound *round = [self getRoundOrRaiseExceptionFromJson:dataDic forBattle:battle];
    if(round == nil)
        return;
    
    runOnMainQueueWithoutDeadlocking(^{
        [round newStepStarted:[dataDic objectForKey:@"stepName"] withJson:dataDic];
    });
}

-(void) handlePlayerTookDamageInBattle: (Event*) event{
    NSLog(@"Handling handlePlayerTookDamageInBattle message");
    
    NSDictionary* dataDic = [Utils getDataDictionaryFromGameMessageEvent:event];
    
    CombatBattle* battle = [self getBattleOrRaiseExceptionFromJson:dataDic];
    if(battle == nil)
        return;
    
    CombatBattleRound *round = [self getRoundOrRaiseExceptionFromJson:dataDic forBattle:battle];
    if(round == nil)
        return;
    
    NSString* stepName = [dataDic objectForKey:@"stepName"];
    NSString* playerId = [dataDic objectForKey:@"playerId"];
    NSDictionary* hexLocationDic = [dataDic objectForKey:@"locationOfBattle"];
    NSArray * gamePiecesTakingHitsIds = [dataDic objectForKey:@"gamePiecesTakingHitsIds"];
    
    runOnMainQueueWithoutDeadlocking(^{
        [round player:playerId tookDamageToPieces:gamePiecesTakingHitsIds forStep:stepName];
        
        NSString *hexLocId = [hexLocationDic objectForKey:@"locationId"];
        HexLocation *loc = (HexLocation*)[[[Game currentGame] gameState] getBoardLocationById:hexLocId];
        if(loc != nil) {
            [loc updateLocationFromSerializedJSONDictionary:hexLocationDic];
        }
    });
}

-(void)handleRoundResulutionTime: (Event*) event{
    NSLog(@"Handling handleRoundResulutionTime message");
    
    NSDictionary* dataDic = [Utils getDataDictionaryFromGameMessageEvent:event];
    
    CombatBattle* battle = [self getBattleOrRaiseExceptionFromJson:dataDic];
    if(battle == nil)
        return;
    
    CombatBattleRound *round = [self getRoundOrRaiseExceptionFromJson:dataDic forBattle:battle];
    if(round == nil)
        return;
    
    [round makeItTimeToRetreatOrContinue];
}

-(void) handleRetreatCouldNotTakePlace: (Event*) event{
    
}

-(void) handlePlayerRetreatedFromBattle: (Event*) event{
    NSLog(@"Handling handlePlayerRetreatedFromBattle message");
    
    NSDictionary* dataDic = [Utils getDataDictionaryFromGameMessageEvent:event];
    
    CombatBattle* battle = [self getBattleOrRaiseExceptionFromJson:dataDic];
    if(battle == nil)
        return;
    
    runOnMainQueueWithoutDeadlocking(^{
        [battle handlePlayerRetreated: dataDic];
    });
}

-(void) handleBattleOver: (Event*) event{
    NSLog(@"Handling handleBattleOver message");
    
    NSDictionary* dataDic = [Utils getDataDictionaryFromGameMessageEvent:event];
    
    CombatBattle* battle = [self getBattleOrRaiseExceptionFromJson:dataDic];
    if(battle == nil)
        return;
    
    runOnMainQueueWithoutDeadlocking(^{
        [battle didEndWithJson: dataDic];
    });
}

-(CombatBattleRound*) getRoundOrRaiseExceptionFromJson: (NSDictionary*) json forBattle: (CombatBattle*) battle{
    NSString *roundId = [json objectForKey:@"roundId"];
    if(battle.currentRound == nil || roundId== nil || ![battle.currentRound.roundId isEqualToString:roundId]) {
        [NSException raise:@"Error getting the correct round needed for combat" format:@"The current round in the message was %@", roundId];
        return nil;
    }
    
    return battle.currentRound;
}

-(CombatBattle*) getBattleOrRaiseExceptionFromJson: (NSDictionary*) json{
    CombatPhase *combatPhase = [[[Game currentGame] gameState] getOrCreateCombatPhase];
    CombatBattle *battle = [combatPhase currentBattle];
    NSString *battleId = [json objectForKey:@"battleId"];

    if(battle == nil || battleId == nil || ![battle.battleId isEqualToString:battleId]) {
        NSLog(@"ERRORRRR!!!!!!!!!!!!!!!!!!  We got a message for a battle that is not current.  The current battle is %@ and the one we expected was %@", battle.battleId, battleId);
        [NSException raise:@"We got a round started message for a battle that is not current." format:@"The current battle is %@ and the one we expected was %@", battle.battleId, battleId];
        return nil;
    }
    
    return battle;
}

/*
 msg.addToData("playerCallingBluffId", player.getPlayerId());
 msg.addToData("playerCalledOutId", owner.getPlayerId());
 msg.addToData("calledOutPiece", p);*/
-(void) handleCalledOutBluff:(Event*) event{
    NSDictionary* dataDic = [Utils getDataDictionaryFromGameMessageEvent:event];
    
    NSString* calledOutPlayerId = [dataDic objectForKey:@"playerCalledOutId"];
    NSString* playerCallingBluffId = [dataDic objectForKey:@"playerCallingBluffId"];
    NSDictionary* pieceDic =[dataDic objectForKey:@"calledOutPiece"];
    GamePiece* piece = [[GameResource getInstance] getPieceForId:[pieceDic objectForKey:@"id"]];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [piece updateFromSerializedJson:pieceDic forGameState:[[Game currentGame] gameState]];
        [Game addLogMessageToCurrentGame:[NSString stringWithFormat:@"Player got called out on their bluff"]];
    });
}

@end
