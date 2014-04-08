//
//  GameEventHandler.m
//  3004iPhone
//
//  Created by Devin Lynch on 2014-01-26.
//
//

#import "GameEventHandler.h"
#import "Event.h"
#import "Game.h"
#import "Utils.h"
#import "GameResource.h"

@implementation GameEventHandler

-(void) handleEvent:(Event *)event{
    NSString *type = event.type;
    if(type != nil) {
        if([type isEqualToString:@"gameStarted"]) {
            [self handleGameStarted:event];
        }
    }
}

-(void) handleGameStarted: (Event*) event{
    Message *message = event.msg;
    NSLog(@"Got game started message");
    if(message == nil || message.data == nil || message.data.map == nil){
        NSLog(@"For some reason the game was not provided in the data for a GameStarted message.  WHY?????");
        return;
    }
    
    Game* game;
    NSDictionary* gameDic= [message.data.map objectForKey:@"game"];
    @try{
        game = [[Game alloc] initFromJSON:gameDic];
        [Game setInstance:game];
    } @catch (NSException *e) {
        NSLog(@"%@",e);
    }
    
    if(game == nil) {
        NSLog(@"Got gameStarted message but for some reason game could not be parsed");
        return;
    }
    
    [Game addLogMessageToCurrentGame:@"Welcome!  The game has started."];
    
    NSLog(@"Successfully parsed game from gameStarted message, now sending notification");
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"gameStarted" object:game];
    });
}

-(void) handleUpdatedGamePiece:(Event*) event {
    NSDictionary* dataDic = [Utils getDataDictionaryFromGameMessageEvent:event];
    GameState *state = [[Game currentGame] gameState];
    
    NSDictionary* pieceDataDic = [dataDic objectForKey:@"gamePiece"];
    NSString *gamePieceId = [pieceDataDic objectForKey:@"id"];
    
    if(gamePieceId != nil) {
        dispatch_async(dispatch_get_main_queue(), ^{
            GamePiece *piece = [[GameResource getInstance] getPieceForId:gamePieceId];
            [piece updateFromSerializedJson:pieceDataDic forGameState:state];
    
        });
    }
}

@end
