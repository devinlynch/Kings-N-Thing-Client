//
//  RecruitCharactersEventHandler.h
//  3004iPhone
//
//  Created by Devin Lynch on 2014-03-25.
//
//

#import <Foundation/Foundation.h>

@class Event;

@interface RecruitCharactersEventHandler : NSObject

-(void) handleDidStartRecruitCharactersPhase:(Event *)event;
-(void) handleYourTurnInRecruitCharactersPhase:(Event *)event;
-(void) handleDidRollInRecruitCharactrs:(Event *)event;

@end
