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
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [Game addLogMessageToCurrentGame:[NSString stringWithFormat:@"It's your turn in movement."]];

        [[NSNotificationCenter defaultCenter] postNotificationName:@"yourTurnToMoveInMovement" object:nil];
    });
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
    HexLocation *hexLocation = (HexLocation*)[gameState getBoardLocationById:hexLocationId];
    Player *p = [gameState getPlayerById:playerId];
    
    if(hexLocation == nil || p == nil) {
        NSLog(@"Hex locaiton was null in handleUpdatedStackFromEvent");
        return;
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        Stack *stack = [gameState getStackById: stackId];
        if(stack == nil || [stack isKindOfClass:[NSNull class]]) {
            stack = [[Stack alloc] initFromJSON:stackDic];
            if ([playerId isEqualToString:@"player1"]) {
                stack.stackImage = [[ScaledGamePiece alloc] initWithContentsOfFile:@"red-stack.png"];
            } else if ([playerId isEqualToString:@"player2"]) {
                stack.stackImage = [[ScaledGamePiece alloc] initWithContentsOfFile:@"yellow-stack.png"];
            } else if ([playerId isEqualToString:@"player3"]) {
                stack.stackImage = [[ScaledGamePiece alloc] initWithContentsOfFile:@"green-stack.png"];
            } else if ([playerId isEqualToString:@"player4"]) {
                stack.stackImage = [[ScaledGamePiece alloc] initWithContentsOfFile:@"blue-stack.png"];
            }
            [stack.stackImage setOwner:(id<NSCopying>)stack];
            [Game addLogMessageToCurrentGame:[NSString stringWithFormat:@"%@ created a stack and moved it to %@", p.username, hexLocation.locationName]];
        } else {
            [Game addLogMessageToCurrentGame:[NSString stringWithFormat:@"%@ moved a stack to %@", p.username, hexLocation.locationName]];
            [stack updateLocationFromSerializedJSONDictionary:stackDic];
        }
        
        [stack setOwner:p];
        [hexLocation addStack:stack];
        
        NSLog(@"Succesfully parsed updated stack message with stackID: %@", stack.locationId);
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"playerUpdatedStack" object:stack];
    });
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
    HexLocation *boardLocation = [gameState.hexLocations objectForKey:boardLocationId];
    GamePiece *gamePiece = [[GameResource getInstance] getPieceForId:gamePieceId];
    
    
    if(player == nil || [player isKindOfClass:[NSNull class]]
       || boardLocation == nil || [boardLocation isKindOfClass:[NSNull class]]
       || gamePiece == nil || [gamePiece isKindOfClass:[NSNull class]]) {
        NSLog(@"Could not find player or boardlocation or gamepiece in handlePlayerMovedPieceToNewLocation.  The params where: %@", dataDic);
        return;
    }
    
    [Game addLogMessageToCurrentGame:[NSString stringWithFormat:@"%@ moved a %@ to %@", player.username, gamePiece.name != nil ? gamePiece.name : gamePiece.gamePieceId,boardLocation.locationName]];

    dispatch_async(dispatch_get_main_queue(), ^{
        [boardLocation addGamePieceToLocation:gamePiece];
        NSLog(@"Succesfully parsed playerMovedPieceToNewLocation with gamepieceid: %@ and locationid: %@", gamePiece.gamePieceId, gamePiece.location.locationId);
        [[NSNotificationCenter defaultCenter] postNotificationName:@"playerMovedPieceToNewLocation" object:gamePiece];
    });
}

/*
 Type: movementPhaseOver
 Data: {
 hexLocations: array of serialized hex locations
 }
 Sending Type: UDP from server to client
 Description:  Tells all players that the movement phase is over.  Hex locations are sent to make sure all data is synced
*/
-(void) handleMovementPhaseOver: (Event*) event {
    NSDictionary* dataDic = [Utils getDataDictionaryFromGameMessageEvent:event];
    if(dataDic == nil){
        return;
    }
 
    NSArray *hexLocations = [dataDic objectForKey:@"hexLocations"];
    GameState *gameState = [[Game currentGame] gameState];
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        for(id object in hexLocations) {
            NSDictionary *hexDic = (NSDictionary*)object;
            HexLocation *hexInGameState = (HexLocation*)[gameState getBoardLocationById: [hexDic objectForKey:@"locationId"]];
            
            // Check all the game pieces given to make sure they are assigned to the hex location
            NSArray *piecesJsonArr = [hexDic objectForKey:@"gamePieces"];
            if(piecesJsonArr != nil){
                [hexInGameState updateLocationWithPieces:piecesJsonArr];
            }
            
            // Now check to make sure stacks are all good
            NSArray *stacksJsonArr = [hexDic objectForKey:@"stacks"];
            if(stacksJsonArr != nil) {
                [hexInGameState updateLocationWithStacks:stacksJsonArr];
            }
        }
        
         NSLog(@"Succesfully parsed movementPhaseOver");
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"movementPhaseOver" object:nil];
    });
}


-(void) handlePlayerExploredHex: (Event*) event {
    NSLog(@"Handling PlayerExploredHex message");
    
    NSDictionary* dataDic = [Utils getDataDictionaryFromGameMessageEvent:event];
    if(dataDic == nil){
        return;
    }
    
    NSDictionary *hexLocationDic = [dataDic objectForKey:@"hexLocation"];
    NSString *hexLocationId = [dataDic objectForKey:@"hexLocationId"];
    NSString *playerId = [dataDic objectForKey:@"playerId"];
    
    GameState *gameState = [[Game currentGame] gameState];
    Player *player = [gameState getPlayerById:playerId];
    HexLocation *hexInGameState = (HexLocation*)[gameState getBoardLocationById: hexLocationId];
    
     dispatch_async(dispatch_get_main_queue(), ^{
         [hexInGameState updateLocationFromSerializedJSONDictionary:hexLocationDic];
     });
    
    BOOL isMe = [[dataDic objectForKey:@"isMe"] boolValue];
    BOOL didCapture = [[dataDic objectForKey:@"didCapture"] boolValue];

    if( !isMe ) {
        if( ! didCapture ) {
            [Game addLogMessageToCurrentGame:[NSString stringWithFormat:@"%@ encountered some enemy pieces while exploring %@", player.username, hexInGameState.locationName]];
        } else{
            [Game addLogMessageToCurrentGame:[NSString stringWithFormat:@"%@ successfully captured %@", player.username, hexInGameState.locationName]];
        }
    }
    
    NSLog(@"Finished Handling PlayerExploredHex message");
}



@end
