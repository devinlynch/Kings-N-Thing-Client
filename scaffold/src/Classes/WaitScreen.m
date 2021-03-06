//
//  WaitScreen.m
//  3004iPhone
//
//  Created by Richard Ison on 2014-03-27.
//
//

#import "WaitScreen.h"
#import "CombatPhaseScreenController.h"
#import "FourPlayerGame.h"
#import "LogMessage.h"
#import "CombatPhase.h"
#import "Game.h"
#import "GameState.h"

@implementation WaitScreen{
    SPTextField *_logText;
    
    UIScrollView *_scrollView;
    UIView *view;
    
    SPTextField *goldtext;
    SPButton *goldButton;
    NSMutableArray *logMessages;
    UITextView *_textView;
}

-(id) init
{
    if ((self = [super initFromCombatController:nil]))
    {
        [self setup];
    }
    
    return self;
}

-(id) initFromCombatController:(CombatPhaseScreenController *)controller {
    if ((self = [super initFromCombatController:controller]))
    {
        [self setup];
    }
    
    return self;
}


-(void) setup{
    [super setup];
    
    logMessages = [[NSMutableArray alloc] init];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(newPhaseStarted:)
                                                 name:@"newPhaseStarted"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(newLog:)
                                                 name:@"newCombatPhaseLog"
                                               object:nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moveRight:)
                                                 name:@"menuMovedRight"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moveLeft:)
                                                 name:@"menuMovedLeft"
                                               object:nil];
    
    
    //To add UIKit stuffs to sparrow
    view = Sparrow.currentController.view;
    
    SPImage *background = [[SPImage alloc] initWithContentsOfFile:@"WaitScreenBackground@2x.png"];
    
    //necessary or else it gets placed off screen
    background.x = 0;
    background.y = 0;
    
    [_contents addChild:background];
    
    //Add game log shiet
    
    SPTextField *gameLogText = [SPTextField textFieldWithWidth:190 height: 30 text:@"Battle Log"];
    gameLogText.x = _gameWidth / 2 - gameLogText.width / 2;
    gameLogText.y = _gameWidth / 2.20;
    gameLogText.fontSize = 23;
    gameLogText.color = SP_WHITE;
    [_contents addChild:gameLogText];
    
    SPImage *darkZone = [[SPImage alloc] initWithContentsOfFile:@"DarkZone2.png"];
    darkZone.x = _gameWidth / 2 - darkZone.width / 2;
    darkZone.y = _gameWidth / 2.2;
    darkZone.scaleY = 1.8;
    [_contents addChild:darkZone];
    
    
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 10, 200, 200)];
    _textView.backgroundColor= [UIColor clearColor];
    _textView.editable = NO;
    _textView.textColor = [UIColor whiteColor];
    
    [self updateLogFromCombatPhase];
    
    //Add scroll to scene
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(_gameWidth / 2 - darkZone.width / 2 + 15, _gameWidth / 2.2 + 25, 200, 200)];
    _scrollView.pagingEnabled = NO;
    _scrollView.showsVerticalScrollIndicator = YES;
    _scrollView.hidden = NO;
    
    
    [view addSubview:_scrollView];
    
    //Add textfield in scrollView
    [_scrollView addSubview:_textView];
    [_scrollView setContentSize:CGSizeMake(180, 480)];
    
    
    
    
    goldtext = [SPTextField textFieldWithWidth:300 height: 30 text:@"The Next Phase Has Started"];
    goldtext.x = 10;
    goldtext.y = _gameWidth + 100;
    goldtext.fontSize = 23;
    goldtext.color = SP_WHITE;
    goldtext.visible = NO;
    [_contents addChild:goldtext];
    
    SPTexture *skipButtonTexture = [SPTexture textureWithContentsOfFile:@"done.png"];
    goldButton = [SPButton buttonWithUpState:skipButtonTexture];
    goldButton.x = _gameWidth /2 - goldButton.width/2 + 20;
    goldButton.y = 480;
    goldButton.scaleX = goldButton.scaleY = 0.8;
    goldButton.visible = NO;
    [_contents addChild:goldButton];
    [goldButton addEventListener:@selector(didClickOnSkip:) atObject:self forType:SP_EVENT_TYPE_TRIGGERED];
    
    [self showGoToNextPhaseIfNeeded];
}

-(void) didClickOnSkip: (SPEvent*) event{
    [self hide];
    [_combatController handleGoToNextPhase];
}


-(void) hide{
    [super hide];
    _scrollView.hidden = YES;
}

-(void) show{
    [super show];
    _scrollView.hidden = NO;
    
    [self showGoToNextPhaseIfNeeded];
}

-(void) newPhaseStarted: (NSNotification*) notif{
    [self showGoToNextPhaseIfNeeded];
}

-(void) showGoToNextPhaseIfNeeded{
    if(_combatController.fourPlayerGame.getPhase != COMBAT) {
        goldtext.visible = YES;
        goldButton.visible = YES;
    }
}

-(void) dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


-(void) updateLogFromCombatPhase{
    CombatPhase* phase = [[[Game currentGame] gameState] currentCombatPhase];
    [logMessages removeAllObjects];
    for(LogMessage *msg in phase.combatPhaseLog) {
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"hh:mm:ss"];
        NSString *formattedDate = [format stringFromDate:msg.date];
        [logMessages addObject:[NSString stringWithFormat:@"[%@]: %@", formattedDate, msg.message]];
    }
    _textView.text = [logMessages componentsJoinedByString:@"\n"];
}

-(void) newLog: (NSNotification*) notif{
    [self updateLogFromCombatPhase];
}

-(void) moveRight: (NSNotification*) notif {
     _textView.hidden = YES;
}


-(void) moveLeft: (NSNotification*) notif {
    _textView.hidden = NO;

}

@end
