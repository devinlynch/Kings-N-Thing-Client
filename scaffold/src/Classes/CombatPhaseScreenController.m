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
    [self setVisible: YES];
}


-(void) dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



@end
