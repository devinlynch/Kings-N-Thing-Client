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
        [self subscribeToNotifications];
    }
    return self;
}

-(void) setup{
    
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
    [_fourPlayerGame addChildToContents: self];
    [self setVisible: YES];
    [self showWaitingScreen];
}


-(void) showWaitingScreen{
    WaitScreen *ws = [[WaitScreen alloc] init];
    [self addChild:ws];
    ws.visible = YES;
}


-(void) dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



@end
