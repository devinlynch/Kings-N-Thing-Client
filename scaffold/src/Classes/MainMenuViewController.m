//
//  MainMenuViewController.m
//  3004iPhone
//
//  Created by Devin Lynch on 2014-01-24.
//
//

#import "MainMenuViewController.h"
#import "User.h"
@interface MainMenuViewController ()

@end

@implementation MainMenuViewController
@synthesize quickMatchButton, findGameButton, joinGameButton, welcomeText;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.navigationController.navigationBar.hidden=NO;
    self.navigationItem.hidesBackButton = YES;
    
    User *user = [User instance];
    if(user == nil) {
        //TODO go back to login screen I guess?
    }
    
    welcomeText.text = [welcomeText.text stringByReplacingOccurrencesOfString:@"@@username@@" withString:user.username];
}

-(void) viewWillppear:(BOOL)animated {
    self.navigationController.navigationBar.hidden=NO;
    self.navigationItem.hidesBackButton = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)didPressMatchButton:(id)sender;
{
    
}

@end
