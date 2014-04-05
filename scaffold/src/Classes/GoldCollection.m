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
#import "ServerAccess.h"

@interface GoldCollection()
- (void)setup;
@end

@implementation GoldCollection{
    
    SPSprite *_contents;
    SPSprite *_currentScene;
    
    int _gameWidth;
    int _gameHeight;
    
    SPTextField *_incomeTF;
    SPTextField *_goldTF;
    SPTextField *_usernameTF;
    
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

    SPImage *background = [[SPImage alloc] initWithContentsOfFile:@"GoldCollectionBackground@2x.png"];
    
    //necessary or else it gets placed off screen
    background.x = 0;
    background.y = 0;
    
    background.blendMode = SP_BLEND_MODE_NONE;
    [_contents addChild:background];
    
    
    //Username text
    _usernameTF = [SPTextField textFieldWithWidth:300 height:120
        text:@"Username"];
    _usernameTF.x = _gameWidth / 2 - _usernameTF.width / 2;
    _usernameTF.fontName = @"ArialMT";
    _usernameTF.fontSize = 25;
    _usernameTF.color = 0xffffff;
    [_contents addChild:_usernameTF];
    
    
    //GoldPiece text
    _goldTF = [SPTextField textFieldWithWidth:300 height:120
                                                     text:@"Gold pieces: 9999"];
    _goldTF.x = _gameWidth / 2 - _goldTF.width / 2;
    _goldTF.y = _gameHeight - _goldTF.height * 2;
    _goldTF.fontName = @"ArialMT";
    _goldTF.fontSize = 25;
    _goldTF.color = SP_YELLOW;
    [_contents addChild:_goldTF];
    
    //Income text
    _incomeTF = [SPTextField textFieldWithWidth:300 height:120
                                                       text:@"Income: 9999"];
    _incomeTF.x = _gameWidth / 2 - _incomeTF.width / 2;
    _incomeTF.y = _gameHeight - _incomeTF.height * 2 + offset * 2.2;
    _incomeTF.fontName = @"ArialMT";
    _incomeTF.fontSize = 25;
    _incomeTF.color = SP_YELLOW;
    [_contents addChild:_incomeTF];
    
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
   // [_contents addChild:backButton];
   // [backButton addEventListener:@selector(onButtonTriggered:) atObject:self forType:SP_EVENT_TYPE_TRIGGERED];

}


-(void) setIncome: (NSString*) income{
    [_incomeTF setText:income];

}

-(void) setTotal: (NSString*) total{
    [_goldTF setText:total];
}

-(void) setUsername:(NSString *)username{
    [_usernameTF setText:username];
}


- (void)showScene:(SPSprite *)scene {
    
    [self addChild:scene];
    scene.visible = YES;
}

-(void) onButtonTriggered: (SPEvent *) event
{

    NSLog(@"Back to game board");
    [self setVisible:NO];
    
}

-(void) collectIncome{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"collectedGold" object:nil];
}

@end
