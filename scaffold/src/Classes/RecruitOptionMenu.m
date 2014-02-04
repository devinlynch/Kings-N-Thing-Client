//
//  RecruitOptionMenu.m
//  3004iPhone
//
//  Created by Richard Ison on 2/3/2014.
//
//

#import "RecruitOptionMenu.h"
#import "RecruitThings.h"
#import "GameBoard.h"

@implementation RecruitOptionMenu{
    
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
    SPTexture *buttonTexture = [SPTexture textureWithContentsOfFile:@"board.png"];
    SPButton * button = [SPButton buttonWithUpState:buttonTexture];
    
    button.x = 320 / 2 - button.width /2;
    button.y = 35 + 170;
    
    [_contents addChild:button];
    
    [button addEventListener:@selector(placeOnBoard:) atObject:self forType:SP_EVENT_TYPE_TRIGGERED];
    
    
    //Button
    
    SPTexture *buttonTexture2 = [SPTexture textureWithContentsOfFile:@"rackbtn.png"];
    SPButton * button2 = [SPButton buttonWithUpState:buttonTexture2];
    
    button2.x = 320 / 2 - button2.width /2;
    button2.y = 110 + 170;
    
    [_contents addChild:button2];
    
    
    
    SPTexture *buttonTexture3 = [SPTexture textureWithContentsOfFile:@"back.png"];
    SPButton * button3 = [SPButton buttonWithUpState:buttonTexture3];
    
    button3.x = 320 / 2 - button2.width /2;
    button3.y = 410;
    
    [_contents addChild:button3];
    
    [button3 addEventListener:@selector(onButtonTriggered:) atObject:self forType:SP_EVENT_TYPE_TRIGGERED];
    
    
    
}


- (void)showScene:(SPSprite *)scene {
    
    [self addChild:scene];
    scene.visible = YES;
}

-(void) placeOnBoard: (SPEvent *) event
{
    NSLog(@"Go to board");
        GameBoard *placeOnBoard = [[GameBoard alloc] init];
        [self showScene:placeOnBoard];
    //_contents.visible = NO;
    
}

-(void) onButtonTriggered: (SPEvent *) event
{
    NSLog(@"Back to recruit things");
//    GameMenu *gameMenu = [[GameMenu alloc] init];
//    [self showScene:gameMenu];
    _contents.visible = NO;
    
}

@end
