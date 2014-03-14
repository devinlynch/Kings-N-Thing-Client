//
//  GeneralGameEventHandler.m
//  3004iPhone
//
//  Created by Devin Lynch on 2014-02-27.
//
//

#import "GeneralGameEventHandler.h"
#import "Event.h"
#import "Game.h"
#import "GameChatMessage.h"

@implementation GeneralGameEventHandler

-(void) handleGameOver:(Event*) event{
    if([Game currentGame] != nil) {
        NSLog(@"Handling game over message");
        [[NSNotificationCenter defaultCenter] postNotificationName:@"gameOver" object:nil];
    }
}

-(void) handleChatMessage: (Event*) event {
    if([Game currentGame] != nil) {
        NSLog(@"Handling chat message");
        ServerMessageData *data = event.msg.data;
        
        GameChatMessage * chatMsg = [[GameChatMessage alloc] initFromJSON:data.map];
        NSLog(@"Got a chat msg with with id [%@] from date [%@] and message is [%@]", chatMsg.gameChatMessageId, chatMsg.createdDate, chatMsg.message);
    }
}

-(void) handleBatchChatMessages: (Event*) event {
    if([Game currentGame] != nil) {
        NSLog(@"Handling batch of chat messages");
        ServerMessageData *data = event.msg.data;
        
        NSArray *messages = [data.map objectForKey:@"messages"];
        
        for(NSDictionary *dic in messages) {
            GameChatMessage * chatMsg = [[GameChatMessage alloc] initFromJSON:dic];
            NSLog(@"Got a chat msg with with id [%@] from date [%@] and message is [%@]", chatMsg.gameChatMessageId, chatMsg.createdDate, chatMsg.message);
        }
    }
}

@end
