//
//  ChatScene.h
//  3004iPhone
//
//  Created by Richard Ison on 2014-03-20.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AbstractInGameScreen.h"

@interface ChatScene : AbstractInGameScreen <UITextFieldDelegate>

+(ChatScene*) getInstanceFromParent: (SPSprite*) parent;
-(void) updateChat;

@end
