//
//  CombatBattleStepMenu.m
//  3004iPhone
//
//  Created by Devin Lynch on 2014-04-04.
//
//

#import "CombatBattleStepMenu.h"
#import "CombatBattleRoundStepData.h"
#import "GamePiece.h"
#import "GameResource.h"
#import "InGameServerAccess.h"

@implementation CombatBattleStepMenu{
    SPSprite *_rollNumberContents;
    SPButton * _rollButton;
    SPButton *skipButton;
}

-(id) init{
    self = [super init];
    if(self) {
        [self setup];
    }
    return self;
}

-(id) initWithRound:(CombatBattleRound *)round andController:(CombatPhaseScreenController *)contoller{
    self = [super initWithBattle:round.battle andController:contoller];
    if(self) {
        _round = round;
        [self setup];
    }
    return self;
}


-(void) setup{
    [super setup];
    
    [_contents removeAllChildren];
    _rollNumberContents = [SPSprite sprite];
    
    NSMutableDictionary *piecesToRolls;
    BOOL amIAttacker = _round.battle.amIAttacker;
    CombatBattleRoundStepData *stepData;
    
    NSString *backgroundFileName;
    if(_round.state == MAGIC_STEP) {
        stepData = _round.magicData;
        backgroundFileName =@"MagicStepBackground@2x.png";
    } else  if(_round.state == RANGE_STEP) {
        stepData = _round.rangeData;
        backgroundFileName = @"RangeStepBackground@2x.png";
    } else if(_round.state == MELEE_STEP) {
        stepData = _round.meleeData;
        backgroundFileName = @"MeleeStepBackground@2x.png";
    } else{
        // TODO
        [NSException raise:@"In Step Screen with Wrong State" format:@"The state is %d", _round.state];
        return;
    }
    
    SPImage *background = [[SPImage alloc] initWithContentsOfFile:backgroundFileName];
    background.x = 0;
    background.y = 0;
    [_contents addChild:background];

    if(amIAttacker){
        piecesToRolls = stepData.attackerGamePiecesToRolls;
    } else{
        piecesToRolls = stepData.attackerGamePiecesToRolls;
    }
    
    NSEnumerator *enumerator = [piecesToRolls keyEnumerator];
    NSString* gamePieceId;
    int numInRow=1;
    int row=1;
    int count = 0;
    while ((gamePieceId = [enumerator nextObject])) {
        NSNumber *rollNum = [piecesToRolls objectForKey:gamePieceId];
        GamePiece *gp = [[GameResource getInstance] getPieceForId:gamePieceId];
        if(gp == nil || rollNum == nil) {
            NSLog(@"Piece with id %@ is nil when iterating for some reason", gamePieceId);
            continue;
        }
        
        int roll = [rollNum intValue];
        
        SPButton *_selectedPieceImage;
        SPTexture *text = [SPTexture textureWithContentsOfFile:[gp fileName]];
        _selectedPieceImage = [SPButton buttonWithUpState:text];
        _selectedPieceImage.x = (_gameWidth/4)*numInRow-70;
        _selectedPieceImage.y = 40+(90*row);
        [_selectedPieceImage setName:gamePieceId];
        [_contents addChild:_selectedPieceImage];

        
        SPTextField *rolltext = [SPTextField textFieldWithWidth:_selectedPieceImage.width height:_selectedPieceImage.height
                                                            text:[NSString stringWithFormat:@"%d", roll]];
        rolltext.x = _selectedPieceImage.x;
        rolltext.y = _selectedPieceImage.y;
        rolltext.fontName = @"ArialMT";
        rolltext.fontSize = 25;
        rolltext.color = 0xffffff;
        [_rollNumberContents addChild:rolltext];
        
        numInRow++;
        if(numInRow>5) {
            row++;
            numInRow=1;
        }
        count++;
    }
    
    
    
    //Username text
    SPTextField *welcomeTF = [SPTextField textFieldWithWidth:300 height:120
                                                        text:@"Roll for your pieces"];
    welcomeTF.x = welcomeTF.y = 10;
    welcomeTF.fontName = @"ArialMT";
    welcomeTF.fontSize = 17;
    welcomeTF.color = 0xffffff;
    [_contents addChild:welcomeTF];
    
    
    
    //Roll Button
    SPTexture *rollButtonTexture = [SPTexture textureWithContentsOfFile:@"roll.png"];
    _rollButton = [SPButton buttonWithUpState:rollButtonTexture];
    _rollButton.x = _gameWidth /2 - _rollButton.width/2 + 20;
    _rollButton.y = 480;
    _rollButton.scaleX = _rollButton.scaleY = 0.8;
    [_contents addChild:_rollButton];
    [_rollButton addEventListener:@selector(didClickOnRoll:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    
    //Done Button
    SPTexture *skipButtonTexture = [SPTexture textureWithContentsOfFile:@"done.png"];
    skipButton = [SPButton buttonWithUpState:skipButtonTexture];
    skipButton.x = _gameWidth /2 - skipButton.width/2 + 20;
    skipButton.y = 480;
    skipButton.scaleX = skipButton.scaleY = 0.8;
    [_contents addChild:skipButton];
    skipButton.visible = NO;
    [skipButton addEventListener:@selector(didClickOnSkip:) atObject:self forType:SP_EVENT_TYPE_TRIGGERED];
    
    if(count == 0) {
        [self didClickOnRoll:nil];
        
        SPTextField *noPiecestext = [SPTextField textFieldWithWidth:300 height:120
                                                            text:@"You do not have any pieces that can fight for this step.  Please continue."];
        noPiecestext.x = 10;
        noPiecestext.y = 150;
        noPiecestext.fontName = @"ArialMT";
        noPiecestext.fontSize = 17;
        noPiecestext.color = 0xffffff;
        [_contents addChild:noPiecestext];
        
    }
}


-(void) didClickOnRoll:(SPEvent*) event {
    [_contents addChild: _rollNumberContents];
    _rollNumberContents.visible = YES;
    [_rollButton removeFromParent];
    _rollButton.visible = NO;
    skipButton.visible =YES;
    
}

-(void) didClickOnSkip:(SPEvent*) event {
    
}


@end
