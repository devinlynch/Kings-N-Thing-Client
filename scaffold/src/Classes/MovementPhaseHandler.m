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
    [hexLocation addStack:stack];
    
    
    NSLog(@"Succesfully parsed updated stack message with stackID: %@", stack.locationId);
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"playerUpdatedStack" object:stack];
}

    NSLog(@"Succesfully parsed playerMovedStackToNewLocation message with stackID: %@", stack.locationId);
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"playerMovedStackToNewLocation" object:hexLocation];
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
    
    for(id object in hexLocations) {
        NSDictionary *hexDic = (NSDictionary*)object;
        HexLocation *hexInGameState = (HexLocation*)[gameState getBoardLocationById: [hexDic objectForKey:@"locationId"]];
        
        // Check all the game pieces given to make sure they are assigned to the hex location
        NSArray *piecesJsonArr = [hexDic objectForKey:@"gamePieces"];
        if(piecesJsonArr != nil){
            for(id o in piecesJsonArr) {
                if(o != nil && ([o isKindOfClass:[NSDictionary class]])){
                    NSDictionary *gamePieceDic = (NSDictionary*) o;
                    GamePiece *piece = [[GameResource getInstance] getPieceForId:[gamePieceDic objectForKey:@"id"]];
                    
                    if( piece.location != hexInGameState){
                        [hexInGameState addGamePieceToLocation:piece];
                    }
                    
                }
            }
        }
        
        // Now check to make sure stacks are all good
        NSArray *stacksJsonArr = [hexDic objectForKey:@"stacks"];
        if(stacksJsonArr != nil) {
            for(id o in stacksJsonArr) {
                NSDictionary *stackDic = (NSDictionary*) o;
                NSString *stackId = [stackDic objectForKey:@"locationId"];
                NSString *ownerId = [stackDic objectForKey:@"ownerId"];

                Stack *stack = [gameState getStackById: stackId];
                if(stack == nil || [stack isKindOfClass:[NSNull class]]) {
                    stack = [[Stack alloc] initFromJSON:stackDic];
                    Player *p = [gameState getPlayerById:ownerId];
                    [stack setOwner:p];
                }
                
                if([hexInGameState.stacks objectForKey:stack.locationId] == nil) {
                    [hexInGameState addStack:stack];
                }
            }
        }
    }
    
    NSLog(@"Succesfully parsed movementPhaseOver");
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"movementPhaseOver" object:nil];
}



@end
