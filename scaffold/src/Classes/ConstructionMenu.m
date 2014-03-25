//
//  ConstructionMenu.m
//  3004iPhone
//
//  Created by Richard Ison on 2014-03-18.
//
//

#import "ConstructionMenu.h"

@implementation ConstructionMenu
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


-(void) setup{
    
    _gameWidth = Sparrow.stage.width;
    _gameHeight = Sparrow.stage.height;
    
    _contents = [SPSprite sprite];
    [self addChild:_contents];
    
    SPImage *background = [[SPImage alloc] initWithContentsOfFile:@"randomEventsBackground@2x.png"];
    
    //necessary or else it gets placed off screen
    background.x = 0;
    background.y = 0;
    
    [_contents addChild:background];
    
    //Username text
    SPTextField *welcomeTF = [SPTextField textFieldWithWidth:300 height:120
                                                        text:@"Construction"];
    welcomeTF.x = welcomeTF.y = 10;
    welcomeTF.fontName = @"ArialMT";
    welcomeTF.fontSize = 25;
    welcomeTF.color = 0xffffff;
    [_contents addChild:welcomeTF];
    
    
    //Gold text
    SPTextField *goldTF = [SPTextField textFieldWithWidth:300 height:120
                                                        text:@"Your gold: 10"];
    goldTF.x = 10;
    goldTF.y = 40;
    goldTF.fontName = @"ArialMT";
    goldTF.fontSize = 25;
    goldTF.color = 0xffffff;
    [_contents addChild:goldTF];
    
    //TODO:
    //
    // Implement real time instructions to tell users what to do.
    //
    // Double click on one of the forts you own to updgrade
    // - 5 to gold
    
    //Upgrade Button
    SPTexture *upgradeButtonTexture = [SPTexture textureWithContentsOfFile:@"upgrade.png"];
    SPButton *upgradeButton = [SPButton buttonWithUpState:upgradeButtonTexture];
    upgradeButton.x = 0;
    upgradeButton.y = 400;
    upgradeButton.scaleX = upgradeButton.scaleY = 0.8;
    [_contents addChild:upgradeButton];
    [upgradeButton addEventListener:@selector(didClickOnUpgrade:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    
    //Build button
    SPTexture *buildButtonTexture = [SPTexture textureWithContentsOfFile:@"build.png"];
    SPButton *buildButton = [SPButton buttonWithUpState:buildButtonTexture];
    buildButton.x = _gameWidth /2 - buildButton.width/2 + 100;
    buildButton.y = 400;
    buildButton.scaleX = buildButton.scaleY = 0.8;
    [_contents addChild:buildButton];
    [buildButton addEventListener:@selector(didClickOnBuild:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    
    
    //Skip Button
    SPTexture *skipButtonTexture = [SPTexture textureWithContentsOfFile:@"skip.png"];
    SPButton *skipButton = [SPButton buttonWithUpState:skipButtonTexture];
    skipButton.x = _gameWidth /2 - upgradeButton.width/2 + 20;
    skipButton.y = 480;
    skipButton.scaleX = skipButton.scaleY = 0.8;
    [_contents addChild:skipButton];
    [skipButton addEventListener:@selector(didClickOnSkip:) atObject:self forType:SP_EVENT_TYPE_TRIGGERED];
}

-(void) didClickOnPlay:(SPTouchEvent*) event{
    NSArray *touches = [[event touchesWithTarget:self andPhase:SPTouchPhaseBegan] allObjects];
    
    
    if (touches.count == 1) {
        
        // Find card id, show pop up of description
        
        
    } else if (touches.count == 2){
        
        //Selects the card
        
        
    }
    
    
}

- (void) didClickOnBuild:(SPEvent *) event{
    NSLog(@"Clicked build");
    _contents.visible = NO;
}

- (void) didClickOnSkip:(SPEvent *) event{
    NSLog(@"Clicked skip");
    _contents.visible = NO;
}


@end
