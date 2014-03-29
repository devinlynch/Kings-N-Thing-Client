//
//  RecruitingHeroMenu.m
//  3004iPhone
//
//  Created by Devin Lynch on 2014-03-27.
//
//

#import "RecruitingHeroMenu.h"
#import "HeroMenu.h"
#import "GameResource.h"
#import "GamePiece.h"
#import "SpecialCharacter.h"
#import "Utils.h"
#import "Game.h"
#import "FourPlayerGame.h"

@implementation RecruitingHeroMenu{
    SPSprite *_contents;
    SPSprite *_postRollOption;
    SPSprite *_postRollInfo;


    SPSprite *_currentScene;
    
    int _gameWidth;
    int _gameHeight;
    
    SpecialCharacter *_recruit;
    
    SPButton *rollButton;
    InGameServerAccess *access;
    int theRoll;
    BOOL didRecruit;
    
    SPTextField *postRollsText;
    
    SPTextField *youRolledText;
    SPTextField *youRecruitedtext;
    
    FourPlayerGame *_fourPlayerGame;
    NSNotification *_notif;
}

-(id) init
{
    if ((self = [super init]))
    {
        [self setup];
    }
    
    return self;
}

-(id) initWithRecruitingCharacter: (SpecialCharacter*) character{
    self = [super init];
    _recruit = character;
    [self setup];
    return self;
}

-(void) setFourPlayerGame :(FourPlayerGame*) game{
    _fourPlayerGame = game;
}


-(void) setup{
    access = [[InGameServerAccess alloc] init];
    access.delegateListener = self;
    
    //[Utils showLoaderOnView:Sparrow.currentController.view animated:true];

    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didRollInRecruitCharactrs:)
                                                 name:@"didRollInRecruitCharactrs"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(roundOfRecruitCharactersOver:)
                                                 name:@"roundOfRecruitCharactersOver"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(startedRecruitThingsPhase:)
                                                 name:@"startedRecruitThingsPhase"
                                               object:nil];
    

    
    _gameWidth = Sparrow.stage.width;
    _gameHeight = Sparrow.stage.height;
    
    _contents = [SPSprite sprite];
    _postRollOption = [SPSprite sprite];
    _postRollInfo = [SPSprite sprite];
    [self addChild:_contents];
    
    SPImage *background = [[SPImage alloc] initWithContentsOfFile:@"heroBackground@2x.png"];
    
    //necessary or else it gets placed off screen
    background.x = 0;
    background.y = 0;
    
    [_contents addChild:background];
    
    
    
    SPButton *_selectedPieceImage;
    SPTexture *text = [SPTexture textureWithContentsOfFile:[_recruit fileName]];
    _selectedPieceImage = [SPButton buttonWithUpState:text];
    _selectedPieceImage.x = (_gameWidth/2)-(text.width/2);
    _selectedPieceImage.y = 100;
    [_contents addChild:_selectedPieceImage];

    
    
    //Username text
    SPTextField *welcomeTF = [SPTextField textFieldWithWidth:300 height:120
                                                        text:@"Recruit Characters"];
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
    SPTexture *rollButtonTexture = [SPTexture textureWithContentsOfFile:@"buy_1.png"];
    rollButton = [SPButton buttonWithUpState:rollButtonTexture];
    rollButton.x = (_gameWidth/2) - (rollButtonTexture.width/2);
    rollButton.y = _gameHeight - 100;
    rollButton.scaleX = rollButton.scaleY = 0.8;
    [_postRollOption addChild:rollButton];
    [rollButton addEventListener:@selector(didClickOnRoll:) atObject:self forType:SP_EVENT_TYPE_TRIGGERED];
    
    
    
    postRollsText = [SPTextField textFieldWithText:@""];
    postRollsText.x = (_gameWidth/2) - (postRollsText.width/2);
    postRollsText.y = _gameHeight - 90;
    postRollsText.fontName = @"ArialMT";
    postRollsText.fontSize = 10;
    postRollsText.color = 0xffffff;
    [_postRollOption addChild:postRollsText];
    
    
    
    
    youRolledText = [SPTextField textFieldWithWidth:_gameWidth-20 height:120
                                                        text:@"You rolled a 2"];
    youRolledText.x = 10;
    youRolledText.y = 150;
    youRolledText.fontName = @"ArialMT";
    youRolledText.fontSize = 16;
    youRolledText.color = 0xffffff;
    [_postRollInfo addChild:youRolledText];
    
    
    
    youRecruitedtext = [SPTextField textFieldWithWidth:_gameWidth-20 height:120
                                               text:@"Unfortunately you did not recruit."];
    youRecruitedtext.x = 10;
    youRecruitedtext.y = 180;
    youRecruitedtext.fontName = @"ArialMT";
    youRecruitedtext.fontSize = 12;
    youRecruitedtext.color = 0xffffff;
    [_postRollInfo addChild:youRecruitedtext];
    
    //youRecruitedtext
    
}

