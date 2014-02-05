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

    SPImage *background = [[SPImage alloc] initWithContentsOfFile:@"GoldCollectionBackground@2x.png"];
    
    //necessary or else it gets placed off screen
    background.x = 0;
    background.y = -45;
    
    background.blendMode = SP_BLEND_MODE_NONE;
    [_contents addChild:background];
    
    
    //Username text
    SPTextField *welcomeTF = [SPTextField textFieldWithWidth:300 height:120
        text:@"Username"];
    welcomeTF.x = _gameWidth / 2 - welcomeTF.width / 2;
    welcomeTF.fontName = @"ArialMT";
    welcomeTF.fontSize = 25;
    welcomeTF.color = 0xffffff;
    [_contents addChild:welcomeTF];
    
    
    //GoldPiece text
    SPTextField *goldTF = [SPTextField textFieldWithWidth:300 height:120
                                                     text:@"Gold pieces: 9999"];
    goldTF.x = _gameWidth / 2 - goldTF.width / 2;
    goldTF.y = _gameHeight - goldTF.height * 2;
    goldTF.fontName = @"ArialMT";
    goldTF.fontSize = 25;
    goldTF.color = SP_YELLOW;
    [_contents addChild:goldTF];
    
    //Income text
    SPTextField *incomeTF = [SPTextField textFieldWithWidth:300 height:120
                                                       text:@"Income: 9999"];
    incomeTF.x = _gameWidth / 2 - incomeTF.width / 2;
    incomeTF.y = _gameHeight - incomeTF.height * 2 + offset * 2.2;
    incomeTF.fontName = @"ArialMT";
    incomeTF.fontSize = 25;
    incomeTF.color = SP_YELLOW;
    [_contents addChild:incomeTF];
    
    //Collect coins button
    SPTexture *collectButtonTexture = [SPTexture textureWithContentsOfFile:@"CollectCoinsBtn.png"];
    SPButton * collectButton = [SPButton buttonWithUpState:collectButtonTexture];
    collectButton.x = _gameWidth / 2 - collectButton.width / 2;
    collectButton.y = _gameHeight - collectButton.height * 2.3;
    [_contents addChild:collectButton];
    
    [collectButton addEventListener:@selector(collectIncome) atObject:self forType:SP_EVENT_TYPE_TRIGGERED];
    
    //Back button
    SPTexture *backButtonTexture = [SPTexture textureWithContentsOfFile:@"back.png"];
    SPButton * backButton = [SPButton buttonWithUpState:backButtonTexture];
    backButton.x = _gameWidth / 2 - collectButton.width / 2;
    backButton.y = 420;
    [_contents addChild:backButton];
    [backButton addEventListener:@selector(onButtonTriggered:) atObject:self forType:SP_EVENT_TYPE_TRIGGERED];

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

-(void) collectIncome{};

@end
