//
//  WinningScreen.m
//  3004iPhone
//
//  Created by Richard Ison on 2014-04-06.
//
//

#import "WinningScreen.h"

@implementation WinningScreen {

    SPButton *endGameButton;
    SPTextField *username;

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
    
    
    SPImage *background = [[SPImage alloc] initWithContentsOfFile:@"WinningScreen@2x.png"];
    
    //necessary or else it gets placed off screen
    background.x = 0;
    background.y = 0;
    
    
    [_contents addChild:background];
    
    
    SPTexture *endgameTexture = [SPTexture textureWithContentsOfFile:@"endgame.png"];
    
    endGameButton = [SPButton buttonWithUpState:endgameTexture];
    
    endGameButton.x = _gameWidth / 2  - endGameButton.width /2;
    endGameButton.y = 400;
   
    [_contents addChild:endGameButton];
    
    
    username = [SPTextField textFieldWithWidth:140 height:30 text:@"Username"];
    username.x = 25;
    username.y = 145;
    username.fontSize = 30;
    username.color = SP_RED;
    [_contents addChild:username];

    
  
}


@end
