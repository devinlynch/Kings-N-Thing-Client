//
//  CombatBattleStepResolutionMenu.m
//  3004iPhone
//
//  Created by Devin Lynch on 2014-04-04.
//
//

#import "CombatBattleStepResolutionMenu.h"
#import "GamePiece.h"
#import "GameResource.h"
#import "InGameServerAccess.h"
#import "CombatPhaseScreenController.h"

@implementation CombatBattleStepResolutionMenu
{
    CombatBattleRound *_round;
    NSMutableArray *_selectedPieces;
    NSMutableDictionary *_selectedBorders;
    int _damgeTaken;
    int _damageInflicted;
    BOOL isAllPiecesNeededToTakeDamage;
    
    SPButton *skipButton;
    SPTextField *waitingText;
}

-(id) init{
    self = [super init];
    if(self) {
        _selectedPieces = [[NSMutableArray alloc] init];
        _selectedBorders = [[NSMutableDictionary alloc] init];
        [self setup];
    }
    return self;
}

-(id) initWithRound:(CombatBattleRound *)round andController:(CombatPhaseScreenController *)contoller{
    self = [super initWithBattle:round.battle andController:contoller];
    if(self) {
        _round = round;
        _selectedPieces = [[NSMutableArray alloc] init];
        _selectedBorders = [[NSMutableDictionary alloc] init];
        [self setup];
    }
    return self;
}

-(void) setup {
    [super setup];
    
    BOOL amIAttacker = _round.battle.amIAttacker;
    CombatBattleRoundStepData *stepData;
    
    NSString *backgroundFileName;
    if(_round.state == MAGIC_STEP) {
        stepData = _round.magicData;
        backgroundFileName =@"MagicResolutionStepBackground@2x.png";
    } else  if(_round.state == RANGE_STEP) {
        stepData = _round.rangeData;
        backgroundFileName = @"RangeResolutionStepBackground@2x.png";
    } else if(_round.state == MELEE_STEP) {
        stepData = _round.meleeData;
        backgroundFileName = @"MeleeResolutionStepBackground@2x.png";
    } else{
        // TODO
        [NSException raise:@"In Step Screen with Wrong State" format:@"The state is %d", _round.state];
        return;
    }
    
    SPImage *background = [[SPImage alloc] initWithContentsOfFile:backgroundFileName];
    background.x = 0;
    background.y = 0;
    [_contents addChild:background];
    
     NSMutableDictionary *damageablePieces;
    if(amIAttacker){
        damageablePieces = stepData.attackerDamageablePieces;
        _damageInflicted = stepData.attackerHitCount;
        _damgeTaken= stepData.defenderHitCount;
    } else{
        damageablePieces = stepData.defenderDamageablePieces;
         _damageInflicted = stepData.defenderHitCount;
         _damgeTaken = stepData.attackerHitCount;
    }
    
    long numPieces = [damageablePieces count];
    
    
    isAllPiecesNeededToTakeDamage = (_damgeTaken > (int)numPieces);
    
    NSString *instructions;
    if(_damgeTaken > 0 && !isAllPiecesNeededToTakeDamage) {
        instructions= [NSString stringWithFormat:@"Please select %d pieces to take damage", _damageInflicted];
    } else if(isAllPiecesNeededToTakeDamage){
        instructions= [NSString stringWithFormat:@"All of your pieces took damage."];
    } else{
        instructions= [NSString stringWithFormat:@"You did not take any damage!"];
    }
    
    
    //Username text
    SPTextField *welcomeTF = [SPTextField textFieldWithWidth:300 height:120
                                                        text:instructions];
    welcomeTF.x = 10;
    welcomeTF.y = 55;
    welcomeTF.fontName = @"ArialMT";
    welcomeTF.fontSize = 15;
    welcomeTF.color = 0xffffff;
    [_contents addChild:welcomeTF];
    
    
    //Damage taken text
    SPTextField *damageTakenTF = [SPTextField textFieldWithWidth:300 height:120
                                                            text:[NSString stringWithFormat:@"Damage Taken: %d", _damgeTaken]];
    damageTakenTF.x = 10;
    damageTakenTF.y = 15;
    damageTakenTF.fontName = @"ArialMT";
    damageTakenTF.fontSize = 16;
    damageTakenTF.color = 0xffffff;
    [_contents addChild:damageTakenTF];
    
    
    //Damage Inflicted text
    SPTextField *damageInflictedTF = [SPTextField textFieldWithWidth:300 height:120
                                                                text:[NSString stringWithFormat:@"Damage Inflicted: %d", _damageInflicted]];
    damageInflictedTF.x = 10;
    damageInflictedTF.y = 35;
    damageInflictedTF.fontName = @"ArialMT";
    damageInflictedTF.fontSize = 16;
    damageInflictedTF.color = 0xffffff;
    [_contents addChild:damageInflictedTF];
    
    
    int numInRow=1;
    int row=1;
    NSEnumerator *enumerator = [damageablePieces keyEnumerator];
    NSString* recruitId;
    while ((recruitId = [enumerator nextObject])) {
        GamePiece *gp = [damageablePieces objectForKey:recruitId];
        SPButton *_selectedPieceImage;
        SPTexture *text = [SPTexture textureWithContentsOfFile:[gp fileName]];
        _selectedPieceImage = [SPButton buttonWithUpState:text];
        _selectedPieceImage.scaleX = 0.6;
        _selectedPieceImage.scaleY = 0.6;
        _selectedPieceImage.x = (_gameWidth/6)*numInRow-50;
        _selectedPieceImage.y = 120+(40*row);
        _selectedPieceImage.name =recruitId;
        
        if(!isAllPiecesNeededToTakeDamage)
            [_selectedPieceImage addEventListener:@selector(didClickOnRecruit:) atObject:self forType:SP_EVENT_TYPE_TRIGGERED];
        
        [_contents addChild:_selectedPieceImage];
        numInRow++;
        if(numInRow>7) {
            row++;
            numInRow=1;
        }
    }
    
    //Your pieces
    SPTexture *yoursButtonTexture = [SPTexture textureWithContentsOfFile:@"yourpieces.png"];
    SPButton *yoursButton = [SPButton buttonWithUpState:yoursButtonTexture];
    yoursButton.y = 435;
    yoursButton.scaleX = yoursButton.scaleY = 0.5;
    yoursButton.x = _gameWidth /2 - yoursButton.width*0.5 - 20;
    [_contents addChild:yoursButton];
    [yoursButton addEventListener:@selector(didClickOnYours:) atObject:self forType:SP_EVENT_TYPE_TRIGGERED];
    
    //enemy pieces
    SPTexture *enemyButtonTexture = [SPTexture textureWithContentsOfFile:@"enemypieces.png"];
    SPButton *enemyButton = [SPButton buttonWithUpState:enemyButtonTexture];
    enemyButton.y = 435;
    enemyButton.scaleX = enemyButton.scaleY = 0.5;
    enemyButton.x = _gameWidth /2 - (enemyButton.width/2*0.5) + 60 ;
    [_contents addChild:enemyButton];
    [enemyButton addEventListener:@selector(didClickOnEnemy:) atObject:self forType:SP_EVENT_TYPE_TRIGGERED];
    
    
    
    //Done Button
    SPTexture *skipButtonTexture = [SPTexture textureWithContentsOfFile:@"done.png"];
    skipButton = [SPButton buttonWithUpState:skipButtonTexture];
    skipButton.x = _gameWidth /2 - skipButton.width/2 + 20;
    skipButton.y = 480;
    skipButton.scaleX = skipButton.scaleY = 0.8;
    [_contents addChild:skipButton];
    [skipButton addEventListener:@selector(didClickOnSkip:) atObject:self forType:SP_EVENT_TYPE_TRIGGERED];
    

    waitingText = [SPTextField textFieldWithWidth:300 height:120
                                                        text:instructions];
    waitingText.x = 10;
    waitingText.y = 480;
    waitingText.fontName = @"ArialMT";
    waitingText.fontSize = 15;
    waitingText.color = 0xffffff;
    waitingText.touchable = NO;
    waitingText.visible = NO;
    [_contents addChild:waitingText];
}

