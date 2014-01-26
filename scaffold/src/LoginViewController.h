//
//  LoginViewController.h
//  3004iPhone
//
//  Created by Devin Lynch on 2014-01-23.
//
//

#import <UIKit/UIKit.h>
#import "LoginProtocol.h"

@interface LoginViewController : UIViewController<LoginProtocol, UITextFieldDelegate>
{
    BOOL hasPressedRegister;
    CGFloat loginY;
    CGFloat registerY;
    BOOL saveLogin;
}
@property IBOutlet UITextField *usernameField;
@property IBOutlet UITextField *passwordField;
@property IBOutlet UITextField *passwordAgainField;
@property IBOutlet UIButton *loginButton;
@property IBOutlet UIButton *registerButton;
@property (strong, nonatomic) IBOutlet UISegmentedControl *saveLoginSwitch;

- (IBAction)segmentSwitch:(id)sender;

-(IBAction)didPressLogin:(id)sender;
-(IBAction)didPressRegister:(id)sender;
@end
