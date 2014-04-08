//
//  GameBoardHelper.h
//  3004iPhone
//
//  Created by Devin Lynch on 2014-04-07.
//
//

#import <Foundation/Foundation.h>

@class FourPlayerGame, GameState, TouchSheet, HexLocation;
@interface GameBoardHelper : NSObject
+(void) populateHexLocationsFromFourPlayerGame: (FourPlayerGame*) fourPlayerGame is2Player:(BOOL) is2Player fromGameState: (GameState*) gameState withTouchSheet: (SPSprite*) parent;
+(int) getYValueForHexLocation: (HexLocation*) hexLocation;
+(int) getXValueForHexLocation: (HexLocation*) hexLocation;

@end
