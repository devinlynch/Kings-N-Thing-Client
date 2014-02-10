//
//  MovementPhaseHandler.m
//  3004iPhone
//
//  Created by Devin Lynch on 2014-02-09.
//
//

#import "MovementPhaseHandler.h"
#import "Event.h"
#import "Utils.h"
#import "GameState.h"
#import "Game.h"
#import "Stack.h"
#import "GameResource.h"
#import "GamePiece.h"

@implementation MovementPhaseHandler


/*
 Type: yourTurnToMoveInMovement
 Data: {
 }
 Sending Type: UDP from server to client
 Description: Tells the client its their turn to make a move in movement phase
 */
-(void) handleYourTurnToMoveInMovement: (Event*) event{
    NSLog(@"Succesfully handled yourTurnToMoveInMovement message");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"yourTurnToMoveInMovement" object:nil];
}


/*
 Type: playerMovedStackToNewLocation
 Data: {
 playerId: id of player who made move
 hexLocationId: id of hex where stack was moved to
 stack: serialized stack object that was moved
 }
 Sending Type: UDP from server to client
 Description: Tells all players that a player moved a stsack somewhere
*/
-(void) handlePlayerMovedStackToNewLocation:(Event *)event{
    [self handleUpdatedStackFromEvent:event];
}

/**
 Type: playerCreatedStack
 Data: {
 playerId: id of player who created the stack
 stack: serialized stack object that was created
 }
 Sending Type: UDP from server to client
 Description: Tells all players that a player created a stack that should now be on a hex location
 */

-(void) handlePlayerCreatedStack:(Event *)event{
    [self handleUpdatedStackFromEvent:event];
}


/*
 Type: playerAddedPiecesToStack
 Data: {
 playerId: id of player who added pieces to the stack
 stack: serialized stack object that updated
 }
 Sending Type: UDP from server to client
 Description: Tells all players that a player updated the pieces in a stack
 */

-(void) handlePlayerAddedPiecesToStack:(Event *)event{
    [self handleUpdatedStackFromEvent: event];
}


// Used by the stack update events
-(void) handleUpdatedStackFromEvent: (Event*) event {
    NSDictionary* dataDic = [Utils getDataDictionaryFromGameMessageEvent:event];
    if(dataDic == nil){
        return;
    }
    
    NSString *playerId = [dataDic objectForKey:@"playerId"];
    NSDictionary *stackDic = [dataDic objectForKey:@"stack"];
    NSString *hexLocationId = [stackDic objectForKey:@"hexLocationId"];
    NSString *stackId = [stackDic objectForKey:@"locationId"];
    
    GameState *gameState = [[Game currentGame] gameState];
    
    Stack *stack = [gameState getStackById: stackId];
    if(stack == nil || [stack isKindOfClass:[NSNull class]]) {
        stack = [[Stack alloc] initFromJSON:stackDic];
        Player *p = [gameState getPlayerById:playerId];
        [stack setOwner:p];
    }
    
    HexLocation *hexLocation = (HexLocation*)[gameState getBoardLocationById:hexLocationId];
    [stack setLocation:hexLocation];
    
    
    NSLog(@"Succesfully parsed updated stack message with stackID: %@", stack.locationId);
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"playerUpdatedStack" object:stack];
}


/*
 Type: playerMovedPieceToNewLocation
 Data: {
 playerId: id of player who moved the piece
 boardLocationId: id of the board location that the piece is being moved to
 gamePieceId: if of the game piece being moved
 }
 Sending Type: UDP from server to client
 Description: Tells all players that a player moved a game piece
 */

-(void) handlePlayerMovedPieceToNewLocation: (Event*) event {
    NSDictionary* dataDic = [Utils getDataDictionaryFromGameMessageEvent:event];
    if(dataDic == nil){
        return;
    }
    
    NSString *playerId = [dataDic objectForKey:@"playerId"];
    NSString *boardLocationId = [dataDic objectForKey:@"boardLocationId"];
    NSString *gamePieceId = [dataDic objectForKey:@"gamePieceId"];
    
    GameState *gameState = [[Game currentGame] gameState];
    
    Player *player = [gameState getPlayerById:playerId];
    BoardLocation *boardLocation = [gameState getBoardLocationById:boardLocationId];
    GamePiece *gamePiece = [[GameResource getInstance] getPieceForId:gamePieceId];
    
    
    if(player == nil || [player isKindOfClass:[NSNull class]]
       || boardLocation == nil || [boardLocation isKindOfClass:[NSNull class]]
       || gamePiece == nil || [gamePiece isKindOfClass:[NSNull class]]) {
        NSLog(@"Could not find player or boardlocation or gamepiece in handlePlayerMovedPieceToNewLocation.  The params where: %@", dataDic);
        return;
    }
    
    [boardLocation addGamePieceToLocation:gamePiece];

    
    NSLog(@"Succesfully parsed playerMovedPieceToNewLocation with gamepieceid: %@ and locationid: %@", gamePiece.gamePieceId, gamePiece.location.locationId);
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"playerMovedPieceToNewLocation" object:gamePiece];
}


@end
