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
#import "FourPlayerGame.h"

@interface RecruitCharacter ()
-(void)setup;
@end

@implementation RecruitCharacter{
    SPSprite *_contents;
    SPSprite *_currentScene;
    
    int _gameWidth;
    int _gameHeight;
    
    FourPlayerGame *_fourPlayerGame;
}

static RecruitCharacter *instance;
+(RecruitCharacter*) getInstance{
    
    if (instance == nil) {
        instance = [[RecruitCharacter alloc] init];
        
    }
    return instance;
}

-(id) init
{
    if ((self = [super init]))
    {
    
        
    }
    
    return self;
}

-(void) setFourPlayerGame :(FourPlayerGame*) game{
    _fourPlayerGame = game;
}


-(void) setup{
    if(_contents == nil) {
        _contents = [SPSprite sprite];
    } else{
        [_contents removeAllChildren];
        _contents.visible = YES;
    }
    
    
    _gameWidth = Sparrow.stage.width;
    _gameHeight = Sparrow.stage.height;
    
    [self addChild:_contents];
    
    SPImage *background = [[SPImage alloc] initWithContentsOfFile:@"RecruitThingsBackground@2x.png"];
    
    //necessary or else it gets placed off screen
    background.x = 0;
    background.y = 0;
    
    [_contents addChild:background];

    //Username text
    SPTextField *welcomeTF = [SPTextField textFieldWithWidth:300 height:120
                                                        text:@"Recruit Characters"];
    welcomeTF.x = welcomeTF.y = 10;
    welcomeTF.fontName = @"ArialMT";
    welcomeTF.fontSize = 25;
    welcomeTF.color = 0xffffff;
    [_contents addChild:welcomeTF];
    
    
    SPTextField *waitYourTurn = [SPTextField textFieldWithWidth:300 height:120
                                                        text:@"Please wait your turn to recruit characters"];
    
    waitYourTurn.width = _gameWidth-20;
    waitYourTurn.x = 10;
    waitYourTurn.y = 300;
    waitYourTurn.fontName = @"ArialMT";
    waitYourTurn.fontSize = 25;
    waitYourTurn.color = 0xffffff;
    [_contents addChild:waitYourTurn];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(yourTurnToRecruitSpecialCharacter:)
                                                 name:@"yourTurnToRecruitSpecialCharacter"
                                               object:nil];
}

-(void) yourTurnToRecruitSpecialCharacter: (NSNotification*) notif{
    HeroMenu *heroMenu = [[HeroMenu alloc]initWithPossibleRecruits:notif.object];
    [heroMenu setFourPlayerGame: _fourPlayerGame];
    [self showScene:heroMenu];
}

- (void) didClickOnHeroRecruit:(SPEvent *) event{
    NSLog(@"Clicked hero");
    
    NSArray *recruits = [NSArray arrayWithObjects:@"specialcharacter_01",@"specialcharacter_02",@"specialcharacter_03",@"specialcharacter_04",@"specialcharacter_05",@"specialcharacter_06",@"specialcharacter_07",@"specialcharacter_08",@"specialcharacter_09",@"specialcharacter_10",@"specialcharacter_11", nil];
    HeroMenu *heroMenu = [[HeroMenu alloc]initWithPossibleRecruits:recruits];
    [self showScene:heroMenu];
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
    [heroMenu setFourPlayerGame: _fourPlayerGame];
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
