//
//  RecruitCharacterOption.m
//  3004iPhone
//
//  Created by Richard Ison on 2014-03-16.
//
//

#import "HeroMenu.h"
#import "GameResource.h"
#import "GamePiece.h"
#import "SpecialCharacter.h"
#import "Utils.h"
#import "Game.h"
#import "GameState.h"
#import "RecruitingHeroMenu.h"

@implementation HeroMenu{
    SPSprite *_contents;
    SPSprite *_currentScene;
    
    int _gameWidth;
    int _gameHeight;
    
    NSMutableArray *_recruits;
    
    SPImage *borderImage;
    SpecialCharacter *selectedSpecialCharacter;
    UITextField *_chatTextField;
    UIButton *doneButton;
    SPButton *rollButton;
    InGameServerAccess *access;
    int numRolls;
    
    RecruitingHeroMenu *nextMenu;
    FourPlayerGame *_fourPlayerGame;
}

-(id) init
{
    if ((self = [super init]))
    {
        [self setup];
    }
    
    return self;
}

-(id) initWithPossibleRecruits: (NSArray*) recruits {
    self = [super init];
    _recruits = [NSMutableArray arrayWithArray:recruits];
    [self setup];
    return self;
}


-(void) setup{
    access = [[InGameServerAccess alloc] init];
    access.delegateListener = self;
    
    numRolls = 0;
    
    _gameWidth = Sparrow.stage.width;
    _gameHeight = Sparrow.stage.height;
    
    _contents = [SPSprite sprite];
    [self addChild:_contents];
    
    SPImage *background = [[SPImage alloc] initWithContentsOfFile:@"heroBackground@2x.png"];
    
    //necessary or else it gets placed off screen
    background.x = 0;
    background.y = 0;
    
    [_contents addChild:background];
    
    
    int numInRow=1;
    int row=1;
    for(NSString *recruitId in _recruits) {
        SpecialCharacter *gp = [[GameResource getInstance] getSpecialCharacterForId:recruitId];
        SPButton *_selectedPieceImage;
        SPTexture *text = [SPTexture textureWithContentsOfFile:[gp fileName]];
        _selectedPieceImage = [SPButton buttonWithUpState:text];
        _selectedPieceImage.x = (_gameWidth/4)*numInRow-70;
        _selectedPieceImage.y = 30+(65*row);
        [_selectedPieceImage setName:recruitId];
        
        [_selectedPieceImage addEventListener:@selector(didClickOnRecruit:) atObject:self forType:SP_EVENT_TYPE_TRIGGERED];
        
        [_contents addChild:_selectedPieceImage];
        numInRow++;
        if(numInRow>5) {
            row++;
            numInRow=1;
        }
    }
    
    
    //Username text
    SPTextField *welcomeTF = [SPTextField textFieldWithWidth:300 height:120
                                                        text:@"Recruit Characters"];
    welcomeTF.x = welcomeTF.y = 10;
    welcomeTF.fontName = @"ArialMT";
    welcomeTF.fontSize = 25;
    welcomeTF.color = 0xffffff;
    welcomeTF.touchable = NO;
    [_contents addChild:welcomeTF];
    
    //During the Recruiting Heroes Phase, choose one unowned face-up hero from
    //near the bank and roll two dice
    //
    //Double the character’s combat number and compare this number to your
    //die-roll. If you roll greater than or equal to the number, you gain the Hero.
    //Otherwise he remains unowned unless you spend gold.
  
    
    //Roll Button
    SPTexture *rollButtonTexture = [SPTexture textureWithContentsOfFile:@"rolldice.png"];
    rollButton = [SPButton buttonWithUpState:rollButtonTexture];
    rollButton.x = _gameWidth - (rollButtonTexture.width/2) - 50;
    rollButton.y = _gameHeight - 100;
    rollButton.scaleX = rollButton.scaleY = 0.8;
    [_contents addChild:rollButton];
    [rollButton addEventListener:@selector(didClickOnRoll:) atObject:self forType:SP_EVENT_TYPE_TRIGGERED];
    

    UIView *view = Sparrow.currentController.view;
    
    _chatTextField = [[UITextField alloc] initWithFrame:CGRectMake(15, _gameHeight - 70, 120, 30)];
    _chatTextField.borderStyle = UITextBorderStyleRoundedRect;
    _chatTextField.textColor = [UIColor blackColor];
    _chatTextField.font = [UIFont systemFontOfSize:17.0];
    _chatTextField.placeholder = @"# of pre rolls";
    _chatTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    _chatTextField.keyboardType = UIKeyboardTypeNumberPad;
    _chatTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _chatTextField.returnKeyType = UIReturnKeyDone;
    _chatTextField.enabled = NO;
    [view addSubview:_chatTextField];
    _chatTextField.delegate = self;
    [_chatTextField setText:[NSString stringWithFormat:@"%d", numRolls]];
    
    
    SPTexture *upButtonText = [SPTexture textureWithContentsOfFile:@"upArrow@2x.png"];
    SPButton *upButton = [SPButton buttonWithUpState:upButtonText];
    upButton.x = 140;
    upButton.y = _gameHeight - 75;
    upButton.scaleX = upButton.scaleY = 0.5;
    [_contents addChild:upButton];
    [upButton addEventListener:@selector(didClickUpBtn:) atObject:self forType:SP_EVENT_TYPE_TRIGGERED];
    
    SPTexture *downButtonText = [SPTexture textureWithContentsOfFile:@"downArrow@2x.png"];
    SPButton *downButton = [SPButton buttonWithUpState:downButtonText];
    downButton.x = 140;
    downButton.y = _gameHeight - 90 + upButton.height - 5;
    downButton.scaleX = downButton.scaleY = 0.5;
    [_contents addChild:downButton];
    [downButton addEventListener:@selector(didClickDownBtn:) atObject:self forType:SP_EVENT_TYPE_TRIGGERED];
    
    SPTextField *preRollsText = [SPTextField textFieldWithText:@"Number of pre roll purchases (5 gold each)"];
    preRollsText.x = 15;
    preRollsText.y = _gameHeight - 90;
    preRollsText.fontName = @"ArialMT";
    preRollsText.fontSize = 10;
    preRollsText.color = 0xffffff;
    [_contents addChild:preRollsText];
    
}

