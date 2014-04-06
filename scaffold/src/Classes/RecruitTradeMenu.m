//
//  RecruitTradeMenu.m
//  3004iPhone
//
//  Created by Devin Lynch on 2014-04-06.
//
//

#import "RecruitTradeMenu.h"
#import "Player.h"

@implementation RecruitTradeMenu
{
    NSMutableArray *_possibleRecruits;
}

-(id) initWithPossibleTrades: (NSArray*) trades andPlayer: (Player*) player andParent: (SPSprite*) parent{
    self = [super initFromParent:parent];
    if(self) {
        _player = player;
        _location = player.rack1;
        _possibleRecruits = [NSMutableArray arrayWithArray:trades];
        [self setup];
    }
    return self;
}


-(void) setup{
    [super setup];
    
    
}


@end
