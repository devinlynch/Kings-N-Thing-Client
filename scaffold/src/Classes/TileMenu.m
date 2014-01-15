//
//  TileMenu.m
//  3004iPhone
//
//  Created by Richard Ison on 1/14/2014.
//
//

#import "TileMenu.h"
#import "TwoThreePlayerGame.h"
#import "Scene.h"

@implementation TileMenu
{
    SPSprite *_contents;
    SPSprite *_currentScene;
    SPSprite *_tileMenu;
    
    SPImage *_swamp_065;
    SPImage *_swamp_066;
    SPImage *_swamp_067;
    SPImage *_swamp_068;
    SPImage *_swamp_069;
    
    
 
}

- (id)init
{
    if ((self = [super init]))
    {
        [self setup];
    }
    return self;
}


- (void) setup {
    _contents = [SPSprite sprite];
    [self addChild:_contents];

    SPImage *background = [[SPImage alloc] initWithContentsOfFile:@"SwampTileMenu.png"];
    
    [_contents addChild:background];
    
    //Test: adding swamp cards
    _swamp_065 = [[SPImage alloc] initWithContentsOfFile:@"T_Swamp_065.png"];
    _swamp_065.x = 5;
    _swamp_065.y = 10;
    [_contents addChild:_swamp_065];
    _swamp_066 = [[SPImage alloc] initWithContentsOfFile:@"T_Swamp_066.png"];
    _swamp_066.x = 5;
    _swamp_066.y = 50;
    [_contents addChild:_swamp_066];
    _swamp_067 = [[SPImage alloc] initWithContentsOfFile:@"T_Swamp_067.png"];
    _swamp_067.x = 5;
    _swamp_067.y = 90;
    [_contents addChild:_swamp_067];
    _swamp_068 = [[SPImage alloc] initWithContentsOfFile:@"T_Swamp_068.png"];
    _swamp_068.x = 5;
    _swamp_068.y = 140;
    [_contents addChild:_swamp_068];
    _swamp_069 = [[SPImage alloc] initWithContentsOfFile:@"T_Swamp_069.png"];
    _swamp_069.x = 5;
    _swamp_069.y = 190;
    [_contents addChild:_swamp_069];
    
     [_swamp_065 addEventListener:@selector(onMoveTile:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
     [_swamp_066 addEventListener:@selector(onMoveTile:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
     [_swamp_067 addEventListener:@selector(onMoveTile:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
     [_swamp_068 addEventListener:@selector(onMoveTile:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
     [_swamp_069 addEventListener:@selector(onMoveTile:) atObject:self forType:SP_EVENT_TYPE_TOUCH];


    SPTexture *buttonTexture = [SPTexture textureWithContentsOfFile:@"Button-Normal@2x.png"];
    SPButton * button = [SPButton buttonWithUpState:buttonTexture text:@"Back"];
    
    button.x = 320 / 2 - button.width /2;
    button.y = 370;
    
    [_contents addChild:button];
    
    [button addEventListener:@selector(onButtonTriggered:) atObject:self forType:SP_EVENT_TYPE_TRIGGERED];
  


}

- (void)onButtonTriggered:(SPEvent *)event
{
    TwoThreePlayerGame * game = [[TwoThreePlayerGame alloc]init];
    [self showScene:game];
    

}

- (void)showScene:(SPSprite *)scene {
//    if ([self containsChild:_currentScene]) {
//        [self removeChild:_currentScene];
//    }
    [self addChild:scene];
    _currentScene.visible = NO;
    _currentScene = scene;
    scene.visible = YES;
}


- (void)onMoveTile:(SPTouchEvent*)event {
    
    SPImage *img = (SPImage*)event.target;
    
    NSArray *touches = [[event touchesWithTarget:self andPhase:SPTouchPhaseMoved] allObjects];
    
    if (touches.count == 1)
    {
        // one finger touching -> move
        SPTouch *touch = touches[0];
        SPPoint *movement = [touch movementInSpace:self.parent];
        
        img.x += movement.x;
        img.y += movement.y;
        
        
        
    }
    
}


@end
