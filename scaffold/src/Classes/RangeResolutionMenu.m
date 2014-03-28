//
//  RangeResolutionMenu.m
//  3004iPhone
//
//  Created by Richard Ison on 2014-03-27.
//
//

#import "RangeResolutionMenu.h"
#import "GameResource.h"
#import "GamePiece.h"
#import "InGameServerAccess.h"
#import "SpecialCharacter.h"
#import "Utils.h"
#import "YourPiecesMenu.h"
#import "EnemyPiecesMenu.h"

@implementation RangeResolutionMenu{
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
    
    SPImage *background = [[SPImage alloc] initWithContentsOfFile:@"RangeResolutionStepBackground@2x.png"];
    
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
        _selectedPieceImage.y = 90+(60*row);
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
    
    
    //Damage taken text
    SPTextField *damageTakenTF = [SPTextField textFieldWithWidth:300 height:120
                                                            text:@"Damage Taken: 0"];
    damageTakenTF.x = 10;
    damageTakenTF.y = 40;
    damageTakenTF.fontName = @"ArialMT";
    damageTakenTF.fontSize = 25;
    damageTakenTF.color = 0xffffff;
    [_contents addChild:damageTakenTF];
    
    
    //Damage Inflicted text
    SPTextField *damageInflictedTF = [SPTextField textFieldWithWidth:300 height:120
                                                                text:@"Damage Inflicted: 0"];
    damageInflictedTF.x = 10;
    damageInflictedTF.y = 70;
    damageInflictedTF.fontName = @"ArialMT";
    damageInflictedTF.fontSize = 25;
    damageInflictedTF.color = 0xffffff;
    [_contents addChild:damageInflictedTF];
    
    
    
    //Your pieces
    SPTexture *yoursButtonTexture = [SPTexture textureWithContentsOfFile:@"yourpieces.png"];
    SPButton *yoursButton = [SPButton buttonWithUpState:yoursButtonTexture];
    yoursButton.x = _gameWidth /2 - yoursButton.width/2 - 60;
    yoursButton.y = 420;
    yoursButton.scaleX = yoursButton.scaleY = 0.8;
    [_contents addChild:yoursButton];
    [yoursButton addEventListener:@selector(didClickOnYours:) atObject:self forType:SP_EVENT_TYPE_TRIGGERED];
    
    //enemy pieces
    SPTexture *enemyButtonTexture = [SPTexture textureWithContentsOfFile:@"enemypieces.png"];
    SPButton *enemyButton = [SPButton buttonWithUpState:enemyButtonTexture];
    enemyButton.x = _gameWidth /2 - enemyButton.width/2 + 100 ;
    enemyButton.y = 420;
    enemyButton.scaleX = enemyButton.scaleY = 0.8;
    [_contents addChild:enemyButton];
    [enemyButton addEventListener:@selector(didClickOnEnemy:) atObject:self forType:SP_EVENT_TYPE_TRIGGERED];
    
    
    
    //Done Button
    SPTexture *skipButtonTexture = [SPTexture textureWithContentsOfFile:@"done.png"];
    SPButton *skipButton = [SPButton buttonWithUpState:skipButtonTexture];
    skipButton.x = _gameWidth /2 - skipButton.width/2 + 20;
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
- (void) didClickOnSkip:(SPEvent *) event{
    NSLog(@"Clicked skip");
    _contents.visible = NO;
}

- (void) didClickOnYours:(SPEvent *) event{
    NSLog(@"Clicked show your pieces");
    
    [self showYourPiecesMenu];
}

- (void) didClickOnEnemy:(SPEvent *) event{
    NSLog(@"Clicked show enemy pieces");
    
    [self showEnemyPiecesMenu];
}
- (void)showYourPiecesMenu{
    YourPiecesMenu *yourpiece = [[YourPiecesMenu alloc]init];
    [self showScene:yourpiece];
}

- (void)showEnemyPiecesMenu{
    EnemyPiecesMenu *enemypiece = [[EnemyPiecesMenu alloc]init];
    [self showScene:enemypiece];
}
-(void) showScene:(SPSprite *)scene
{
    [self addChild:scene];
    scene.visible = YES;
    
}

@end
