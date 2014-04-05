//
//  AbstractInGameScreen.m
//  3004iPhone
//
//  Created by Devin Lynch on 2014-04-04.
//
//

#import "AbstractInGameScreen.h"
#import "PiecesMenu.h"

@implementation AbstractInGameScreen
{
    
}

-(id) initFromParent: (SPSprite*) parent{
    self = [super init];
    if(self) {
        _parent = parent;
    }
    return self;
}

-(void) show{
    [self removeFromParent];
    self.visible = YES;
    [_parent addChild:self];
}

-(void) hide{
    [self removeFromParent];
    self.visible = NO;
}

-(void) setup {
    _contents = [SPSprite sprite];
    [self addChild:_contents];
    
    _gameWidth = Sparrow.stage.width;
    _gameHeight = Sparrow.stage.height;
}

-(void) showPiecesMenuForPlayer: (Player*) p onLocation: (BoardLocation*) location isOpposingPlayer: (BOOL) isOpposingPlayer{
    PiecesMenu* piecesMenu = [[PiecesMenu alloc] initForPlayer:p onLocation:location withParent:self andIsOpposingPlayer:isOpposingPlayer];
    [piecesMenu show];
}

@end
