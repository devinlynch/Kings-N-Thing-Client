//
//  AnstractCombatPhaseScreen.m
//  3004iPhone
//
//  Created by Devin Lynch on 2014-04-04.
//
//

#import "AbstractCombatPhaseScreen.h"
#import "CombatPhaseScreenController.h"

@implementation AbstractCombatPhaseScreen


-(id) initFromCombatController: (CombatPhaseScreenController*) controller{
    self = [super initFromParent:controller];
    if(self) {
        _combatController = controller;
    }
    return self;
}



@end
