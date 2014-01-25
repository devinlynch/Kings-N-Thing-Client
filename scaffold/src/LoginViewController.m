//
//  LoginViewController.m
//  3004iPhone
//
//  Created by Devin Lynch on 2014-01-23.
//
//

#import "LoginViewController.h"
#import "ServerAccess.h"
#import "Utils.h"
#import "ServerMessageError.h"
#import "MBProgressHUD.h"

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
    loginY = self.loginButton.center.y;
    registerY = self.registerButton.center.y;
    self.navigationController.navigationBar.hidden=YES;
    [super viewDidLoad];
    
	// Do any additional setup after loading the view.
}

-(void) viewDidAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden=YES;
}
-(void) viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.hidden=YES;
}

-(void) viewDidLayoutSubviews{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.0f];
    [self.loginButton setCenter: CGPointMake( self.loginButton.center.x, loginY)];
    [self.registerButton setCenter: CGPointMake( self.registerButton.center.x, registerY)];
    [UIView commitAnimations];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)didPressLogin:(id)sender{
    [self showLoader];
    NSString *username = self.usernameField.text;
    NSString *password = self.passwordField.text;
    [[ServerAccess instance] loginWithUsername:username andPassword:password andDelegateListener:self];
}
-(IBAction)didPressRegister:(id)sender {
    if(! hasPressedRegister){
        registerY = self.registerButton.center.y+40;
        loginY = self.loginButton.center.y+40;
        [self animateRegister];
        hasPressedRegister = true;
        return;
    }
    
    [self showLoader];
    NSString *username = self.usernameField.text;
    NSString *password = self.passwordField.text;
    [[ServerAccess instance] registerAndLoginWithUsername:username andPassword:password andDelegateListener:self];
}

-(void) showLoader{
    [Utils showLoaderOnView:self.view animated:YES];
}

-(void) animateRegister {
    [self moveButton:self.registerButton andY:registerY];
    [self moveButton:self.loginButton andY:loginY];
    self.passwordAgainField.alpha = 0.0;
    self.passwordAgainField.hidden = NO;
    [UIView animateWithDuration:0.75 animations:^{self.passwordAgainField.alpha = 1.0;}];
}

-(void) moveButton: (UIButton*) button andY: (CGFloat) y{
    CGPoint newLeftCenter = CGPointMake( button.center.x, y);
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.0f];
    button.center = newLeftCenter;
    [UIView commitAnimations];
}


-(void) didLoginWithSuccess:(BOOL)success andError:(ServerMessageError *)error{
    [Utils removeLoaderOnView:self.view animated:YES];
    if(success) {
        NSLog(@"Success in controller");
        [self handleSuccessfulLogin];
    } else{
        [self displayMessageFromError:error isRegister:NO];
    }
}

-(void) didRegisterWithSuccess:(BOOL)success andError:(ServerMessageError *)error {
    [Utils removeLoaderOnView:self.view animated:YES];
    if(success) {
        NSLog(@"Success registering in controller");
    } else{
        [self displayMessageFromError:error isRegister:YES];
    }
}

-(void) didRegisterAndLoginWithSuccess:(BOOL)success andError:(ServerMessageError *)error {
    [Utils removeLoaderOnView:self.view animated:YES];
    if(success) {
        NSLog(@"Success registering and logging in in controller");
        [self handleSuccessfulLogin];
    } else{
        [self displayMessageFromError:error isRegister:YES];
    }
}

-(void) handleSuccessfulLogin{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self performSegueWithIdentifier:@"login" sender:self];
    });
}

-(void) displayMessageFromError: (ServerMessageError*) error isRegister: (BOOL) isRegister{
    NSString *message = @"Something went wrong while logging in.  Please try again.";
    if(isRegister) {
        message = @"Something went wrong while registering.  Please try again.";
    }
    
    if(error != nil) {
        if([error.responseError isEqualToString: @"BAD_USERNAME_AND_PASSWORD"]) {
            message = @"Your username and password did not match";
        } else if([error.responseError isEqualToString:@"ALREADY_LOGGED_IN"]) {
            [self handleSuccessfulLogin];
            return;
        } else if([error.responseError isEqualToString:@"ALREADY_REGISTERED"]) {
            message = @"The username specified is already taken.  Please either login or choose another.";
        }
    }
    
    [Utils showAlertWithTitle:@"Error" message:message delegate:nil cancelButtonTitle: @"Ok"];
    NSLog(@"Error while logging in or registering in LoginViewController");
}

@end
