//
//  RecruitCharacter.h
//  3004iPhone
//
//  Created by Richard Ison on 2014-03-16.
//
//

#import "SPSprite.h"
@class FourPlayerGame;
@interface RecruitCharacter : SPSprite

+(RecruitCharacter*) getInstance;
//-(void)initWithObjectsToRecruit: (NSArray*)objectsToRecruit;
-(void) setFourPlayerGame :(FourPlayerGame*) game;

@end
