//
//  AbstractInGameScreen.h
//  3004iPhone
//
//  Created by Devin Lynch on 2014-04-04.
//
//

#import "SPSprite.h"
#import "Utils.h"

@class Player,BoardLocation;
@interface AbstractInGameScreen : SPSprite
{
    SPSprite *_contents;
    
    int _gameWidth;
    int _gameHeight;
    
    SPSprite *_parent;
}

-(id) initFromParent: (SPSprite*) parent;

-(void) show;
-(void) hide;
-(void) setup;


-(void) showPiecesMenuForPlayer: (Player*) p onLocation: (BoardLocation*) location;

@end
