//
//  RecruitCharactersEventHandler.m
//  3004iPhone
//
//  Created by Devin Lynch on 2014-03-25.
//
//

#import "RecruitCharactersEventHandler.h"
#import "Utils.h"
#import "Game.h"
#import "GameResource.h"

@implementation RecruitCharactersEventHandler

/*
 Type: didStartRecruitCharactersPhase
 Data: {
 }
 Sending Type: UDP from server to client
 Description: Tells everyone that recruit characters phase started
*/
-(void) handleDidStartRecruitCharactersPhase:(Event *)event{
    [Game addLogMessageToCurrentGame:@"Recruit Characters phase started"];
    NSLog(@"Succesfully parsed didStartRecruitCharactersPhase message");
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"didStartRecruitCharactersPhase" object:nil];
    });
}

/*
 Type: yourTurnToRecruitSpecialCharacter
 Data: {
 availableSpecialCharacters: Array of serialized special characters that are in the side location right now available to recruit.
 }
 Sending Type: UDP from server to client
 Description: Tells a specific person it is their turn to recruit a special character. A array of special charatcers that they are
 allowed to recruit is sent. They must pick one of these characters which they want to recruit.
 */
-(void) handleYourTurnInRecruitCharactersPhase:(Event *)event{
    [Game addLogMessageToCurrentGame:@"It is your turn in recruit characters."];
    NSDictionary* dataDic = [Utils getDataDictionaryFromGameMessageEvent:event];
    if(dataDic == nil){
        return;
    }
    
    int playerGold = [[dataDic objectForKey:@"playerGold"] intValue];
    Player *me = [[[Game currentGame] gameState] getMe];
    if(me != nil) {
        [me setGold:playerGold];
    }
    
    NSArray *possibleRecruitments = [dataDic objectForKey:@"availableSpecialCharacters"];
    NSMutableArray *posibleRecruitmentIds = [[NSMutableArray alloc] init];
    for(NSDictionary *recruit in possibleRecruitments) {
        [posibleRecruitmentIds addObject:[recruit objectForKey:@"id"]];
    }
    
    NSLog(@"Succesfully parsed yourTurnToRecruitSpecialCharacter message with possible recruit ids: %@", posibleRecruitmentIds);
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"yourTurnToRecruitSpecialCharacter" object:posibleRecruitmentIds];
    });
}

/*
 Type: didRollInRecruitCharactrs
 Data: {
 specialCharacter: Serialized special character that the player was rolling for
 didRecruit: Boolean representing if they recruited from their roll / pre roll purchases
 playerId: Id of the player who rolled
 numPreRolls: Number of pre roll purchases
 theRoll: The value of their roll
 isMe: boolean set to true ONLY if the message is being received by the player who actually rolled
 }
 Sending Type: UDP from server to client
 Description: Tells everyone, including the person who rolled, the outcome of the roll 
 */

-(void) handleDidRollInRecruitCharactrs:(Event *)event{
    NSLog(@"Handling didRollInRecruitCharactrs message");
    
    NSDictionary* dataDic = [Utils getDataDictionaryFromGameMessageEvent:event];
    if(dataDic == nil){
        return;
    }
    
    NSString *specialCharacterId = [[dataDic objectForKey:@"specialCharacter"] objectForKey:@"id"];
    NSString *playerId = [dataDic objectForKey:@"playerId"];
    BOOL didRecruit = [[dataDic objectForKey:@"didRecruit"] boolValue];
    int numPreRolls = [[dataDic objectForKey:@"numPreRolls"] intValue];
    int theRoll = [[dataDic objectForKey:@"theRoll"] intValue];
    
    
    Game *game = [Game currentGame];
    GameState* gameState = game.gameState;
    Player * player = [gameState getPlayerById:playerId];
    GamePiece *piece = [[GameResource getInstance] getPieceForId:specialCharacterId];
    
    if(! game && !player && !piece) {
        NSLog(@"Something wrong with didRollInRecruitCharactrs message");
        return;
    }
    
    NSString *didHeRecruit;
    if(didRecruit) {
        didHeRecruit = @"They recruited it";
    } else{
        didHeRecruit = @"They did not recruit it";
    }
    
    NSString *logMessage = [NSString stringWithFormat: @"%@ rolled a %d and bought %d pre roll changes in while trying to recruit a %@.  %@.", player.username, theRoll, numPreRolls, piece.name != nil ? piece.name : piece.gamePieceId, didHeRecruit];
    [game addLogMessageWithoutTalking:logMessage];
    
    BOOL isMe = [[dataDic objectForKey:@"isMe"] boolValue];
    if(!isMe) {
        NSLog(@"Got didRollInRecruitCharactrs message but its not me");
        return;
    }
    
    int playerGold = [[dataDic objectForKey:@"playerGold"] intValue];
    Player *me = [[[Game currentGame] gameState] getMe];
    if(me != nil) {
        [me setGold:playerGold];
    }
    
    NSLog(@"Succesfully handled didRollInRecruitCharactrs message");
    dispatch_async(dispatch_get_main_queue(), ^{
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setObject:[NSNumber numberWithBool:didRecruit] forKey:@"didRecruit"];
        [dic setObject:[NSNumber numberWithInt:theRoll] forKey:@"theRoll"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"didRollInRecruitCharactrs" object:dic];
    });
}

