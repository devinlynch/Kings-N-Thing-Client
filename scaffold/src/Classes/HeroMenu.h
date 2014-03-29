//
//  RecruitCharacterOption.h
//  3004iPhone
//
//  Created by Richard Ison on 2014-03-16.
//
//

#import "SPSprite.h"

@interface HeroMenu : SPSprite<UITextFieldDelegate>
-(id) initWithPossibleRecruits: (NSArray*) recruits;
@end
