//
//  MainMenuViewController.h
//  3004iPhone
//
//  Created by Devin Lynch on 2014-01-24.
//
//

#import <UIKit/UIKit.h>
#import "LobbyProtocol.h"

@interface MainMenuViewController : UIViewController{
    
}
@property IBOutlet UIButton *quickMatchButton;
@property IBOutlet UIButton *findGameButton;
@property IBOutlet UIButton *hostGameButton;
@property IBOutlet UILabel *welcomeText;


-(IBAction)didPressMatchButton:(id)sender;


@end
