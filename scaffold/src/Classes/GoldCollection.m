//
//  GoldCollection.m
//  3004iPhone
//
//  Created by Richard Ison on 1/29/2014.
//
//

#import "GoldCollection.h"
#import "ScaledGamePiece.h"
#import "TouchSheet.h"
#import "TileMenu.h"
#import "Scene.h"
#import "GameMenu.h"

@interface GoldCollection()
- (void)setup;
@end

@implementation GoldCollection{
    
    SPSprite *_contents;
    SPSprite *_currentScene;
    
    int _gameWidth;
    int _gameHeight;
}


static GoldCollection *instance = nil;

+(GoldCollection*) getInstance{
    
    if (instance == nil) {
        instance = [[GoldCollection alloc] init];
        
    }
    return instance;
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
    
    
    SPImage *background = [[SPImage alloc] initWithContentsOfFile:@"mainMenuBackground.png"];
    
    //necessary or else it gets placed off screen
    background.x = 0;
    background.y = 0;
    
    background.blendMode = SP_BLEND_MODE_NONE;
    [_contents addChild:background];
    
    
    SPImage *logo = [[SPImage alloc] initWithContentsOfFile:@"logo.png"];
    logo.x = 31;
    logo.y=  5;
    logo.scaleX = 0.5;
    logo.scaleY = 0.5;
    
    [_contents addChild:logo];
    
    //Text
    SPTextField *welcomeTF = [SPTextField textFieldWithWidth:300 height:120
        text:@"Username"];
    welcomeTF.x = welcomeTF.y = offset;
    welcomeTF.fontName = @"ArialMT";
    welcomeTF.fontSize = 25;
    welcomeTF.color = 0x0;
    [_contents addChild:welcomeTF];
    
    
    //Text
    SPTextField *goldTF = [SPTextField textFieldWithWidth:300 height:120
                                                        text:@"Gold pieces: 0"];
    goldTF.x = offset - 15;
    goldTF.y = 305;
    goldTF.fontName = @"ArialMT";
    goldTF.fontSize = 25;
    goldTF.color = SP_YELLOW;
    [_contents addChild:goldTF];
    
    //Text
    SPTextField *incomeTF = [SPTextField textFieldWithWidth:300 height:120
                                                     text:@"Income: 0"];
    incomeTF.x = offset- 15;
    incomeTF.y = 330;
    incomeTF.fontName = @"ArialMT";
    incomeTF.fontSize = 25;
    incomeTF.color = SP_YELLOW;
    [_contents addChild:incomeTF];
    
    //Button
    SPTexture *buttonTexture = [SPTexture textureWithContentsOfFile:@"btn.png"];
    SPButton * button = [SPButton buttonWithUpState:buttonTexture text:@"Collect gold!"];
    
    button.x = 320 / 2 - button.width /2;
    button.y = _gameHeight / 2;
    
    [_contents addChild:button];
    
    [button addEventListener:@selector(collectIncome:) atObject:self forType:SP_EVENT_TYPE_TRIGGERED];
    
    //Button
    SPButton * button2 = [SPButton buttonWithUpState:buttonTexture text:@"back"];
 
    
    button2.x = 320 / 2 - button2.width /2;
    button2.y = 450;
    
    [_contents addChild:button2];
    
    [button2 addEventListener:@selector(onButtonTriggered:) atObject:self forType:SP_EVENT_TYPE_TRIGGERED];

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

-(void) collectIncome{

};

@end
