//
//  ConstructionPhaseHandler.m
//  3004iPhone
//
//  Created by Devin Lynch on 2014-04-05.
//
//

#import "ConstructionPhaseHandler.h"
#import "Event.h"
#import "Game.h"
#import "Utils.h"
#import "User.h"

@implementation ConstructionPhaseHandler

-(void) hanleConstructionStarted: (Event*) e {
    [Utils notifyOnMainQueue:@"constructionStarted" withObject:nil];
}

-(void) handleYourTurn: (Event*) e {
    [Utils notifyOnMainQueue:@"yourTurnInContruction" withObject:nil];
}

//playerMadeMoveInConstruction
-(void) handlePlayerMadeMoveInConstruction: (Event*) e {
    NSDictionary* dataDic = [Utils getDataDictionaryFromGameMessageEvent:e];
    
    NSString *type  = [dataDic objectForKey:@"type"];
    NSDictionary *locDic = [dataDic objectForKey:@"location"];
    NSDictionary *playerDic = [dataDic objectForKey:@"player"];
    NSDictionary *playCupDic = [dataDic objectForKey:@"playingCup"];

    GameState *gs = [[Game currentGame] gameState];
    
    BoardLocation *loc = [gs getBoardLocationById:[locDic objectForKey:@"locationId"]];
    [loc updateLocationFromSerializedJSONDictionary:locDic];
    
    BoardLocation *playingCup = [gs getBoardLocationById:[playCupDic objectForKey:@"locationId"]];
    [playingCup updateLocationFromSerializedJSONDictionary:playCupDic];
    
    Player *player = [gs getPlayerById:[playerDic objectForKey:@"playerId"]];
    [player updateFromSerializedJson:playerDic];
    
    NSString *logMessage;
    if([type isEqualToString:@"built"]) {
        logMessage = [NSString stringWithFormat:@"%@ built a fort on %@",player.user.username, loc.locationName];
    } else {
        logMessage = [NSString stringWithFormat:@"%@ upgraded their for on %@",player.user.username, loc.locationName];
    }
    
    [Game addLogMessageToCurrentGame:logMessage];
}

//playerWon
-(void) handlePlayerWon: (Event*) e {
    NSDictionary* dataDic = [Utils getDataDictionaryFromGameMessageEvent:e];
    NSString *playerId  = [dataDic objectForKey:@"winnerId"];
    
    GameState *gs = [[Game currentGame] gameState];
    Player *winner = [gs getPlayerById:playerId];
    
    
    [Utils notifyOnMainQueue:@"playerWon" withObject:winner];
}

@end
