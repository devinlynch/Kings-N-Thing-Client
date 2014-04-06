//
//  RecruitTradeMenu.h
//  3004iPhone
//
//  Created by Devin Lynch on 2014-04-06.
//
//

#import "PiecesMenu.h"

@interface RecruitTradeMenu : PiecesMenu

-(id) initWithPossibleTrades: (NSArray*) trades andPlayer: (Player*) player andParent: (SPSprite*) paren;

@end
