//
//  RecruitCharacterOption.m
//  3004iPhone
//
//  Created by Richard Ison on 2014-03-16.
//
//

#import "HeroMenu.h"

@implementation HeroMenu{
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
    
    SPImage *background = [[SPImage alloc] initWithContentsOfFile:@"heroBackground@2x.png"];
    
    //necessary or else it gets placed off screen
    background.x = 0;
    background.y = 0;
    
    [_contents addChild:background];
    
    //Username text
    SPTextField *welcomeTF = [SPTextField textFieldWithWidth:300 height:120
                                                        text:@"Username"];
    welcomeTF.x = welcomeTF.y = 10;
    welcomeTF.fontName = @"ArialMT";
    welcomeTF.fontSize = 25;
    welcomeTF.color = 0xffffff;
    [_contents addChild:welcomeTF];
    
    //During the Recruiting Heroes Phase, choose one unowned face-up hero from
    //near the bank and roll two dice
    //
    //Double the character’s combat number and compare this number to your
    //die-roll. If you roll greater than or equal to the number, you gain the Hero.
    //Otherwise he remains unowned unless you spend gold.
  
    
    //Roll Button
    SPTexture *rollButtonTexture = [SPTexture textureWithContentsOfFile:@"rolldice.png"];
    SPButton *rollButton = [SPButton buttonWithUpState:rollButtonTexture];
    rollButton.x = _gameWidth / 20;
    rollButton.y = 385 - 50;
    rollButton.scaleX = rollButton.scaleY = 0.8;
    [_contents addChild:rollButton];
    [rollButton addEventListener:@selector(didClickOnRoll:) atObject:self forType:SP_EVENT_TYPE_TRIGGERED];
    

    //TODO:
    //
    // Implement real time instructions to tell users what to do.
    //
    // Clicking modify before you roll will cost 5 gold and add +1 to the roll
    // Clicking modify after you roll will cost 10 gold and add +1 on the roll
    //
    //
    
    //Modify
    SPTexture *modifyButtonTexture = [SPTexture textureWithContentsOfFile:@"modify.png"];
    SPButton *modifyButton = [SPButton buttonWithUpState:modifyButtonTexture];
    modifyButton.x = rollButton.x + modifyButton.width - 30;
    modifyButton.y = 385- 50;
    modifyButton.scaleX = modifyButton.scaleY = 0.8;
    [_contents addChild:modifyButton];
    [modifyButton addEventListener:@selector(didClickOnRoll:) atObject:self forType:SP_EVENT_TYPE_TRIGGERED];
    
    
    
}


@end
