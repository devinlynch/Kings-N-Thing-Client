//
//  RandomEventsMenu.m
//  3004iPhone
//
//  Created by Richard Ison on 2014-03-17.
//
//

#import "RandomEventsMenu.h"

@implementation RandomEventsMenu{
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
                                                        text:@"Random Events"];
    welcomeTF.x = welcomeTF.y = 10;
    welcomeTF.fontName = @"ArialMT";
    welcomeTF.fontSize = 25;
    welcomeTF.color = 0xffffff;
    [_contents addChild:welcomeTF];
    
    //TODO:
    //
    // Implement real time instructions to tell users what to do.
    //
    // One click will tell the description of the event
    // Double click to select and pressing play will use the event

    
    //Play Button
    SPTexture *playButtonTexture = [SPTexture textureWithContentsOfFile:@"play.png"];
    SPButton *playButton = [SPButton buttonWithUpState:playButtonTexture];
    playButton.x = 0;
    playButton.y = 400;
    playButton.scaleX = playButton.scaleY = 0.8;
    [_contents addChild:playButton];
    [playButton addEventListener:@selector(didClickOnPlay:) atObject:self forType:
     
     SP_EVENT_TYPE_TOUCH];
    
    //Skip Button
    SPTexture *skipButtonTexture = [SPTexture textureWithContentsOfFile:@"skip.png"];
    SPButton *skipButton = [SPButton buttonWithUpState:skipButtonTexture];
    skipButton.x = _gameWidth /2 - playButton.width/2 + 100;
    skipButton.y = 400;
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

- (void) didClickOnSkip:(SPEvent *) event{
    NSLog(@"Clicked skip");
    _contents.visible = NO;
}



@end
