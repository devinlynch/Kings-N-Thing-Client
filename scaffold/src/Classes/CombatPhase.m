//
//  CombatPhase.m
//  3004iPhone
//
//  Created by Devin Lynch on 2014-04-01.
//
//

#import "CombatPhase.h"
#import "CombatBattle.h"
#import "GameState.h"
#import "Player.h"
#import "PlayingCup.h"
#import "SideLocation.h"

@implementation CombatPhase
@synthesize battles, gameState,currentBattle;

-(id) initWithGameState: (GameState*) _gameState{
    self = [super init];
    if(self) {
        battles = [[NSMutableDictionary alloc] init];
        gameState = _gameState;
    }
    return self;
}

-(CombatBattle*) updateOrCreateBattleFromJson: (NSDictionary*) json{
    NSString *battleId = [json objectForKey:@"battleId"];
    if(!battleId) {
        NSLog(@"No battleId given when calling updateOrCreateBattleFromJson!");
        return nil;
    }
    
    BOOL isAIDefender = [[json objectForKey:@"isAIDefender"] boolValue];
    
    NSDictionary *attackerDic = [json objectForKey:@"attacker"];
    NSDictionary *defenderDic = [json objectForKey:@"defender"];
    
    NSString *attackerId = [attackerDic objectForKey:@"playerId"];
    NSString *defenderId = [defenderDic objectForKey:@"playerId"];
    
    Player *attacker = [gameState getPlayerById:attackerId];
    Player *defender = [gameState getPlayerById:defenderId];
    
    NSString *locationOfBattleId = [json objectForKey:@"locationOfBattleId"];
    HexLocation *locationOfBattle = [[gameState hexLocations] objectForKey:locationOfBattleId];
    
    if(attacker == nil || (defender == nil && !isAIDefender) || locationOfBattleId == nil) {
        NSLog(@"THE ATTACKER OR DEFENDER OR LOCATION IN A BATTLE WITH ID [%@] COULD NOT BE FOUND", battleId);
        return nil;
    }
    
    Player *me = [gameState getMe];
    BOOL amIAttacker=NO;
    if([me isEqual:attacker]) {
        amIAttacker = YES;
    } else if(!isAIDefender && [me isEqual:defender]) {
        amIAttacker = NO;
    } else{
        NSLog(@"WHOAH, why am I parsing a battle for one im not part of?");
        return nil;
    }
    
    [self updateGameStateFromBattleJson:json];
    
    CombatBattle *battle = [battles objectForKey:battleId];
    if(battle == nil) {
        battle = [[CombatBattle alloc] init];
        [battles setObject:battle forKey:battleId];
        
        [battle setAmIAttacker:amIAttacker];
        [battle setAttacker:attacker];
        [battle setDefender:defender];
        [battle setGameState:gameState];
        [battle setLocationOfBattle:locationOfBattle];
        [battle setBattleId:battleId];
        [battle setIsAIDefender:isAIDefender];
    }
    
    BOOL isStarted = [[json objectForKey:@"isStarted"] boolValue];
    BOOL isOver = [[json objectForKey:@"isOver"] boolValue];
    
    if(isStarted != battle.isStarted) {
        battle.isStarted = isStarted;
    }
    
    if(isOver != battle.isEnded) {
        battle.isEnded = isOver;
    }
    
    NSString *resolution = [json objectForKey:@"resolution"];
    
    if([resolution isEqualToString:@"ATTACKER_RETREATED"]) {
        if(battle.state != ATTACKER_RETREATED) {
            battle.state = ATTACKER_RETREATED;
        }
    } else if([resolution isEqualToString:@"DEFENDER_REREATED"]) {
        if(battle.state != DEFENDER_REREATED) {
            battle.state = DEFENDER_REREATED;
        }
    } else if([resolution isEqualToString:@"ATTACKER_WON"]) {
        if(battle.state != ATTACKER_WON) {
            battle.state = ATTACKER_WON;
        }
    } else if([resolution isEqualToString:@"DEFENDER_WON"]) {
        if(battle.state != DEFENDER_WON) {
            battle.state = DEFENDER_WON;
        }
    } else{
        if(battle.state != IN_PROGRESS) {
            battle.state = IN_PROGRESS;
        }
    }
    
    return battle;
}

-(void) updateGameStateFromBattleJson:(NSDictionary*) json{
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
            [[gameState getPlayerById:defenderId] updateFromSerializedJson:attackerDic];
        }
    }
    
}

@end
