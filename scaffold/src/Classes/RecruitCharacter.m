//
//  RecruitCharacter.m
//  3004iPhone
//
//  Created by Richard Ison on 2014-03-16.
//
//

#import "RecruitCharacter.h"
#import "HeroMenu.h"
#import "DischargeMenu.h"

@interface RecruitCharacter ()
-(void)setup;
@end

@implementation RecruitCharacter{
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
    
    SPImage *background = [[SPImage alloc] initWithContentsOfFile:@"RecruitThingsBackground@2x.png"];
    
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
    
    //Recruit Hero Button
    SPTexture *heroButtonTexture = [SPTexture textureWithContentsOfFile:@"hero.png"];
    SPButton *heroButton = [SPButton buttonWithUpState:heroButtonTexture];
    heroButton.x = _gameWidth /2 - heroButton.width /2;
    heroButton.y = 55 + 90 - 30;
    [_contents addChild:heroButton];
    [heroButton addEventListener:@selector(didClickOnHeroRecruit:) atObject:self forType:SP_EVENT_TYPE_TRIGGERED];
    
    //Discharge Hero Button
    SPTexture *dischargeButtonTexture = [SPTexture textureWithContentsOfFile:@"dischargehero.png"];
    SPButton *dischargeButton = [SPButton buttonWithUpState:dischargeButtonTexture];
    dischargeButton.x = _gameWidth /2 - heroButton.width /2;
    dischargeButton.y = 135 + 90 - 30;
    [_contents addChild:dischargeButton];
    [dischargeButton addEventListener:@selector(didClickOnDischarge:) atObject:self forType:SP_EVENT_TYPE_TRIGGERED];

    //Skip Button
    SPTexture *skipButtonTexture = [SPTexture textureWithContentsOfFile:@"skip.png"];
    SPButton *skipButton = [SPButton buttonWithUpState:skipButtonTexture];
    skipButton.x = _gameWidth /2 - skipButton.width /2;
    skipButton.y = 385;
    [_contents addChild:skipButton];
    [skipButton addEventListener:@selector(didClickOnSkip:) atObject:self forType:SP_EVENT_TYPE_TRIGGERED];

}
- (void) didClickOnHeroRecruit:(SPEvent *) event{
    NSLog(@"Clicked hero");
    [self showHeroMenu];
}
- (void) didClickOnDischarge:(SPEvent *) event{
    NSLog(@"Clicked discharge");
    [self showDischargeMenu];
}
- (void) didClickOnSkip:(SPEvent *) event{
    NSLog(@"Clicked skip");
    _contents.visible = NO;
}


- (void)showHeroMenu{
    HeroMenu *heroMenu = [[HeroMenu alloc]init];
    [self showScene:heroMenu];
}
- (void)showDischargeMenu{
    DischargeMenu *dischargeMenu = [[DischargeMenu alloc]init];
    [self showScene:dischargeMenu];
}
-(void) showScene:(SPSprite *)scene
{
    [self addChild:scene];
    scene.visible = YES;
    
}

@end
