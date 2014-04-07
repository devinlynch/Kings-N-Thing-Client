//
//  RecruitThings.h
//  3004iPhone
//
//  Created by Richard Ison on 2/3/2014.
//
//

#import "SPSprite.h"
#import <UIKit/UIDevice.h>

@interface RecruitThings : SPSprite

+(RecruitThings*) getInstance;
-(void)initWithObjectsToRecruit: (NSArray*)objectsToRecruit;
-(void) setPossibleTradeRecruits: (NSArray*) arr;

@end
