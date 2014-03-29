//
//  RecruitCharacterOption.h
//  3004iPhone
//
//  Created by Richard Ison on 2014-03-16.
//
//

#import "SPSprite.h"
#import "InGameServerAccess.h"

@class FourPlayerGame;
@interface HeroMenu : SPSprite<UITextFieldDelegate, InGameServerProtocol>
-(id) initWithPossibleRecruits: (NSArray*) recruits;
-(void) setFourPlayerGame :(FourPlayerGame*) game;
@end
