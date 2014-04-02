//
//  CombatBattleRound.m
//  3004iPhone
//
//  Created by Devin Lynch on 2014-03-31.
//
//

#import "CombatBattleRound.h"

@implementation CombatBattleRound
@synthesize battle,roundId,state,roundNumber, magicData,magicPiecesTakingHits,meleeData,meleePiecesTakingHits,rangeData,rangePiecesTakingHits;

-(id) init{
    self = [super init];
    if(self) {
        self.state = NOT_STARTED;
    }
    return self;
}

@end
