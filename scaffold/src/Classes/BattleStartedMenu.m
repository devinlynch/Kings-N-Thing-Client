//
//  BattleStartedMenu.m
//  3004iPhone
//
//  Created by Devin Lynch on 2014-04-04.
//
//

#import "BattleStartedMenu.h"
#import "CombatPhaseScreenController.h"
#import "Player.h"
#import "HexLocation.h"

@implementation BattleStartedMenu{
    SPButton *_playBattleButton;
}

-(id) init{
    self = [super init];
    if(self) {
        [self setup];
    }
    return self;
}

-(id) initWithBattle:(CombatBattle *)battle andController:(CombatPhaseScreenController *)contoller{
    self = [super initWithBattle:battle andController:contoller];
    if(self) {
        [self setup];
    }
    return self;
}

-(void) setup{
    [super setup];
    
    
    SPImage *background = [[SPImage alloc] initWithContentsOfFile:@"ConbatBattleBackground@2x.png"];
    background.x = 0;
    background.y = 0;
    [_contents addChild:background];
    
    
    NSString *attackerUserName = _battle.attacker.user.username;
    NSString *defenderUserName = _battle.defender.user.username;
    NSString *locationName = _battle.locationOfBattle.locationName;

    // Defender
    SPTextField *defenderTF = [SPTextField textFieldWithWidth:300 height:120
                                                      text:[NSString stringWithFormat: @"Defender: %@", defenderUserName]];
    defenderTF.x = 10;
    defenderTF.y = 40;
    defenderTF.fontName = @"ArialMT";
    defenderTF.fontSize = 20;
    defenderTF.color = 0x000000;
    [_contents addChild:defenderTF];
    
    // Attacker
    SPTextField *attackerTF = [SPTextField textFieldWithWidth:300 height:120
                                                        text:[NSString stringWithFormat: @"Attacker: %@", attackerUserName]];
    attackerTF.x = 10;
    attackerTF.y = 65;
    attackerTF.fontName = @"ArialMT";
    attackerTF.fontSize = 20;
    attackerTF.color = 0x000000;
    [_contents addChild:attackerTF];
    
    // Attacker
    SPTextField *locationTF = [SPTextField textFieldWithWidth:300 height:120
                                                         text:[NSString stringWithFormat: @"Location: %@", locationName]];
    locationTF.x = 10;
    locationTF.y = 90;
    locationTF.fontName = @"ArialMT";
    locationTF.fontSize = 20;
    locationTF.color = 0x000000;
    [_contents addChild:locationTF];
    

    //Your pieces
    SPTexture *yoursButtonTexture = [SPTexture textureWithContentsOfFile:@"yourpieces.png"];
    SPButton *yoursButton = [SPButton buttonWithUpState:yoursButtonTexture];
    yoursButton.x = _gameWidth /2 - yoursButton.width/2 + 20;
    yoursButton.y = 170;
    yoursButton.scaleX = yoursButton.scaleY = 0.8;
    [_contents addChild:yoursButton];
    [yoursButton addEventListener:@selector(didClickOnYourpieces:) atObject:self forType:SP_EVENT_TYPE_TRIGGERED];
    
    //enemy pieces
    SPTexture *enemyButtonTexture = [SPTexture textureWithContentsOfFile:@"enemypieces.png"];
    SPButton *enemyButton = [SPButton buttonWithUpState:enemyButtonTexture];
    enemyButton.x = _gameWidth /2 - enemyButton.width/2 + 20 ;
    enemyButton.y = 240;
    enemyButton.scaleX = enemyButton.scaleY = 0.8;
    [_contents addChild:enemyButton];
    [enemyButton addEventListener:@selector(didClickOnEnemyPieces:) atObject:self forType:SP_EVENT_TYPE_TRIGGERED];
    

    
    
    //Done Button
    SPTexture *skipButtonTexture = [SPTexture textureWithContentsOfFile:@"play.png"];
    _playBattleButton = [SPButton buttonWithUpState:skipButtonTexture];
    _playBattleButton.x = _gameWidth /2 - _playBattleButton.width/2 + 20;
    _playBattleButton.y = 480;
    _playBattleButton.scaleX = _playBattleButton.scaleY = 0.8;
    [_contents addChild:_playBattleButton];
    [_playBattleButton addEventListener:@selector(didClickPlay:) atObject:self forType:SP_EVENT_TYPE_TRIGGERED];
}


-(void) didClickPlay:(SPEvent *) event{
    CombatBattleRound *round = _battle.currentRound;
    
    if(round == nil || round.state == NOT_STARTED) {
        [Utils showAlertWithTitle:@"Whoops" message:@"Round not started yet, please wait." delegate:nil cancelButtonTitle:@"Ok"];
        return;
    }
    
    [_combatController readyForBattleToStart];
}


-(void) didClickOnYourpieces:(SPEvent *) event{
    [self showPiecesForBattleForMe];
}

-(void) didClickOnEnemyPieces:(SPEvent *) event{
    [self showPiecesForOpposingPlayer];
}


@end
