//
//  YourPiecesMenu.h
//  3004iPhone
//
//  Created by Richard Ison on 2014-03-27.
//
//

#import "SPSprite.h"
#import "AbstractInGameScreen.h"

@class Player, BoardLocation;
@interface PiecesMenu : AbstractInGameScreen
{
    Player *_player;
    BoardLocation *_location;
}

@property Player *player;
@property BoardLocation *location;


-(id) initForPlayer: (Player*) player onLocation: (BoardLocation*) location withParent: (SPSprite*) parent andIsOpposingPlayer: (BOOL) isOpposingPlayer;

@end
