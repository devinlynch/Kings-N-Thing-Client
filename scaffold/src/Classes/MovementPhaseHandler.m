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

@implementation MovementPhaseHandler

-(void) handleYourTurnToMoveInMovement: (Event*) event{
    NSLog(@"Succesfully handled yourTurnToMoveInMovement message");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"yourTurnToMoveInMovement" object:nil];
}

-(void) handlePlayerMovedStackToNewLocation:(Event *)event{
    NSDictionary* dataDic = [Utils getDataDictionaryFromGameMessageEvent:event];
    if(dataDic == nil){
        return;
    }
    
    NSString *playerId = [dataDic objectForKey:@"playerId"];
    NSString *hexLocationId = [dataDic objectForKey:@"hexLocationId"];
    NSDictionary *stackDic = [dataDic objectForKey:@"stack"];
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
    

    NSLog(@"Succesfully parsed playerMovedStackToNewLocation message with stackID: %@", stack.locationId);
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"playerMovedStackToNewLocation" object:hexLocation];
}

@end
