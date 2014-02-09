//
//  TileMenu.m
//  3004iPhone
//
//  Created by Richard Ison on 2/9/2014.
//
//

#import "TileMenu.h"



#import "TileMenu.h"
#import "TwoThreePlayerGame.h"
#import "Scene.h"
#import "ScaledGamePiece.h"


@interface TileMenu ()
- (void) setup;
- (void) showScene:(SPSprite*)scene;
@end

@implementation TileMenu
{
    SPSprite *_contents;
    SPSprite *_currentScene;
    
    int _gameWidth;
    int _gameHeight;

}

-(id) init
{
    if ((self = [super init]))
    {
        [self setup];
    }
    return self;
}


-(void) setup
{
    _gameWidth = Sparrow.stage.width;
    _gameHeight = Sparrow.stage.height;
    
    _contents = [SPSprite sprite];
    [self addChild:_contents];
    
    int offset = 10;
    
    SPImage *background = [[SPImage alloc]
                           initWithContentsOfFile:@"jungle-tile-menu.png"];
    
    [_contents addChild:background];

    
    SPTexture *buttonTexture3 = [SPTexture textureWithContentsOfFile:@"back.png"];
    SPButton * button3 = [SPButton buttonWithUpState:buttonTexture3];
    
    button3.x = 320 / 2 - button3.width /2;
    button3.y = 410;
    
    [_contents addChild:button3];
    
    [button3 addEventListener:@selector(onButtonTriggered:) atObject:self forType:SP_EVENT_TYPE_TRIGGERED];





}

-(void) onButtonTriggered: (SPEvent *) event
{
    NSLog(@"Back to board things");
    //    GameMenu *gameMenu = [[GameMenu alloc] init];
    //    [self showScene:gameMenu];
    _contents.visible = NO;
    
}


@end