/*
 Type: roundOfRecruitCharactersOver
 Data: {
 specialCharacter: Serialized special character that the player was rolling for
 didRecruit: Boolean representing if they recruited from their roll / pre roll purchases
 playerId: Id of the player who rolled
 numPreRolls: Number of pre roll purchases
 theRoll: The value of their roll
 numPostRolls: Number of post roll purchases
 }
 Sending Type: UDP from server to client
 Description: Tells everyone, including the person who’s turn it was, that a specific players turn is over in the recruit characters phase.
 A summary of what happened int he phase is given.
 */

-(void) handleRoundOfRecruitCharactersOver:(Event *)event{
    NSLog(@"Handling roundOfRecruitCharactersOver message");
    
    NSDictionary* dataDic = [Utils getDataDictionaryFromGameMessageEvent:event];
    if(dataDic == nil){
        return;
    }
    
    NSString *specialCharacterId = [[dataDic objectForKey:@"specialCharacter"] objectForKey:@"id"];
    NSString *playerId = [dataDic objectForKey:@"playerId"];
    BOOL didRecruit = [[dataDic objectForKey:@"didRecruit"] boolValue];
    int numPostRolls = [[dataDic objectForKey:@"numPostRolls"] intValue];
    NSMutableDictionary* specialCharDic = [dataDic objectForKey:@"specialCharacter"];
    
    Game *game = [Game currentGame];
    GameState* gameState = game.gameState;
    Player * player = [gameState getPlayerById:playerId];
    GamePiece *piece = [[GameResource getInstance] getPieceForId:specialCharacterId];
    
    if(! game && !player && !piece) {
        NSLog(@"Something wrong with roundOfRecruitCharactersOver message");
        return;
    }
    
    NSString *didHeRecruit;
    if(didRecruit) {
        didHeRecruit = @"They recruited it";
    } else{
        didHeRecruit = @"They did not recruit it";
    }
    
    NSString *logMessage = [NSString stringWithFormat: @"%@ finished their turn of trying to recruit a %@.  %@.  They bought %d post rolls.", player.username, piece.name != nil ? piece.name : piece.gamePieceId, didHeRecruit, numPostRolls];
    [game addLogMessage:logMessage];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [piece updateFromSerializedJson:specialCharDic forGameState:gameState];
    });
    
    BOOL isMe = [[dataDic objectForKey:@"isMe"] boolValue];
    if(!isMe) {
        NSLog(@"Got roundOfRecruitCharactersOver message but its not me");
        return;
    }
    
    int playerGold = [[dataDic objectForKey:@"playerGold"] intValue];
    Player *me = [[[Game currentGame] gameState] getMe];
    if(me != nil) {
        [me setGold:playerGold];
    }
    
    NSLog(@"Succesfully handled roundOfRecruitCharactersOver message");
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"roundOfRecruitCharactersOver" object:[NSNumber numberWithBool:didRecruit]];
    });
}


@end
