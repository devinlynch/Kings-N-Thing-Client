//
//  GameLobbyViewController.h
//  3004iPhone
//
//  Created by Devin Lynch on 2014-01-25.
//
//

#import <UIKit/UIKit.h>
@class GameLobby;

@interface GameLobbyViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
{
    NSTimer *lobbyStateChecker;
}
@property IBOutlet UILabel *playersInLobbyLabel;
@property IBOutlet UILabel *playersNeededLabel;
@property IBOutlet UITableView *usersTableView;
@property GameLobby *gameLobby;

-(IBAction)didPressLeave:(id)sender;

@end
