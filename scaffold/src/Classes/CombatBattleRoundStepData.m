//
//  CombatBattleRoundStepData.m
//  3004iPhone
//
//  Created by Devin Lynch on 2014-04-01.
//
//

#import "CombatBattleRoundStepData.h"
#import "GameState.h"
#import "GamePiece.h"
#import "GameResource.h"

@implementation CombatBattleRoundStepData
@synthesize attackerDamageablePieces,attackerGamePiecesToRolls,attackerHitCount,defenderDamageablePieces,defenderGamePiecesToRolls,defenderHitCount;

-(id) init{
    self = [super init];
    if(self) {
        attackerDamageablePieces = [[NSMutableDictionary alloc] init];
        defenderDamageablePieces = [[NSMutableDictionary alloc] init];
        attackerGamePiecesToRolls = [[NSMutableDictionary alloc] init];
        defenderGamePiecesToRolls = [[NSMutableDictionary alloc] init];
    }
    return self;
}

-(id) initFromJson: (NSDictionary*) json forGameState:(GameState*) gameState{
    self = [self init];
    if(self) {
        for(NSString* gpId in [json objectForKey:@"attackerDamageablePieces"]) {
            GamePiece* p = [[GameResource getInstance] getPieceForId:gpId];
            if(p == nil) {
                NSLog(@"ERROR: Game piece by id %@ was not foun in game resource when trying to init CombatBattleRoundStepData", gpId);
                continue;
            }
            [attackerDamageablePieces setObject:p forKey:gpId];
        }
        
        for(NSString* gpId in [json objectForKey:@"defenderDamageablePieces"]) {
            GamePiece* p = [[GameResource getInstance] getPieceForId:gpId];
            if(p == nil) {
                NSLog(@"ERROR: Game piece by id %@ was not foun in game resource when trying to init CombatBattleRoundStepData", gpId);
                continue;
            }
            [defenderDamageablePieces setObject:p forKey:gpId];
        }
        
        for(NSDictionary* pieceToRollDic in [json objectForKey:@"defenderGamePiecesToRolls"]) {
            NSString *gpId = [[NSString alloc] initWithString:[pieceToRollDic objectForKey:@"gamePieceId"]];
            NSNumber *roll = [pieceToRollDic objectForKey:@"roll"];
            [defenderGamePiecesToRolls setObject:roll forKey:gpId];
        }
        
        for(NSDictionary* pieceToRollDic in [json objectForKey:@"attackerGamePiecesToRolls"]) {
            NSString *gpId = [[NSString alloc] initWithString:[pieceToRollDic objectForKey:@"gamePieceId"]];
            NSNumber *roll = [pieceToRollDic objectForKey:@"roll"];
            [attackerGamePiecesToRolls setObject:roll forKey:gpId];
        }
        
        defenderHitCount = [[json objectForKey:@"definderHitCount"] intValue];
        attackerHitCount = [[json objectForKey:@"attackerHitCount"] intValue];
    }
    return self;
}


@end
