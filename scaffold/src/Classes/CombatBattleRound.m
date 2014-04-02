//
//  CombatBattleRound.m
//  3004iPhone
//
//  Created by Devin Lynch on 2014-03-31.
//
//

#import "CombatBattleRound.h"
#import "CombatBattle.h"
#import "Player.h"
#import "GameResource.h"

@implementation CombatBattleRound
@synthesize battle,roundId,state,roundNumber, magicData,magicAttackerPiecesTakingHits,meleeData,meleeAttackerPiecesTakingHits,
            rangeData,rangeAttackerPiecesTakingHits,magicDefenderPiecesTakingHits,meleeDefenderPiecesTakingHits,rangeDefenderPiecesTakingHits;

-(id) init{
    self = [super init];
    if(self) {
        self.state = NOT_STARTED;
    }
    return self;
}

-(void) newStepStarted: (NSString*) stepName withJson: (NSDictionary*) json{
    if([stepName isEqualToString:@"magicStep"]) {
        magicData = [[CombatBattleRoundStepData alloc] initFromJson:json forGameState:battle.gameState];
        state = MAGIC_STEP;
    } else if([stepName isEqualToString:@"rangedStep"]){
        rangeData = [[CombatBattleRoundStepData alloc] initFromJson:json forGameState:battle.gameState];
        state = RANGE_STEP;
    } else if([stepName isEqualToString:@"meleeStep"]) {
        meleeData = [[CombatBattleRoundStepData alloc] initFromJson:json forGameState:battle.gameState];
        state = RANGE_STEP;
    } else{
        NSLog(@"ERROR:  Step name [%@] is not a valid step", stepName);
    }
}

-(void) player: (NSString*) playerId tookDamageToPieces: (NSArray*) piecesTakingHits forStep: (NSString*) stepName{
    BOOL isAttacker = NO;
    if(battle.attacker != nil && [playerId isEqualToString:battle.attacker.playerId]) {
        isAttacker = YES;
    } else if(battle.defender != nil && [playerId isEqualToString:battle.defender.playerId]){
        isAttacker = NO;
    } else{
        NSLog(@"ERROR:  Player [%@] is not bart of the battle %@", playerId, battle.battleId);
        return;
    }
    
    if([stepName isEqualToString:@"magicStep"]) {
        if(isAttacker) {
            if(magicAttackerPiecesTakingHits == nil)
                magicAttackerPiecesTakingHits = [[NSMutableDictionary alloc] init];
            [self updateDictionary:magicAttackerPiecesTakingHits WithPieces:piecesTakingHits];
        } else{
            if(magicDefenderPiecesTakingHits == nil)
                magicDefenderPiecesTakingHits = [[NSMutableDictionary alloc] init];
            [self updateDictionary:magicDefenderPiecesTakingHits WithPieces:piecesTakingHits];
        }
    } else if([stepName isEqualToString:@"rangedStep"]){
        if(isAttacker) {
            if(rangeAttackerPiecesTakingHits == nil)
                rangeAttackerPiecesTakingHits = [[NSMutableDictionary alloc] init];
            [self updateDictionary:rangeAttackerPiecesTakingHits WithPieces:piecesTakingHits];
        } else{
            if(rangeDefenderPiecesTakingHits == nil)
                rangeDefenderPiecesTakingHits = [[NSMutableDictionary alloc] init];
            [self updateDictionary:rangeDefenderPiecesTakingHits WithPieces:piecesTakingHits];
        }
    } else if([stepName isEqualToString:@"meleeStep"]) {
        if(isAttacker) {
            if(meleeAttackerPiecesTakingHits == nil)
                meleeAttackerPiecesTakingHits = [[NSMutableDictionary alloc] init];
            [self updateDictionary:meleeAttackerPiecesTakingHits WithPieces:piecesTakingHits];
        } else{
            if(meleeDefenderPiecesTakingHits == nil)
                meleeDefenderPiecesTakingHits = [[NSMutableDictionary alloc] init];
            [self updateDictionary:meleeDefenderPiecesTakingHits WithPieces:piecesTakingHits];
        }
    } else{
        NSLog(@"ERROR:  Step name [%@] is not a valid step", stepName);
    }
}

-(void) updateDictionary: (NSDictionary*) dic WithPieces:(NSArray*) pieceids {
    for(NSString* pId in pieceids) {
        GamePiece *piece = [[GameResource getInstance] getPieceForId:pId];
        if(piece == nil) {
            NSLog(@"ERROR:  Piece with ID [%@] does not exists", pId);
            continue;
        }
        [dic setValue:piece forKey:pId];
    }
}

@end