-(void) didClickOnYours: (SPEvent*) event{
    [self showPiecesForBattleForMe];
}

-(void) didClickOnEnemy: (SPEvent*) event{
    [self showPiecesForOpposingPlayer];
}


-(void) didClickOnRecruit:(SPEvent *) event{
    SPImage *selectedPiece = (SPImage*)event.target;
    
    NSString *gamePieceId = selectedPiece.name;
    if(gamePieceId == nil)
        return;
    
    SPImage *borderImage = [_selectedBorders objectForKey:gamePieceId];
    
    if(borderImage == nil) {
        borderImage = [[SPImage alloc] initWithContentsOfFile:@"borderTile.png"];
        borderImage.x = selectedPiece.x;
        borderImage.y = selectedPiece.y;
        borderImage.scaleX=0.6;
        borderImage.scaleY=0.6;
        borderImage.touchable = NO;
        [_contents addChild:borderImage];
        [_selectedBorders setObject:borderImage forKey:gamePieceId];
        [_selectedPieces addObject:gamePieceId];
    } else {
        [borderImage removeFromParent];
        [_selectedBorders removeObjectForKey:gamePieceId];
        [_selectedPieces removeObject:gamePieceId];
    }
}

-(void) didClickOnSkip: (SPEvent*) event {
    if(!isAllPiecesNeededToTakeDamage && _damgeTaken > _selectedPieces.count) {
        [Utils showAlertWithTitle:@"Whoops" message:[NSString stringWithFormat: @"You need to select %d more pieces to take damage", (int)(_damgeTaken-_selectedPieces.count)] delegate:nil cancelButtonTitle:@"Ok"];
        return;
    }
    
    [self sendLockedInRollToServer];
}

-(void) sendLockedInRollToServer{
    [[InGameServerAccess instance] combatLockedInRollAndDamageWithPiecesTakingDamage:_selectedPieces forBattle:_battle.battleId andRound:_round.roundId andRoundState:_round.stateString withSuccess:^(ServerResponseMessage *msg) {
        [self showWaitingText];
    }];
}

-(void) showWaitingText{
    [skipButton removeFromParent];
    waitingText.visible = YES;
}

@end
