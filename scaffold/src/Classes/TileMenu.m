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
#import "ScaledGamePiece.h"

@implementation TileMenu
{
    SPSprite *_contents;
    SPSprite *_currentScene;
    SPSprite *_tileMenu;
    
    ScaledGamePiece *_swamp_065;
    ScaledGamePiece *_swamp_066;
    ScaledGamePiece *_swamp_067;
    ScaledGamePiece *_swamp_068;
    ScaledGamePiece *_swamp_069;
    
    
    
 
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

    
//    [self scaleImage:_swamp_065 fileName:@"T_Swamp_065.png" addParent:_contents setX:5 setY:50];
//    [self scaleImage:_swamp_066 fileName:@"T_Swamp_066.png" addParent:_contents setX:5 setY:90];
//    [self scaleImage:_swamp_067 fileName:@"T_Swamp_067.png" addParent:_contents setX:5 setY:130];
//    [self scaleImage:_swamp_068 fileName:@"T_Swamp_068.png" addParent:_contents setX:5 setY:170];
//    [self scaleImage:_swamp_069 fileName:@"T_Swamp_069.png" addParent:_contents setX:5 setY:200];
    
    _swamp_065 = [[ScaledGamePiece alloc] initWithContentsOfFile:@"T_Swamp_065.png"];
    
    [_contents addChild:_swamp_065];
    

    SPTexture *buttonTexture = [SPTexture textureWithContentsOfFile:@"Button-Normal@2x.png"];
    SPButton * button = [SPButton buttonWithUpState:buttonTexture text:@"Back"];
    
    button.x = 320 / 2 - button.width /2;
    button.y = 370;
    
    [_contents addChild:button];
    
    [button addEventListener:@selector(onButtonTriggered:) atObject:self forType:SP_EVENT_TYPE_TRIGGERED];
  


}

- (void) scaleImage:(ScaledGamePiece*)image fileName:(NSString*) file addParent:(SPSprite*) add setX:(float)posX setY:(float)posY{
    
    image = [[ScaledGamePiece alloc]initWithContentsOfFile:file];
    image.scaleX = 0.7f;
    image.scaleY = 0.7f;
    image.x = posX;
    image.y = posY;
    [add addChild:image];
}



- (void)onButtonTriggered:(SPEvent *)event
{
    
    NSLog(@"Back to twoThreeBoard");
    _contents.visible = NO;
}

- (void)showScene:(SPSprite *)scene {

    
    _currentScene.visible = NO;
    _currentScene = scene;
    scene.visible = YES;
}


//- (void)onMoveTile:(SPTouchEvent*)event {
//    
//    SPImage *img = (SPImage*)event.target;
//    
//    NSArray *touches = [[event touchesWithTarget:self andPhase:SPTouchPhaseMoved] allObjects];
//    
//    if (touches.count == 1)
//    {
//        // one finger touching -> move
//        SPTouch *touch = touches[0];
//        SPPoint *movement = [touch movementInSpace:self.parent];
//        
//        img.x += movement.x;
//        img.y += movement.y;
//        
//        
//        
//    }
//    
//}


@end
