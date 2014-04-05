//
//  Log.h
//  3004iPhone
//
//  Created by Richard Ison on 2/10/2014.
//
//

#import "SPSprite.h"
#import <UIKit/UIDevice.h>
#import "AbstractInGameScreen.h"

@interface Log : AbstractInGameScreen

+(Log*) getInstanceFromParent: (SPSprite *)parent;
-(void) updateLogs;

@end
