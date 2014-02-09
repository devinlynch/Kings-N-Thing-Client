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

@implementation RecruitThingsHandler

-(void) handleDidStartRecruitThingsPhase:(Event *)event{
    GameMessage *message = (GameMessage*) event.msg;
    NSLog(@"Got didStartRecruitThingsPhase message and handling it");
    
    if (message == nil || message.jsonDictionnary == nil){
        NSLog(@"So who broke something?  Like seriously da fuq?  Im in the handleDidStartRecruitThingsPhase method and either the message is null or the jsonDictionnary is, why would this even happen?  I blame gabe.  Ya it was probably gabe.  So if you are seeing this, feel free to yell at Gabe.  Better yet, yell at john and gabe, i bet they broke it together.  I think richard might have done some of the breaking too.");
        return;
    }
    
    
    NSDictionary* dataDic = [message.jsonDictionnary objectForKey:@"data"];
    
    
    if(dataDic == nil){
        NSLog(@"So now the data is nil in handleDidStartRecruitThingsPhase.  Ok come on Gabe, stop breaking everything.");
        return;
    }
    
    NSArray *possibleRecruitments = [dataDic objectForKey:@"possibleRecruitments"];
    
    NSLog(@"Succesfully parsed DidStartRecruitThingsPhase message with possible recruits: %@", possibleRecruitments);
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"startedRecruitThingsPhase" object:possibleRecruitments];
    
}

@end
