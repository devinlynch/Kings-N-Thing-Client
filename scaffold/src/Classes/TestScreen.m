//
//  TestScreen.m
//  3004iPhone
//
//  Created by Devin Lynch on 2014-03-26.
//
//

#import "TestScreen.h"
#import "RecruitCharacter.h"
#import "RecruitThings.h"
#import "FourPlayerGame.h"
#import "WaitScreen.h"


#import "PiecesMenu.h"
#import "EnemyPiecesMenu.h"
#import "BattleSummaryMenu.h"
#import "BattleStartedMenu.h"

#import "CombatBattleStepMenu.h"
#import "CombatBattleStepResolutionMenu.h"

#import "ConstructionMenu.h"
#import "HeroMenu.h"

@implementation TestScreen

-(SPViewController*) testRecruitCharacters: (UIWindow*) _window{
    SPViewController *_viewController;
    
    CGRect screenBounds = [UIScreen mainScreen].bounds;
    _window = [[UIWindow alloc] initWithFrame:screenBounds];
    
    _viewController = [[HeroMenu alloc] init];
    
    _viewController.multitouchEnabled = YES;
    
    // Enable some common settings here:
    //
    _viewController.showStats = YES;
    _viewController.multitouchEnabled = YES;
    // _viewController.preferredFramesPerSecond = 60;
    
    [_viewController startWithRoot:[ConstructionMenu class] supportHighResolutions:YES doubleOnPad:YES];
 
    return _viewController;
}



@end
