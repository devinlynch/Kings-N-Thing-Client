//
//  MeleeStepMenu.m
//  3004iPhone
//
//  Created by Richard Ison on 2014-03-27.
//
//

#import "MeleeStepMenu.h"
#import "GameResource.h"
#import "GamePiece.h"
#import "InGameServerAccess.h"
#import "SpecialCharacter.h"
#import "Utils.h"

@implementation MeleeStepMenu{
    SPSprite *_contents;
    SPSprite *_currentScene;
    
    NSMutableArray *_magicCreatures;
    SpecialCharacter *selectedSpecialCharacter;
    SPImage *borderImage;
    
    
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
    
    SPImage *background = [[SPImage alloc] initWithContentsOfFile:@"MeleeStepBackground@2x.png"];
    
    //necessary or else it gets placed off screen
    background.x = 0;
    background.y = 0;
    
    [_contents addChild:background];
    
    NSArray *recruits = [NSArray arrayWithObjects:@"specialcharacter_01",@"specialcharacter_02",@"specialcharacter_03",@"specialcharacter_04",@"specialcharacter_05",@"specialcharacter_06",@"specialcharacter_07",@"specialcharacter_08",@"specialcharacter_09",@"specialcharacter_10",@"specialcharacter_11", nil];
    
    _magicCreatures = [NSMutableArray arrayWithArray:recruits];
    
    
    
    int numInRow=1;
    int row=1;
    for(NSString *recruitId in _magicCreatures) {
        SpecialCharacter *gp = [[GameResource getInstance] getSpecialCharacterForId:recruitId];
        SPButton *_selectedPieceImage;
        SPTexture *text = [SPTexture textureWithContentsOfFile:[gp fileName]];
        _selectedPieceImage = [SPButton buttonWithUpState:text];
        _selectedPieceImage.x = (_gameWidth/4)*numInRow-70;
        _selectedPieceImage.y = 40+(90*row);
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
                                                        text:@"Username"];
    welcomeTF.x = welcomeTF.y = 10;
    welcomeTF.fontName = @"ArialMT";
    welcomeTF.fontSize = 25;
    welcomeTF.color = 0xffffff;
    [_contents addChild:welcomeTF];
    
    
    
    //Roll Button
    SPTexture *rollButtonTexture = [SPTexture textureWithContentsOfFile:@"roll.png"];
    SPButton *rollButton = [SPButton buttonWithUpState:rollButtonTexture];
    rollButton.x = _gameWidth /2 - rollButton.width/2 + 20;
    rollButton.y = 400;
    rollButton.scaleX = rollButton.scaleY = 0.8;
    [_contents addChild:rollButton];
    [rollButton addEventListener:@selector(didClickOnRoll:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    
    //Done Button
    SPTexture *skipButtonTexture = [SPTexture textureWithContentsOfFile:@"done.png"];
    SPButton *skipButton = [SPButton buttonWithUpState:skipButtonTexture];
    skipButton.x = _gameWidth /2 - rollButton.width/2 + 20;
    skipButton.y = 480;
    skipButton.scaleX = skipButton.scaleY = 0.8;
    [_contents addChild:skipButton];
    [skipButton addEventListener:@selector(didClickOnSkip:) atObject:self forType:SP_EVENT_TYPE_TRIGGERED];
}

-(void) didClickOnPlay:(SPTouchEvent*) event{
    NSArray *touches = [[event touchesWithTarget:self andPhase:SPTouchPhaseBegan] allObjects];
    
    
    if (touches.count == 1) {
        
        // Find card id, show pop up of description
        
        
    } else if (touches.count == 2){
        
        //Selects the card
        
        
    }
    
    
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

- (void) didClickOnRoll:(SPEvent *) event{
    NSLog(@"Clicked roll");
    //TODO: animate the dice roll and display what value the piece got
    
    
}

- (void) didClickOnSkip:(SPEvent *) event{
    NSLog(@"Clicked skip");
    _contents.visible = NO;
}


@end
