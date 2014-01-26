//
//  MainMenuViewController.h
//  3004iPhone
//
//  Created by Devin Lynch on 2014-01-24.
//
//

#import <UIKit/UIKit.h>

@interface MainMenuViewController : UIViewController
@property IBOutlet UIButton *quickMatchButton;
@property IBOutlet UIButton *findGameButton;
@property IBOutlet UIButton *joinGameButton;
@property IBOutlet UILabel *welcomeText;
@property IBOutlet UIButton *logoutButton;


-(IBAction)didPressMatchButton:(id)sender;

- (IBAction)didPressLogoutButton:(id)sender;

@end
