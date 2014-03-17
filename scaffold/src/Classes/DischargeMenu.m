//
//  DischargeMenu.m
//  3004iPhone
//
//  Created by Richard Ison on 2014-03-16.
//
//

#import "DischargeMenu.h"

@implementation DischargeMenu{
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
    
    //TODO:
    //
    // Implement real time instructions to tell users what to do.
    //
    // Double click one of the heros on screen; double clicking will show what
    // hero you selected. Then clicking the discharge button will discharge the hero
    //
    //
    //
    //
    
    //Discharge Button
    SPTexture *dischargeButtonTexture = [SPTexture textureWithContentsOfFile:@"discharge.png"];
    SPButton *dischargeButton = [SPButton buttonWithUpState:dischargeButtonTexture];
    dischargeButton.x = _gameWidth /2 - dischargeButton.width /2;
    dischargeButton.y = 385 - 50;
    [_contents addChild:dischargeButton];
    [dischargeButton addEventListener:@selector(didClickOnDischarge:) atObject:self forType:SP_EVENT_TYPE_TRIGGERED];
}


@end
