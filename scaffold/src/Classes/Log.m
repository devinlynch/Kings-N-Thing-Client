//
//  Log.m
//  3004iPhone
//
//  Created by Richard Ison on 2/10/2014.
//
//

#import "Log.h"
#import "Transparency.h"
#import "SPScrollSprite.h"

@implementation Log
{
    SPStage *_contents;
    SPSprite *_currentScene;
    
    int _gameWidth;
    int _gameHeight;
    
    
    SPTextField *_logText;
    
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
    [_contents setTransperent:YES];
    _contents = [SPSprite sprite];
    [self addChild:_contents];
    
    int offset = 10;
    
    SPImage *background = [[SPImage alloc]
                           initWithContentsOfFile:@"infoBackground@2x.png"];
    background.scaleX = 0.8;
    background.scaleY = 0.8;
    background.x = 30;
    background.y = 50;
    
    SPScrollSprite * canvas = [SPScrollSprite sprite];
	[_contents addChild:canvas];
	canvas.scrollRect = [SPRectangle rectangleWithX:5 y:5 width:10 height:10];
    //[_contents addChild:canvas];
    
    
    [_contents addChild:background];
    
    
    SPTexture *buttonTexture3 = [SPTexture textureWithContentsOfFile:@"back.png"];
    SPButton * button3 = [SPButton buttonWithUpState:buttonTexture3];
    
    button3.scaleY = 0.8;
    button3.scaleX = 0.8;
    button3.x = 320 / 2 - button3.width /2.5;
    button3.y = 410;
    
    [_contents addChild:button3];
    
    [button3 addEventListener:@selector(onButtonTriggered:) atObject:self forType:SP_EVENT_TYPE_TRIGGERED];
    
    
    _logText = [SPTextField textFieldWithWidth:300 height:400 text:@"log log log log lolol"];
    _logText.x = 5;
    _logText.y = 5;
    [_contents addChild:_logText];
    

}


-(void) onButtonTriggered: (SPEvent *) event
{
    NSLog(@"Back to board things");
    //    GameMenu *gameMenu = [[GameMenu alloc] init];
    //    [self showScene:gameMenu];
    _contents.visible = NO;
    
}
@end
