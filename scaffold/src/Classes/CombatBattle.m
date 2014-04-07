//
//  CombatBattle.m
//  3004iPhone
//
//  Created by Devin Lynch on 2014-03-31.
//
//

#import "CombatBattle.h"
#import "CombatBattleRound.h"
#import "Utils.h"
#import "GameState.h"
#import "Player.h"
#import "HexLocation.h"
#import "SideLocation.h"
#import "PlayingCup.h"
#import "LogMessage.h"
#import "CombatPhase.h"
#import "GameResource.h"
#import "GamePiece.h"
#import "User.h"

@implementation CombatBattle
@synthesize attacker, battleId, defender, gameState, locationOfBattle, amIAttacker, currentRound, isEnded, isStarted, state, isAIDefender, battleLog, combatPhase;

-(id) initWithCombatPhase:(CombatPhase *)cp{
    self = [super init];
    if(self) {
        combatPhase = cp;
        battleLog = [[NSMutableArray alloc] init];
    }
    return self;
}

-(CombatBattleRound*) createNewRoundFromSerializedJson: (NSDictionary*) json{
    if(json != nil && [json isKindOfClass:[NSDictionary class]]) {
        int lastRoundNum = 0;
        if(currentRound != nil) {
            lastRoundNum = currentRound.roundNumber;
        }
        lastRoundNum++;
        
        CombatBattleRound *round = [[CombatBattleRound alloc] init];
        [round setRoundNumber:lastRoundNum];
        [round setBattle:self];
        [round setRoundId:[json objectForKey:@"roundId"]];
        
        currentRound = round;
        
        if([self amIInTheBattle])
            [Utils notifyOnMainQueue:@"newBattleRoundStarted" withObject:currentRound];
        
        [self addMessageToBattleLog:[NSString stringWithFormat: @"Round #%d has started!", currentRound.roundNumber]];
        
        return round;
    }
    
    return nil;
}

-(BOOL) amIInTheBattle{
    Player *me = [gameState getMe];
    return (me == attacker) || (me==defender);
}

-(void) didEndWithJson: (NSDictionary*) json{
    [CombatBattle updateGameState:gameState FromBattleJson:[json objectForKey:@"battle"]];
    
    NSString* resolution = [json objectForKey:@"resolution"];
    if(resolution != nil)
        state = [CombatBattle battleStateFromString:resolution];
    
    NSDictionary *statusOfLeftOverPieces = [json objectForKey:@"statusOfLeftoverPieces"];
    
    NSEnumerator *enumerator = [statusOfLeftOverPieces keyEnumerator];
    id key;
    while ((key = [enumerator nextObject])) {
        NSString* res = [statusOfLeftOverPieces objectForKey:key];
        GamePiece *gp  = [[GameResource getInstance] getPieceForId:key];
        if(gp != nil) {
            NSString *resultS;
            if([res isEqualToString:@"DESTROYED"]) {
                resultS = @"destroyed";
            } else if([res isEqualToString:@"REDUCED_LEVEL"]) {
                resultS = @"reduced a level";
            } else if([res isEqualToString:@"RESTORED"]) {
                resultS = @"restored";
            } else{
                continue;
            }
            
            [self addMessageToBattleLog:[NSString stringWithFormat: @"Damage took place for %@ during battle.  It is now %@", gp.name, resultS]];
        }
    }
    
    isEnded = YES;
    
    Player *winner;
    if(state == ATTACKER_RETREATED || state == DEFENDER_WON) {
        winner = defender;
    } else {
        winner = attacker;
    }
    
    [self addMessageToBattleLog:[NSString stringWithFormat: @"The battle between %@ and %@ on %@ has ended. The winner is %@.", attacker.user.username, defender.user.username, locationOfBattle.locationName, winner.user.username]];
    
    if([self amIInTheBattle])
        [Utils notifyOnMainQueue:@"battleEnded" withObject:self];
}

+(CombatBattleState) battleStateFromString: (NSString*) s{
    if([s isEqualToString:@"ATTACKER_RETREATED"]) {
        return ATTACKER_RETREATED;
    } else if([s isEqualToString:@"DEFENDER_REREATED"]) {
        return DEFENDER_REREATED;
    } else if([s isEqualToString:@"ATTACKER_WON"]) {
        return ATTACKER_WON;
    } else if([s isEqualToString:@"DEFENDER_WON"]) {
        return DEFENDER_WON;
    } else{
        return IN_PROGRESS;
    }
}


+(void) subscribeToBattleNotifications: (id) subscriber andSelector: (SEL)selector{
     [[NSNotificationCenter defaultCenter] addObserver:subscriber selector:selector name:@"battleEnded" object:nil];
}

+(void) unsubscribeToBattleNotifications: (id) subscriber{
    [[NSNotificationCenter defaultCenter] removeObserver:subscriber name:@"battleEnded" object:nil];
}

+(void) updateGameState: (GameState*) gameState FromBattleJson:(NSDictionary*) json{
    NSDictionary *attackerDic = [json objectForKey:@"attacker"];
    NSDictionary *defenderDic = [json objectForKey:@"defender"];
    NSArray *hexLocations = [json objectForKey:@"hexLocations"];
    NSDictionary *sideLocation = [json objectForKey:@"sideLocation"];
    NSDictionary *playingCup = [json objectForKey:@"playingCup"];
    
    if(hexLocations != nil && ([hexLocations isKindOfClass:[NSArray class]])){
        [gameState updateHexLocationsFromSerializedJSONArray:hexLocations];
    }
    
    if(sideLocation != nil && ([sideLocation isKindOfClass:[NSDictionary class]])){
        [gameState.sideLocation updateLocationFromSerializedJSONDictionary:sideLocation];
    }
    
    if(playingCup != nil && ([playingCup isKindOfClass:[NSDictionary class]])){
        [gameState.playingCup updateLocationFromSerializedJSONDictionary:playingCup];
    }
    
    if(attackerDic != nil) {
        NSString *attackerId = [attackerDic objectForKey:@"playerId"];
        if(attackerId != nil) {
            [[gameState getPlayerById:attackerId] updateFromSerializedJson:attackerDic];
        }
    }
    
    if(defenderDic != nil) {
        NSString *defenderId = [defenderDic objectForKey:@"playerId"];
        if(defenderId != nil) {
            [[gameState getPlayerById:defenderId] updateFromSerializedJson:defenderDic];
        }
    }
    
}

-(void) addMessageToBattleLog: (NSString *) string{
    [combatPhase addLogMessage: string];
    
    LogMessage *msg = [[LogMessage alloc] initWithMessage:string];
    [battleLog addObject:msg];
}

-(void) handlePlayerRetreated: (NSDictionary*) json{
    Player *p = [gameState getPlayerById:[json objectForKey:@"retreatedPlayerId"]];
    HexLocation *retreatedHex = (HexLocation*) [gameState getBoardLocationById:[[json objectForKey:@"retreatedToHex"] objectForKey: @"locationId"]];

    if(p==nil || retreatedHex==nil || p != attacker || p != defender){
        return;
    }
    
    [self addMessageToBattleLog:[NSString stringWithFormat:@"%@ retreated their pieces to %@", p.user.username, retreatedHex.locationName]];
}

@end