-(void) didClickOnRoll: (SPEvent*) event{
    int combatValue = _recruit.combatValue;
    
    int numPostRolls = combatValue*2 - theRoll;
    
    [self handlePostrollWithPostRollPurchases:numPostRolls];
}

-(void) didGetIngameResponseFromServerForRequest: (InGameRequestTypes) requestType andResponse: (ServerResponseMessage*) responseMessage{
    if(requestType == RECRUITCHARS_POSTROLL) {
        if(responseMessage == nil) {
            [Utils removeLoaderOnView: Sparrow.currentController.view animated:true];
            [Utils showAlertWithTitle:@"Whoops" message:@"There was a problem with that.  Please try again." delegate:nil cancelButtonTitle:@"Ok"];
        } else {
            
        }
    }
}

-(void) handlePostrollWithPostRollPurchases: (int) numPostRolls {
    [Utils showLoaderOnView:Sparrow.currentController.view animated:true];
    [access recruitCharactersPostRollWithNumPostRolls:numPostRolls withSuccess:nil];
}

-(void) didRollInRecruitCharactrs: (NSNotification*) notif {
    [Utils removeLoaderOnView:Sparrow.currentController.view animated:true];

    NSMutableDictionary *dic = notif.object;
    NSNumber *didRecruitNum = [dic objectForKey:@"didRecruit"];
    NSNumber *theRollNum = [dic objectForKey:@"theRoll"];
    
    theRoll = [theRollNum intValue];
    didRecruit = [didRecruitNum boolValue];
    [self updateText];
    
    if(!didRecruit) {
        [self handleRecruitOver];
        int combatValue = _recruit.combatValue;
        int numPostRolls = (combatValue*2) - theRoll;
        int goldToRecruit = numPostRolls * 10;
        int myGold = [[[[Game currentGame] gameState] getMe] gold];
        
        if(myGold < goldToRecruit){
            [self handlePostrollWithPostRollPurchases:0];
        } else{
            postRollsText.text = [NSString stringWithFormat:@"Pay %d gold to recruit the character", goldToRecruit];
            [self addChild:_postRollOption];
        }
    }
}

-(void) roundOfRecruitCharactersOver: (NSNotification*) notif {
    [Utils removeLoaderOnView:Sparrow.currentController.view animated:true];
    didRecruit = [notif.object boolValue];

    [self handleRecruitOver];
}

-(void) handleRecruitOver
{
    [self updateText];
    if(![self containsChild:_postRollInfo]) {
        [self addChild:_postRollInfo];
    }
    
    [self removeChild:_postRollOption];
}

-(void) updateText{
    if(didRecruit)
        youRecruitedtext.text = @"You recruited it!";
    else
        youRecruitedtext.text = @"Sorry, you did not recruit.";
    
    youRolledText.text = [NSString stringWithFormat:@"You rolled a %d", theRoll];
}

-(void) startedRecruitThingsPhase: (NSNotification*) notif{
    SPTexture *rollButtonTexture = [SPTexture textureWithContentsOfFile:@"continue.png"];
    rollButton = [SPButton buttonWithUpState:rollButtonTexture];
    rollButton.x = (_gameWidth/2) - (rollButtonTexture.width/2);
    rollButton.y = _gameHeight - 100;
    rollButton.scaleX = rollButton.scaleY = 0.8;
    [_contents addChild:rollButton];
    
    _notif = notif;
    
    [rollButton addEventListener:@selector(didClickContinue:) atObject:self forType:SP_EVENT_TYPE_TRIGGERED];
}


-(void) didClickContinue: (SPEvent*) event{
   // [_contents removeFromParent];
   // [_postRollOption removeFromParent];
   // [_postRollInfo removeFromParent];
    
    [_fourPlayerGame startedRecruitThingsPhase:_notif];
}

@end