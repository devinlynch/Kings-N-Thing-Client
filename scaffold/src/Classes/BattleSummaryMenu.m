//
//  BattleSummaryMenu.m
//  3004iPhone
//
//  Created by Richard Ison on 2014-03-27.
//
//

#import "BattleSummaryMenu.h"
#import "GameResource.h"
#import "GamePiece.h"
#import "InGameServerAccess.h"
#import "SpecialCharacter.h"
#import "Utils.h"
#import "PiecesMenu.h"
#import "EnemyPiecesMenu.h"
#import "Player.h"
#import "HexLocation.h"
#import "InGameServerAccess.h"
#import "CombatPhaseScreenController.h"

@implementation BattleSummaryMenu{

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
    
    SPImage *background = [[SPImage alloc] initWithContentsOfFile:@"BattleSummaryBackground@2x.png"];
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
    defenderTF.y = 20;
    defenderTF.fontName = @"ArialMT";
    defenderTF.fontSize = 20;
    defenderTF.color = 0x000000;
    [_contents addChild:defenderTF];
    
    // Attacker
    SPTextField *attackerTF = [SPTextField textFieldWithWidth:300 height:120
                                                         text:[NSString stringWithFormat: @"Attacker: %@", attackerUserName]];
    attackerTF.x = 10;
    attackerTF.y = 45;
    attackerTF.fontName = @"ArialMT";
    attackerTF.fontSize = 20;
    attackerTF.color = 0x000000;
    [_contents addChild:attackerTF];
    
    // Attacker
    SPTextField *locationTF = [SPTextField textFieldWithWidth:300 height:120
                                                         text:[NSString stringWithFormat: @"Location: %@", locationName]];
    locationTF.x = 10;
    locationTF.y = 70;
    locationTF.fontName = @"ArialMT";
    locationTF.fontSize = 20;
    locationTF.color = 0x000000;
    [_contents addChild:locationTF];

    //Your pieces
    SPTexture *yoursButtonTexture = [SPTexture textureWithContentsOfFile:@"yourpieces.png"];
    SPButton *yoursButton = [SPButton buttonWithUpState:yoursButtonTexture];
    yoursButton.x = _gameWidth /2 - yoursButton.width/2 + 50;
    yoursButton.y = 150;
    yoursButton.scaleX = yoursButton.scaleY = 0.5;
    [_contents addChild:yoursButton];
    [yoursButton addEventListener:@selector(didClickOnYours:) atObject:self forType:SP_EVENT_TYPE_TRIGGERED];
    
    //enemy pieces
    SPTexture *enemyButtonTexture = [SPTexture textureWithContentsOfFile:@"enemypieces.png"];
    SPButton *enemyButton = [SPButton buttonWithUpState:enemyButtonTexture];
    enemyButton.x = _gameWidth /2 - enemyButton.width/2 + 50 ;
    enemyButton.y = 190;
    enemyButton.scaleX = enemyButton.scaleY = 0.5;
    [_contents addChild:enemyButton];
    [enemyButton addEventListener:@selector(didClickOnEnemy:) atObject:self forType:SP_EVENT_TYPE_TRIGGERED];
    
    
    
    NSString *result;
    
    BOOL isOver = NO;
    
    if(_battle.state == ATTACKER_WON || _battle.state == DEFENDER_WON) {
        Player *winner;
        Player *loser;
        if(_battle.state == ATTACKER_WON) {
            winner = _battle.attacker;
            loser = _battle.defender;
        } else{
            loser = _battle.attacker;
            winner = _battle.defender;
        }
        
        result = [NSString stringWithFormat:@"The battle has ended.  The winner is %@.  Use the buttons above to see the result of the battle.", winner.user.username];
        isOver = YES;
    } else if(_battle.state == ATTACKER_RETREATED || _battle.state == DEFENDER_REREATED) {
        Player *retreater;
        Player *winner;
        if(_battle.state == ATTACKER_RETREATED) {
            retreater = _battle.attacker;
            winner = _battle.defender;
        } else{
            winner = _battle.attacker;
            retreater = _battle.defender;
        }
        
        result = [NSString stringWithFormat:@"The battle has ended.  %@ retreated so %@ has won!.  Use the buttons above to see the result of the battle.", retreater.user.username, winner.user.username];
        isOver = YES;
    } else{
        result = [NSString stringWithFormat:@"The round is over, but there is still more fighting to do.  Would you like to continue or retreat?"];
    }
    
    
    SPTextField *resultText = [SPTextField textFieldWithWidth:300 height:120
                                                       text:result];
    resultText.x = 10;
    resultText.y = 230;
    resultText.fontName = @"ArialMT";
    resultText.fontSize = 14;
    resultText.color = 0x000000;
    resultText.touchable = NO;
    [_contents addChild:resultText];
    
    if(! isOver ) {
        //Retreat Button
        SPTexture *retreatButtonTexture = [SPTexture textureWithContentsOfFile:@"retreat.png"];
        SPButton *retreatButton = [SPButton buttonWithUpState:retreatButtonTexture];
        retreatButton.x = _gameWidth /2 - retreatButton.width/2 + 20;
        retreatButton.y = 420;
        retreatButton.scaleX = retreatButton.scaleY = 0.8;
        [_contents addChild:retreatButton];
        [retreatButton addEventListener:@selector(didClickOnRetreat:) atObject:self forType:SP_EVENT_TYPE_TRIGGERED];
        
        
        //Done Button
        SPTexture *skipButtonTexture = [SPTexture textureWithContentsOfFile:@"keepfighting.png"];
        SPButton *skipButton = [SPButton buttonWithUpState:skipButtonTexture];
        skipButton.x = _gameWidth /2 - skipButton.width/2 + 20;
        skipButton.y = 480;
        skipButton.scaleX = skipButton.scaleY = 0.8;
        [_contents addChild:skipButton];
        [skipButton addEventListener:@selector(didClickOnKeepGoing:) atObject:self forType:SP_EVENT_TYPE_TRIGGERED];
        
        //Action text
        SPTextField *actionTF = [SPTextField textFieldWithWidth:300 height:120
                                                           text:@"Your action"];
        actionTF.x = 10;
        actionTF.y = 350;
        actionTF.fontName = @"ArialMT";
        actionTF.fontSize = 25;
        actionTF.color = 0x000000;
        actionTF.touchable = NO;
        [_contents addChild:actionTF];
    } else {
        //Done Button
        SPTexture *skipButtonTexture = [SPTexture textureWithContentsOfFile:@"done.png"];
        SPButton *skipButton = [SPButton buttonWithUpState:skipButtonTexture];
        skipButton.x = _gameWidth /2 - skipButton.width/2 + 20;
        skipButton.y = 480;
        skipButton.scaleX = skipButton.scaleY = 0.8;
        [_contents addChild:skipButton];
        [skipButton addEventListener:@selector(didClickOnDone:) atObject:self forType:SP_EVENT_TYPE_TRIGGERED];
    }
    
}


- (void) didClickOnDone:(SPEvent *) event{
    [_combatController showWaitingScreen];
}

- (void) didClickOnRetreat:(SPEvent *) event{
    NSLog(@"Clicked skip");
    [[InGameServerAccess instance] combatDidRetreatOrContinue:YES forBattle:_battle.battleId andRound:_battle.currentRound.roundId withSuccess:^(ServerResponseMessage* message){
        
    }];
}

- (void) didClickOnYours:(SPEvent *) event{
    [self showPiecesForBattleForMe];
}

- (void) didClickOnEnemy:(SPEvent *) event{
    [self showPiecesForOpposingPlayer];
}


- (void) didClickOnKeepGoing:(SPEvent *) event{
    [[InGameServerAccess instance] combatDidRetreatOrContinue:NO forBattle:_battle.battleId andRound:_battle.currentRound.roundId withSuccess:^(ServerResponseMessage* message){
        
    }];
}



@end
