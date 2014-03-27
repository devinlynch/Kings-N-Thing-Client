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
#import "InGameServerAccess.h"
#import "SpecialCharacter.h"
#import "Utils.h"

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
    
    _chatTextField = [[UITextField alloc] initWithFrame:CGRectMake(15, _gameHeight - 70, 150, 30)];
    _chatTextField.borderStyle = UITextBorderStyleRoundedRect;
    _chatTextField.textColor = [UIColor blackColor];
    _chatTextField.font = [UIFont systemFontOfSize:17.0];
    _chatTextField.placeholder = @"# of pre rolls";
    _chatTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    _chatTextField.keyboardType = UIKeyboardTypeNumberPad;
    _chatTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _chatTextField.returnKeyType = UIReturnKeyDone;
    [view addSubview:_chatTextField];
    _chatTextField.delegate = self;
    
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

-(void) textFieldDidBeginEditing:(UITextField *)textField {
    [_chatTextField setFrame:CGRectMake(15, 300, 150, 30)];
    rollButton.y=270;
}

-(void) textFieldDidEndEditing:(UITextField *)textField{
    [_chatTextField setFrame:CGRectMake(15, _gameHeight - 100, 150, 30)];
    rollButton.y=_gameHeight - 100;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];

    return YES;
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
    
    
    [[InGameServerAccess instance] recruitCharactersMakeRoll:selectedSpecialCharacter.gamePieceId andNumPreRolls:numPreRolls withSuccess:nil];
}


@end
