//
//  RecruitingHeroMenu.h
//  3004iPhone
//
//  Created by Devin Lynch on 2014-03-27.
//
//

#import <Foundation/Foundation.h>
#import "InGameServerAccess.h"

@class SpecialCharacter, FourPlayerGame;

@interface RecruitingHeroMenu : SPSprite<InGameServerProtocol>

-(id) initWithRecruitingCharacter: (SpecialCharacter*) character;
-(void) setFourPlayerGame :(FourPlayerGame*) game;

@end
