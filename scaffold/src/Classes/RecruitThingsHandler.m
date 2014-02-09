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
    
    NSLog(@"Succesfully parsed PlayerRecruitedAndPlacedThing");
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"playerRecruitedAndPlacedThing" object:pRecruitment];
}

@end
