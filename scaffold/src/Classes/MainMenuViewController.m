//
//  MainMenuViewController.m
//  3004iPhone
//
//  Created by Devin Lynch on 2014-01-24.
//
//

#import "MainMenuViewController.h"
#import "User.h"
#import "KeychainItemWrapper.h"
#import "FindLobbyViewController.h"
#import "ServerAccess.h"

@interface MainMenuViewController ()
{
    enum GameLobbySearchType pressedType;
}
@end

@implementation MainMenuViewController

@synthesize quickMatchButton, findGameButton, hostGameButton, welcomeText;

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
        [self dismissViewControllerAnimated:YES completion:^{}];
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
}
-(IBAction)didPressMatchButton:(id)sender;
{
    if(sender == hostGameButton) {
        pressedType = HOST_A_GAME;
    } else if(sender == findGameButton) {
        pressedType = SEARCH_FOR_HOST;
    } else{
        pressedType = QUICK_MATCH;
    }
    
    [self performSegueWithIdentifier:@"joinGameSpecifics" sender:self];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.destinationViewController isKindOfClass:[FindLobbyViewController class]]){
        FindLobbyViewController *controller = segue.destinationViewController;
        controller.type = pressedType;
    }    
}

- (IBAction)didPressLogoutButton:(id)sender {
    NSLog(@"Did press logout");
    
    //clear the keychain
    KeychainItemWrapper *wrapper = [[KeychainItemWrapper alloc] initWithIdentifier:@"3004Login" accessGroup:nil];
    [wrapper resetKeychainItem];
    
    //reset the user
    [User reInitInstance];
    
    [[ServerAccess instance] logout];
    
    //dismiss view
    dispatch_async(dispatch_get_main_queue(), ^{
        [self performSegueWithIdentifier:@"logout" sender:self];
    });
    
 
}

@end