-(void) didClickOnRecruit:(SPEvent *) event{
    SPImage *selectedPiece = (SPImage*)event.target;
    
    if(borderImage != nil) {
        [borderImage removeFromParent];
    }
    
    selectedSpecialCharacter = [[GameResource getInstance] getSpecialCharacterForId:selectedPiece.name];
    if(selectedSpecialCharacter != nil) {
        borderImage = [[SPImage alloc] initWithContentsOfFile:@"borderTile.png"];
        borderImage.x = selectedPiece.x;
        borderImage.y = selectedPiece.y;
    }
    
    
    [_contents addChild:borderImage];
}


-(void) didClickUpBtn: (SPEvent*) event{
    numRolls++;
    
    Game *game = [Game currentGame];
    GameState *gs = [game gameState];
    Player *me = [gs getMe];
    int playerGold = me.gold;
    
    if((numRolls * 5) > playerGold) {
        [Utils showAlertWithTitle:@"Whoops" message:@"You do not have enough gold to do that" delegate:nil cancelButtonTitle:@"Ok"];
        numRolls--;
        return;
    }
    
    [_chatTextField setText:[NSString stringWithFormat:@"%d", numRolls]];
}

-(void) didClickDownBtn: (SPEvent*) event{
    numRolls--;
    [_chatTextField setText:[NSString stringWithFormat:@"%d", numRolls]];
}

-(void) didClickOnRoll: (SPEvent*) event{
    NSString* numPreRollsString = _chatTextField.text;
    int numPreRolls = 0;
    if(numPreRollsString != nil && [numPreRollsString length] != 0) {
        numPreRolls =  numPreRollsString.intValue;
    }
    
    if(selectedSpecialCharacter == nil) {
        [Utils showAlertWithTitle:@"Whoops" message:@"Please select a special charatcer you would like to recruit" delegate:nil cancelButtonTitle:@"Ok"];
        return;
    }
    
    nextMenu = [[RecruitingHeroMenu alloc] initWithRecruitingCharacter:selectedSpecialCharacter];
    [nextMenu setFourPlayerGame:_fourPlayerGame];

    [Utils showLoaderOnView:Sparrow.currentController.view animated:true];
    [access recruitCharactersMakeRoll:selectedSpecialCharacter.gamePieceId andNumPreRolls:numPreRolls withSuccess:nil];
}

-(void) didGetIngameResponseFromServerForRequest: (InGameRequestTypes) requestType andResponse: (ServerResponseMessage*) responseMessage{
    [Utils removeLoaderOnView: Sparrow.currentController.view animated:true];
    if(requestType == RECRUITCHARS_MAKEROLLFORPLAYER) {
        if(responseMessage == nil) {
            [Utils showAlertWithTitle:@"Whoops" message:@"There was a problem with that.  Please try again." delegate:nil cancelButtonTitle:@"Ok"];
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [_chatTextField setHidden:YES];
                [self showScene:nextMenu];
            });
        }
        
    }
}

-(void) showScene:(SPSprite *)scene
{
    [_contents removeFromParent];
    [self addChild:scene];
    scene.visible = YES;
    
}

-(void) setFourPlayerGame :(FourPlayerGame*) game{
    _fourPlayerGame = game;
}

@end
