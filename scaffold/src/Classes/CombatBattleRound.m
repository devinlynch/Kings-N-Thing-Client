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
#import "Utils.h"
#import "Player.h"
#import "GamePiece.h"

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
        
        if(battle.amIInTheBattle)
            [Utils notifyOnMainQueue:@"magicStepStarted" withObject:self];
        
        [battle addMessageToBattleLog:[NSString stringWithFormat: @"The magic step has started!"]];
    } else if([stepName isEqualToString:@"rangedStep"]){
        rangeData = [[CombatBattleRoundStepData alloc] initFromJson:json forGameState:battle.gameState];
        state = RANGE_STEP;
        
        if(battle.amIInTheBattle)
            [Utils notifyOnMainQueue:@"rangeStepStarted" withObject:self];
        
        [battle addMessageToBattleLog:[NSString stringWithFormat: @"The range step has started!"]];
    } else if([stepName isEqualToString:@"meleeStep"]) {
        meleeData = [[CombatBattleRoundStepData alloc] initFromJson:json forGameState:battle.gameState];
        state = MELEE_STEP;
        
        if(battle.amIInTheBattle)
            [Utils notifyOnMainQueue:@"meleeStepStarted" withObject:self];
        
        [battle addMessageToBattleLog:[NSString stringWithFormat: @"The melee step has started!"]];
    } else{
        NSLog(@"ERROR:  Step name [%@] is not a valid step", stepName);
    }
}

+(void) subscribeToStepNotifications: (id) subscriber andSelector: (SEL)selector{
    [[NSNotificationCenter defaultCenter] addObserver:subscriber selector:selector name:@"magicStepStarted" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:subscriber selector:selector name:@"rangeStepStarted" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:subscriber selector:selector name:@"meleeStepStarted" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:subscriber selector:selector name:@"timeForRetreatOrContinue" object:nil];
}

+(void) unsubscribeToStepNotifications: (id) subscriber {
    [[NSNotificationCenter defaultCenter] removeObserver:subscriber name:@"magicStepStarted" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:subscriber name:@"rangeStepStarted" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:subscriber name:@"meleeStepStarted" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:subscriber name:@"timeForRetreatOrContinue" object:nil];
}

-(void) player: (NSString*) playerId tookDamageToPieces: (NSArray*) piecesTakingHits forStep: (NSString*) stepName{
    BOOL isAttacker = NO;
    Player *player;
    if(battle.attacker != nil && [playerId isEqualToString:battle.attacker.playerId]) {
        isAttacker = YES;
        player = battle.attacker;
    } else if(battle.defender != nil && [playerId isEqualToString:battle.defender.playerId]){
        isAttacker = NO;
        player = battle.defender;
    } else{
        NSLog(@"ERROR:  Player [%@] is not bart of the battle %@", playerId, battle.battleId);
        return;
    }
    
    
    NSMutableString *logMessage = [[NSMutableString alloc] init];
    [logMessage appendString:[NSString stringWithFormat: @"%@ took damage to: ", player.user.username]];
    int count = 0;
    for(NSString *gpId in piecesTakingHits) {
        GamePiece *gp = [[GameResource getInstance] getPieceForId:gpId];
        if(gp != nil) {
            [logMessage appendString:[NSString stringWithFormat: @"%@,", gp.name]];
            count++;
        }
    }
    
    if(count > 0) {
        [battle addMessageToBattleLog:logMessage];
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

-(NSString*) stateString{
    NSString *s = nil;
    switch (state) {
        case MAGIC_STEP:
            s=@"MAGIC_STEP";
            break;
        case MELEE_STEP:
            s=@"MELEE_STEP";
            break;
        case NOT_STARTED:
            s=@"NOT_STARTED";
            break;
        case RANGE_STEP:
            s=@"RANGE_STEP";
            break;
        case ROUND_ENDED:
            s=@"ROUND_ENDED";
            break;
        case WAITING_ON_RETREAT_OR_CONTINUE:
            s=@"WAITING_ON_RETREAT_OR_CONTINUE";
            break;
        default:
            break;
    }
    return s;
}

-(void) makeItTimeToRetreatOrContinue{
    state = WAITING_ON_RETREAT_OR_CONTINUE;
    
    if(battle.amIInTheBattle)
        [Utils notifyOnMainQueue:@"timeForRetreatOrContinue" withObject:self];
}

@end
