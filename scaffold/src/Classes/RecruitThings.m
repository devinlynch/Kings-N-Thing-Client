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
    
    
    SPImage *background = [[SPImage alloc] initWithContentsOfFile:@"RecruitThingsBackground@2x.png"];
    
    //necessary or else it gets placed off screen
    background.x = 0;
    background.y = -60;
    
    background.blendMode = SP_BLEND_MODE_NONE;
    [_contents addChild:background];
    
    //Username text
    SPTextField *welcomeTF = [SPTextField textFieldWithWidth:300 height:120
                                                        text:@"Username"];
    welcomeTF.x = welcomeTF.y = offset;
    welcomeTF.fontName = @"ArialMT";
    welcomeTF.fontSize = 25;
    welcomeTF.color = 0xffffff;
    [_contents addChild:welcomeTF];
    
    
    //Free button
    SPTexture *freeButtonTexture = [SPTexture textureWithContentsOfFile:@"free.png"];
    SPButton *freeButton = [SPButton buttonWithUpState:freeButtonTexture];
    freeButton.x = _gameWidth /2 - freeButton.width /2;
    freeButton.y = 55 + 90 - 30;
    [_contents addChild:freeButton];
    [freeButton addEventListener:@selector(showOptions:) atObject:self forType:SP_EVENT_TYPE_TRIGGERED];
    
    //Button

    SPTexture *buyButtonTexture = [SPTexture textureWithContentsOfFile:@"buy.png"];

    SPButton *buyButton = [SPButton buttonWithUpState:buyButtonTexture];
    
    buyButton.x = _gameWidth /2 - buyButton.width /2;
    buyButton.y = 135+ 90 - 30;
    
    [_contents addChild:buyButton];
    
    [buyButton addEventListener:@selector(showOptions:) atObject:self forType:SP_EVENT_TYPE_TRIGGERED];
    
    
    SPTexture *tradeButtonTexture = [SPTexture textureWithContentsOfFile:@"trade.png"];

    SPButton *tradeButton = [SPButton buttonWithUpState:tradeButtonTexture];
    
    tradeButton.x = _gameWidth /2 - tradeButton.width /2;
    tradeButton.y = 220 + 90 - 30;
    
    [_contents addChild:tradeButton];
    
    //[button3 addEventListener:@selector(onButtonTriggered:) atObject:self forType:SP_EVENT_TYPE_TRIGGERED];
    
    
    SPTexture *backButtonTexture = [SPTexture textureWithContentsOfFile:@"back.png"];
    SPButton *backButton = [SPButton buttonWithUpState:backButtonTexture];
    backButton.x = 320 / 2 - backButton.width /2;
    backButton.y = 385;
    [_contents addChild:backButton];
    
    [backButton addEventListener:@selector(onButtonTriggered:) atObject:self forType:SP_EVENT_TYPE_TRIGGERED];

    
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
