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
#import "BattleSummaryMenu.h"

@implementation CombatPhaseScreenController


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

-(void) reinitializeForFourPlayerGame: (FourPlayerGame*) fourPlayerGame{
    [self removeFromParent];
    [self removeAllChildren];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    _fourPlayerGame = fourPlayerGame;
    _combatPhase = nil;
    _waitScreen = nil;
    [self setup];
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
    [_fourPlayerGame setPhase:COMBAT];
    [self handleStartCombat];
}

-(void) handleStartCombat{
    NSLog(@"Handling start of combat");
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(combatBattleStarted:)
                                                 name:@"combatBattleStarted"
                                               object:nil];
    [CombatBattle subscribeToBattleNotifications:self andSelector:@selector(didGetUpdatedBattle:)];

    [_fourPlayerGame addChildToPhasesContent: self];
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
        [self handleNextScreenForRound:battle.currentRound];
        [CombatBattleRound subscribeToStepNotifications:self andSelector:@selector(newRoundState:)];
    } else {
        [self handleDidGetUpdatedBattle:battle];
    }
}

-(void) doneWithRoundStep: (CombatBattleRound*) round{
    NSLog(@"In doneWithRoundStep");
    [self handleNextScreenForRound:round];
}

-(void) newRoundState: (NSNotification*) notif{
    [self handleNextScreenForRound:(CombatBattleRound*) notif.object];
}

-(void) handleNextScreenForRound: (CombatBattleRound*) round {
    CombatRoundState state = round.state;
    NSLog(@"In handleNextScreenForRound");
    
    if(state == NOT_STARTED) {
        NSLog(@"Round not started");
        // TODO
    } else if(state == MAGIC_STEP || state == RANGE_STEP || state == MELEE_STEP) {
        [self removeScreens];
        CombatBattleStepMenu *battleStepMenu  = [[CombatBattleStepMenu alloc] initWithRound:round andController:self];
        [battleStepMenu show];
    } else if (state ==  WAITING_ON_RETREAT_OR_CONTINUE) {
        NSLog(@"Waiting on retreat or continue");
        [self removeScreens];
        BattleSummaryMenu *battleSummaryMenu  = [[BattleSummaryMenu alloc] initWithBattle: round.battle andController:self];
        [battleSummaryMenu show];
    } else{
        NSLog(@"Round nover inside handleNextScreenForRound, not doing anything");
    }
}

-(void) didGetUpdatedBattle: (NSNotification*) notif{
    [self handleDidGetUpdatedBattle: (CombatBattle*) notif.object];
}

-(void) handleDidGetUpdatedBattle: (CombatBattle*) battle{
    if(battle != _combatPhase.currentBattle) {
        NSLog(@"Not handling battle because its not the current one");
    }
    
    NSLog(@"In handleDidGetUpdatedBattle");
    if(battle.isEnded) {
        [CombatBattleRound unsubscribeToStepNotifications:self];
        [self removeScreens];
        BattleSummaryMenu *battleSummaryMenu  = [[BattleSummaryMenu alloc] initWithBattle: battle andController:self];
        [battleSummaryMenu show];
    }
}


-(void) removeScreens{
    [self removeAllChildren];
}


-(void) dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(FourPlayerGame*) fourPlayerGame
{
    return _fourPlayerGame;
}

-(void) handleGoToNextPhase{
    [_fourPlayerGame reinitializeCombatScreenAndShowGold];
}

@end
