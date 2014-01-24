//
//  LoginViewController.m
//  3004iPhone
//
//  Created by Devin Lynch on 2014-01-23.
//
//

#import "LoginViewController.h"
#import "ServerAccess.h"
@interface LoginViewController ()

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view = [[UIView alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)didPressLogin:(id)sender{
    NSString *username = self.usernameField.text;
    NSString *password = self.passwordField.text;
    [[ServerAccess instance] loginWithUsername:username andPassword:password andDelegateListener:self];
}
-(IBAction)didPressRegister:(id)sender {
    if(! hasPressedRegister){
        [self animateRegister];
        hasPressedRegister = true;
        return;
    }
    
    NSString *username = self.usernameField.text;
    NSString *password = self.passwordField.text;
    [[ServerAccess instance] registerAndLoginWithUsername:username andPassword:password andDelegateListener:self];
}

-(void) animateRegister {
    [self moveButton:self.registerButton andY:40];
    [self moveButton:self.loginButton andY:40];
    self.passwordAgainField.alpha = 0.0;
    self.passwordAgainField.hidden = NO;
    [UIView animateWithDuration:0.75 animations:^{self.passwordAgainField.alpha = 1.0;}];
}

-(void) moveButton: (UIButton*) button andY: (int) y{
    CGPoint newLeftCenter = CGPointMake( button.center.x, button.center.y + y);
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.0f];
    button.center = newLeftCenter;
    [UIView commitAnimations];
}


-(void) didLoginWithSuccess:(BOOL)success andError:(id)error{
    if(success) {
        NSLog(@"Success in controller");
    } else{
        NSLog(@"Error in controller");
    }
}

@end
