//
//  YourPiecesMenu.h
//  3004iPhone
//
//  Created by Richard Ison on 2014-03-27.
//
//

#import "SPSprite.h"
#import "AbstractInGameScreen.h"

@class Player, BoardLocation, GamePiece;
@interface PiecesMenu : AbstractInGameScreen
{
    GamePiece *_selectedPiece;
    Player *_player;
    BoardLocation *_location;
    NSArray *presetPieces;
    NSString *bgFileName;
}

@property Player *player;
@property BoardLocation *location;


-(id) initForPlayer: (Player*) player onLocation: (BoardLocation*) location withParent: (SPSprite*) parent andIsOpposingPlayer: (BOOL) isOpposingPlayer;
-(void) didClickOnRecruit:(SPEvent *) event;
- (void) didClickOnSkip:(SPEvent *) event;

@end

