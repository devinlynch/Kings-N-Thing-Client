//
//  RandomEventsMenu.h
//  3004iPhone
//
//  Created by Richard Ison on 2014-03-17.
//
//

#import "SPSprite.h"
#import <UIKit/UIKit.h>
#import "AbstractInGameScreen.h"

@class RandomEvent;
@interface RandomEventsMenu : AbstractInGameScreen
-(void) removeRandomEventPiece: (RandomEvent*) piece;
@end
