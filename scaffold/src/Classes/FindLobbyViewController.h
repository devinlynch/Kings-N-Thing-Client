//
//  FindLobbyViewController.h
//  3004iPhone
//
//  Created by Devin Lynch on 2014-01-25.
//
//

#import <UIKit/UIKit.h>
#import "LobbyProtocol.h"

typedef enum GameLobbySearchType{
    QUICK_MATCH,
    SEARCH_FOR_HOST,
    HOST_A_GAME
} GameLobbySearchType;

@interface FindLobbyViewController : UIViewController<LobbyProtocol>

@property enum GameLobbySearchType type;
@property IBOutlet UITextField *detailstextField;
@property IBOutlet UILabel *infoLabel;
@property IBOutlet UIButton *goButton;

-(IBAction)didPressGoButton:(id)sender;

@end
