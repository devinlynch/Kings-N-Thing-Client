//
//  CombatPhaseScreenController.m
//  3004iPhone
//
//  Created by Devin Lynch on 2014-04-02.
//
//

#import "CombatPhaseScreenController.h"
#import "CombatPhase.h"
#import "FourPlayerGame.h"
#import "WaitScreen.h"
#import "BattleStartedMenu.h"
#import "CombatBattleStepMenu.h"
#import "CombatBattleRound.h"

@implementation CombatPhaseScreenController
{
    WaitScreen *_waitScreen;
}

-(id) init{
    self = [super init];
    if(self) {
        [self setup];
    }
    return self;
}

-(id) initWithFourPlayerGame:(FourPlayerGame*) fourPlayerGame{
    self = [self init];
    if(self) {
        _fourPlayerGame = fourPlayerGame;
        [self setup];
    }
    return self;
}

-(void) setup{
    [self subscribeToNotifications];
}

-(void) subscribeToNotifications{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(combatPhaseStarted:)
                                                 name:@"handleCombatPhaseStarted"
                                               object:nil];
}

-(void) combatPhaseStarted: (NSNotification*) notif{
    _combatPhase =(CombatPhase*) notif.object;
        
    [self handleStartCombat];
}

-(void) handleStartCombat{
    NSLog(@"Handling start of combat");
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(combatBattleStarted:)
                                                 name:@"combatBattleStarted"
                                               object:nil];
    
    [_fourPlayerGame addChildToContents: self];
    [self setVisible: YES];
    [self showWaitingScreen];
}


-(void) showWaitingScreen{
    if(_waitScreen == nil)
        _waitScreen = [[WaitScreen alloc] initFromCombatController:self];
    [_waitScreen show];
}

-(void) hideWaitingScreen{
    if(! (_waitScreen == nil))
        [_waitScreen hide];
}


-(void) combatBattleStarted: (NSNotification*) notif{
    [self handleCombatBattleStarted:(CombatBattle*)notif.object];
}

-(void) handleCombatBattleStarted: (CombatBattle*) battle {
    [self hideWaitingScreen];
    
    BattleStartedMenu *bsMenu = [[BattleStartedMenu alloc] initWithBattle:battle andController:self];
    [bsMenu show];
}

-(void) readyForBattleToStart: (CombatBattle*) battle{
    NSLog(@"Player ready for battle to start");
    
    if(battle.state == IN_PROGRESS) {
        [self removeScreens];
        CombatBattleStepMenu *battleStepMenu  = [[CombatBattleStepMenu alloc] initWithRound:battle.currentRound andController:self];
        [battleStepMenu show];
    } else {
        // TODO
    }
}


-(void) removeScreens{
    [self removeAllChildren];
}


-(void) dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



@end
