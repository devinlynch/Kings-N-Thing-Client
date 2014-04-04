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
    
    [[NSNotificationCenter defaultCenter] removeObserver:self forKeyPath:@"handleCombatPhaseStarted"];
    
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
    WaitScreen *ws = [[WaitScreen alloc] init];
    [self addChild:ws];
    ws.visible = YES;
}


-(void) combatBattleStarted: (NSNotification*) notif{
    [self handleCombatBattleStarted:(CombatBattle*)notif.object];
}

-(void) handleCombatBattleStarted: (CombatBattle*) battle {
    BattleStartedMenu *bsMenu = [[BattleStartedMenu alloc] initWithBattle:battle andController:self];
    [bsMenu show];
}

-(void) readyForBattleToStart{
    NSLog(@"Player ready for battle to start");
}


-(void) dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



@end
