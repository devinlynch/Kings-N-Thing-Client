//
//  PlayerRecruitment.m
//  3004iPhone
//
//  Created by Devin Lynch on 2014-02-09.
//
//

#import "PlayerRecruitment.h"
#import "Game.h"
#import "GameState.h"
#import "GameResource.h"

@implementation PlayerRecruitment
@synthesize location,player,recruitmentType,thing;

+(PlayerRecruitment*) fromDictionary: (NSDictionary*) dic{
    PlayerRecruitment* pr = [[PlayerRecruitment alloc] init];
    
    pr.thing = (Thing*)[[GameResource getInstance] getPieceForId:[dic objectForKey:@"thingId"]];
    
    GameState *currentGameState = [[Game currentGame] gameState];
    pr.location = [currentGameState getBoardLocationById:[dic objectForKey:@"locationId"]];
    pr.player = [currentGameState getPlayerById:[dic objectForKey:@"playerId"]];
    
    NSString *rt = [dic objectForKey:@"recruitmentType"];
    if(rt != nil) {
        if([rt isEqualToString:@"buy"]) {
            [pr setRecruitmentType:RT_BUY];
        } else if([rt isEqualToString:@"free"]) {
            [pr setRecruitmentType:RT_FREE];
        } else if([rt isEqualToString:@"trade"]) {
            [pr setRecruitmentType:RT_TRADE];
        }
    }
    
    return pr;
}

@end
