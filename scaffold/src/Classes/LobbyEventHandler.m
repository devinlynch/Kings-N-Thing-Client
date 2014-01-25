//
//  LobbyEventHandler.m
//  3004iPhone
//
//  Created by Devin Lynch on 2014-01-25.
//
//

#import "LobbyEventHandler.h"
#import "Event.h"
#import "Message.h"
#import "JoinLobbyNotification.h"
@implementation LobbyEventHandler

static NSDate *lastReceivedMessageDate;
-(void) handleEvent:(Event *)event {
    @synchronized(lastReceivedMessageDate) {
        Message *message = event.msg;
        NSDate *messageDate = message.createdDate;
        
        if(messageDate != nil) {
            if(lastReceivedMessageDate != nil && [messageDate compare:lastReceivedMessageDate] == NSOrderedAscending) {
                // This message was generated before the last processed message, so therefore this is now useless
                return;
            }
            
            lastReceivedMessageDate = messageDate;
        }
        
        GameLobby *gameLobby;
        if(message.data != nil && message.data.map != nil){
            NSDictionary *lobbyJson = [message.data.map objectForKey:@"joinedLobby"];
            if(lobbyJson != nil)
                 gameLobby = [[GameLobby alloc] initFromJSON:lobbyJson];
        }
        
        ServerMessageError *error = message.error;
        
        JoinLobbyNotification *notif = [[JoinLobbyNotification alloc] init];
        notif.error=error;
        notif.gameLobby=gameLobby;
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"joinLobby" object:notif];
    }
}

@end
