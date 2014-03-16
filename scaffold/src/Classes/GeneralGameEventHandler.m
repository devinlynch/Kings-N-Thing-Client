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
        
        if([data.map valueForKey:@"message"] != nil){
            NSDictionary *dic = [data.map valueForKey:@"message"];
            [self addChatMessageFromDictionary:dic];
        }
    }
}

-(void) handleBatchChatMessages: (Event*) event {
    if([Game currentGame] != nil) {
        NSLog(@"Handling batch of chat messages");
        ServerMessageData *data = event.msg.data;
        
        NSArray *messages = [data.map objectForKey:@"messages"];
        
        for(NSDictionary *dic in messages) {
            [self addChatMessageFromDictionary:dic];
        }
    }
}

-(void) addChatMessageFromDictionary: (NSDictionary*) dic{
    GameChatMessage * chatMsg = [[GameChatMessage alloc] initFromJSON:dic];
    [[Game currentGame] addChatMessage:chatMsg];
    NSLog(@"Got a chat msg with with id [%@] from date [%@] and message is [%@]", chatMsg.gameChatMessageId, chatMsg.createdDate, chatMsg.message);
}

@end
