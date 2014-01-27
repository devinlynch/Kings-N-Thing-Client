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
#import "LobbyNotification.h"
@implementation LobbyEventHandler

-(void) handleEvent:(Event *)event {
    NSString *type = event.type;
    if(type != nil) {
        if([type isEqualToString:@"gameLobbyState"]) {
            [self handleNewGameLobbyState:event];
        } else if([type isEqualToString:@"joinLobby"]){
            [self handleJoinLobby:event];
        }
    }
}

-(void) handleJoinLobby: (Event*) event
{
    LobbyNotification *gameLobbyNotif = [self handleLobbyReceivedFromServer:event];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"joinLobby" object:gameLobbyNotif];
}

-(void) handleNewGameLobbyState: (Event*) event
{
    LobbyNotification *gameLobbyNotif = [self handleLobbyReceivedFromServer:event];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"newLobbyState" object:gameLobbyNotif];
}

static NSDate *lastReceivedMessageDate;
-(LobbyNotification*) handleLobbyReceivedFromServer: (Event*) event{
    @synchronized(lastReceivedMessageDate) {
        Message *message = event.msg;
        NSDate *messageDate = message.createdDate;
        
        if(messageDate != nil) {
            if(lastReceivedMessageDate != nil && [messageDate compare:lastReceivedMessageDate] == NSOrderedAscending) {
                // This message was generated before the last processed message, so therefore this is now useless
                return nil;
            }
            
            lastReceivedMessageDate = messageDate;
        }
        
        GameLobby *gameLobby;
        if(message.data != nil && message.data.map != nil){
            NSDictionary *lobbyJson = [message.data.map objectForKey:@"lobby"];
            if(lobbyJson != nil)
                gameLobby = [[GameLobby alloc] initFromJSON:lobbyJson];
        }
        
        ServerMessageError *error = message.error;
        LobbyNotification *notif = [[LobbyNotification alloc] init];
        notif.error=error;
        notif.gameLobby=gameLobby;
        
        return notif;
    }
}
@end
