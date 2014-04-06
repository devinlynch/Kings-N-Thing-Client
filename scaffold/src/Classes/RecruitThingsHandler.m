//
//  RecruitThingsHandler.m
//  3004iPhone
//
//  Created by Devin Lynch on 2014-02-09.
//
//

#import "RecruitThingsHandler.h"
#import "Event.h"
#import "GameState.h"
#import "GameMessage.h"
#import "Utils.h"
#import "PlayerRecruitment.h"
#import "Thing.h"
#import "BoardLocation.h"
#import "Game.h"
#import "GameResource.h"

@implementation RecruitThingsHandler

-(void) handleDidStartRecruitThingsPhase:(Event *)event{
    NSDictionary* dataDic = [Utils getDataDictionaryFromGameMessageEvent:event];
    if(dataDic == nil){
        return;
    }
    
    NSArray *possibleRecruitments = [dataDic objectForKey:@"possibleRecruitments"];


    [Game addLogMessageToCurrentGame:@"The Recruit Things phase has started!"];
    
    NSLog(@"Succesfully parsed DidStartRecruitThingsPhase message with possible recruits: %@", possibleRecruitments);
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"startedRecruitThingsPhase" object:possibleRecruitments];
    });
}

-(void) handlePlayerRecruitedAndPlacedThing: (Event*) event {
    NSDictionary* dataDic = [Utils getDataDictionaryFromGameMessageEvent:event];
    if(dataDic == nil){
        return;
    }
    
    PlayerRecruitment *pRecruitment = [PlayerRecruitment fromDictionary:dataDic];
    Thing *thing = pRecruitment.thing;
    BoardLocation *location = pRecruitment.location;
    Player *player = pRecruitment.player;
    
    if(thing == nil || location == nil || player==nil) {
        NSLog(@"Either a thing, location or player was nil when initializing a player recruitment inside of handlePlayerRecruitedAndPlacedThing");
        return;
    }
    
    [Game addLogMessageToCurrentGame:[NSString stringWithFormat:@"%@ recruited a %@ and placed it on %@", player.username, thing.name,location.locationName]];
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [location addGamePieceToLocation:thing];
        [player assignPiece:thing];
        
        NSLog(@"Succesfully parsed PlayerRecruitedAndPlacedThing");
        
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"playerRecruitedAndPlacedThing" object:pRecruitment];
    });
}

-(void) handlePlayerTradedThing: (Event*) event {
    NSDictionary* dataDic = [Utils getDataDictionaryFromGameMessageEvent:event];
    if(dataDic == nil){
        return;
    }
    
    NSDictionary *playerDic = [dataDic objectForKey:@"player"];
    NSDictionary *oldThingDic = [dataDic objectForKey:@"oldThing"];
    NSDictionary *newThingDic = [dataDic objectForKey:@"newThing"];
    
    GameState *gameState = [[Game currentGame] gameState];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        Player *player = [gameState getPlayerById:[playerDic objectForKey:@"playerId"]];
        [player updateFromSerializedJson:playerDic];
        
        GamePiece *oldThing = [[GameResource getInstance] getPieceForId:[oldThingDic objectForKey:@"id"]];
        [oldThing updateFromSerializedJson:oldThingDic forGameState:gameState];
        
        GamePiece *newThing = [[GameResource getInstance] getPieceForId:[newThingDic objectForKey:@"id"]];
        [newThing updateFromSerializedJson:newThingDic forGameState:gameState];
        
        [Game addLogMessageToCurrentGame:[NSString stringWithFormat:@"%@ traded their %@ a for a %@", player.username, oldThing.name,newThing.name]];
        
        NSLog(@"Succesfully parsed handlePlayerTradedThing");
    });
}


-(void) handleRecruitThingsPhaseOver:(Event *)event{
    NSDictionary* dataDic = [Utils getDataDictionaryFromGameMessageEvent:event];
    if(dataDic == nil){
        return;
    }
    
    
    
    NSLog(@"Succesfully parsed recruitThingsPhaseOver message");
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"recruitThingsPhaseOver" object:nil];
    });
}

@end
