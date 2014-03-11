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

@implementation RecruitThingsHandler

-(void) handleDidStartRecruitThingsPhase:(Event *)event{
    NSDictionary* dataDic = [Utils getDataDictionaryFromGameMessageEvent:event];
    if(dataDic == nil){
        return;
    }
    
    NSArray *possibleRecruitments = [dataDic objectForKey:@"possibleRecruitments"];

    NSLog(@"Succesfully parsed DidStartRecruitThingsPhase message with possible recruits: %@", possibleRecruitments);
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"startedRecruitThingsPhase" object:possibleRecruitments];
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
    
    
    [location addGamePieceToLocation:thing];
    [player assignPiece:thing];
    
    NSLog(@"Succesfully parsed PlayerRecruitedAndPlacedThing");
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"playerRecruitedAndPlacedThing" object:pRecruitment];
}

-(void) handleRecruitThingsPhaseOver:(Event *)event{
    NSDictionary* dataDic = [Utils getDataDictionaryFromGameMessageEvent:event];
    if(dataDic == nil){
        return;
    }
    
    NSLog(@"Succesfully parsed recruitThingsPhaseOver message");
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"recruitThingsPhaseOver" object:nil];
}

@end
