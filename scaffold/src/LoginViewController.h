//
//  LoginViewController.h
//  3004iPhone
//
//  Created by Devin Lynch on 2014-01-23.
//
//

#import <UIKit/UIKit.h>
#import "LoginProtocol.h"

@interface LoginViewController : UIViewController<LoginProtocol>
{
    BOOL hasPressedRegister;
    CGFloat loginY;
    CGFloat registerY;
}
@property IBOutlet UITextField *usernameField;
@property IBOutlet UITextField *passwordField;
@property IBOutlet UITextField *passwordAgainField;
@property IBOutlet UIButton *loginButton;
@property IBOutlet UIButton *registerButton;

-(IBAction)didPressLogin:(id)sender;
-(IBAction)didPressRegister:(id)sender;
@end
