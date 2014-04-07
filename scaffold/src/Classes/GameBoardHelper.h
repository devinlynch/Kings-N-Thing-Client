//
//  GameBoardHelper.h
//  3004iPhone
//
//  Created by Devin Lynch on 2014-04-07.
//
//

#import <Foundation/Foundation.h>

@class FourPlayerGame, GameState, TouchSheet;
@interface GameBoardHelper : NSObject
+(void) populateHexLocationsFromFourPlayerGame: (FourPlayerGame*) fourPlayerGame is2Player:(BOOL) is2Player fromGameState: (GameState*) gameState withTouchSheet: (TouchSheet*) _sheet;
@end
