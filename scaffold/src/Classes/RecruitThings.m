//
//  RecruitThings.m
//  3004iPhone
//
//  Created by Richard Ison on 2/3/2014.
//
//

#import "RecruitThings.h"
#import "ScaledGamePiece.h"
#import "TouchSheet.h"
#import "TileMenu.h"
#import "Scene.h"
#import "GameMenu.h"
#import "RecruitOptionMenu.h"


@interface RecruitThings()
- (void)setup;
@end

@implementation RecruitThings{
    
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
    
    
    SPImage *background = [[SPImage alloc] initWithContentsOfFile:@"recruitThings.png"];
    
    //necessary or else it gets placed off screen
    background.x = 0;
    background.y = 0;
    
    background.blendMode = SP_BLEND_MODE_NONE;
    [_contents addChild:background];
    
    //Text
    SPTextField *welcomeTF = [SPTextField textFieldWithWidth:300 height:120
                                                        text:@"Username"];
    welcomeTF.x = welcomeTF.y = offset;
    welcomeTF.fontName = @"ArialMT";
    welcomeTF.fontSize = 25;
    welcomeTF.color = 0xffffff;
    [_contents addChild:welcomeTF];
    
    
    //Button
    SPTexture *buttonTexture = [SPTexture textureWithContentsOfFile:@"free.png"];
    SPButton * button = [SPButton buttonWithUpState:buttonTexture];
    
    button.x = 320 / 2 - button.width /2;
    button.y = 55 + 90 - 30;
    
    [_contents addChild:button];
    
    [button addEventListener:@selector(showOptions:) atObject:self forType:SP_EVENT_TYPE_TRIGGERED];
    
    //Button

    SPTexture *buttonTexture2 = [SPTexture textureWithContentsOfFile:@"buy.png"];

    SPButton * button2 = [SPButton buttonWithUpState:buttonTexture2];
    
    button2.x = 320 / 2 - button2.width /2;
    button2.y = 135+ 90 - 30;
    
    [_contents addChild:button2];
    
    [button2 addEventListener:@selector(showOptions:) atObject:self forType:SP_EVENT_TYPE_TRIGGERED];
    
    
    SPTexture *buttonTexture3 = [SPTexture textureWithContentsOfFile:@"trade.png"];

    SPButton * button3 = [SPButton buttonWithUpState:buttonTexture3];
    
    button3.x = 320 / 2 - button2.width /2;
    button3.y = 220 + 90 - 30;
    
    [_contents addChild:button3];
    
    //[button3 addEventListener:@selector(onButtonTriggered:) atObject:self forType:SP_EVENT_TYPE_TRIGGERED];
    
    
    SPTexture *buttonTexture4 = [SPTexture textureWithContentsOfFile:@"back.png"];
    SPButton * button4 = [SPButton buttonWithUpState:buttonTexture4];
    
    button4.x = 320 / 2 - button2.width /2;
    button4.y = 450 - 40;
    
    [_contents addChild:button4];
    
    [button4 addEventListener:@selector(onButtonTriggered:) atObject:self forType:SP_EVENT_TYPE_TRIGGERED];

    
}


- (void) showOptions:(SPEvent *) event{
    
    RecruitOptionMenu *recruitMenu = [[RecruitOptionMenu alloc] init];
    [self showScene:recruitMenu];
}


- (void)showScene:(SPSprite *)scene {
    
    [self addChild:scene];
    scene.visible = YES;
}

-(void) onButtonTriggered: (SPEvent *) event
{
    NSLog(@"Back to game board");
    GameMenu *gameMenu = [[GameMenu alloc] init];
    [self showScene:gameMenu];
    _contents.visible = NO;
    
}


@end
