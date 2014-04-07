//
//  RandomEventsMenu.m
//  3004iPhone
//
//  Created by Richard Ison on 2014-03-17.
//
//

#import "RandomEventsMenu.h"
#import "GameResource.h"
#import "GamePiece.h"
#import "InGameServerAccess.h"
#import "SpecialCharacter.h"
#import "Utils.h"
#import "RandomEvent.h"

@implementation RandomEventsMenu{
    NSMutableArray *_randomEvents;
    SPImage *borderImage;
    RandomEvent *selectedRandomEvent;

}


-(id) init
{
    if ((self = [super initFromParent:nil]))
    {
        [self setup];
    }
    
    return self;
}

-(id) initFromParent:(SPSprite *)parent
{
    if ((self = [super initFromParent:parent]))
    {
        [self setup];
    }
    
    return self;
}



-(void) setup{
    [super setup];
    
    
    SPImage *background = [[SPImage alloc] initWithContentsOfFile:@"randomEventsBackground@2x.png"];
    
    //necessary or else it gets placed off screen
    background.x = 0;
    background.y = 0;
    
    [_contents addChild:background];
    
       NSArray *recruits = [NSArray arrayWithObjects:@"RandomEvent_01",@"RandomEvent_02",@"RandomEvent_03",@"RandomEvent_04",@"RandomEvent_05",@"RandomEvent_06",@"RandomEvent_07",@"RandomEvent_08",@"RandomEvent_09",@"RandomEvent_10", nil];
    
       _randomEvents= [NSMutableArray arrayWithArray:recruits];
    
    
    
    int numInRow=1;
    int row=1;
    for(NSString *randomId in _randomEvents) {
        RandomEvent *gp = [[GameResource getInstance] getRandomEventForId:randomId];
        SPButton *_selectedPieceImage;
        SPTexture *text = [SPTexture textureWithContentsOfFile:[gp fileName]];
        _selectedPieceImage = [SPButton buttonWithUpState:text];
        _selectedPieceImage.x = (_gameWidth/4)*numInRow-70;
        _selectedPieceImage.y = 40+(90*row);
        [_selectedPieceImage setName:randomId];
        
        [_selectedPieceImage addEventListener:@selector(didClickOnRandomEvent:) atObject:self forType:SP_EVENT_TYPE_TRIGGERED];
        
        [_contents addChild:_selectedPieceImage];
        numInRow++;
        if(numInRow>5) {
            row++;
            numInRow=1;
        }
    }


    
    
    //Username text
    SPTextField *welcomeTF = [SPTextField textFieldWithWidth:300 height:120
                                                        text:@"Random Events"];
    welcomeTF.x = welcomeTF.y = 10;
    welcomeTF.fontName = @"ArialMT";
    welcomeTF.fontSize = 25;
    welcomeTF.color = 0xffffff;
    [_contents addChild:welcomeTF];
    
    
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

-(void) didClickOnRandomEvent:(SPEvent *) event{
    SPImage *selectedPiece = (SPImage*)event.target;
    
    if(borderImage != nil) {
        [borderImage removeFromParent];
    }
    
    selectedRandomEvent = [[GameResource getInstance] getRandomEventForId:selectedPiece.name];
    if(selectedRandomEvent != nil) {
        borderImage = [[SPImage alloc] initWithContentsOfFile:@"borderTile.png"];
        borderImage.x = selectedPiece.x;
        borderImage.y = selectedPiece.y;
    }
    
    
    [_contents addChild:borderImage];
}

-(void) didClickOnPlay:(SPTouchEvent*) event{
    NSArray *touches = [[event touchesWithTarget:self andPhase:SPTouchPhaseBegan] allObjects];
    
    
    if (touches.count == 1) {
        
        // Find card id, show pop up of description
        
        NSLog(@"Clicked play");
    }
    
}

- (void) didClickOnSkip:(SPEvent *) event{
    NSLog(@"Clicked skip");
    _contents.visible = NO;
}



@end
