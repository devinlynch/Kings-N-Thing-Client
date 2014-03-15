//
//  FindLobbyViewController.m
//  3004iPhone
//
//  Created by Devin Lynch on 2014-01-25.
//
//

#import "FindLobbyViewController.h"
#import "ServerAccess.h"
#import "Utils.h"
#import "LobbyNotification.h"
#import "GameLobbyViewController.h"

@interface FindLobbyViewController ()
{
    GameLobby *gameLobby;
}
@end


@implementation FindLobbyViewController
@synthesize type, goButton, infoLabel, detailstextField;

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
    [self handleCorrectInfoOnScren];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleJoinLobby:)
                                                 name:@"joinLobby"
                                               object:nil];
}

-(void) viewWillAppear:(BOOL)animated {
    [self handleCorrectInfoOnScren];
}

-(void) handleCorrectInfoOnScren{
    if(type == QUICK_MATCH) {
        
    } else if(type == SEARCH_FOR_HOST) {
        infoLabel.text = @"Username of host to search for:";
    } else if(type == HOST_A_GAME) {
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) didPressGoButton:(id)sender {
    ServerAccess *access = [ServerAccess instance];
    
    if([self errorCheckInput]){
        NSUInteger numPlayers = [detailstextField.text integerValue];
        [Utils showLoaderOnView:self.view animated:YES];
        if(type == HOST_A_GAME) {
            [access hostLobby:numPlayers andDelegateListener:self];
        } else if(type == QUICK_MATCH) {
            [access findAnyLobby:numPlayers andDelegateListener:self];
        } else{
            [access searchLobby:detailstextField.text andDelegateListener:self];
        }
    }
}

-(BOOL) errorCheckInput{
    BOOL isOK = YES;
    
    if(detailstextField.text.length <=0) {
        isOK = NO;
    }
    
    NSString *message;
    if(type == HOST_A_GAME || type == QUICK_MATCH) {
        NSUInteger numPlayers = [detailstextField.text integerValue];
     //   if(numPlayers <= 1 || numPlayers > 4) {
       //     isOK = NO;
        //}
        message = @"You must enter a number between 2 and 4.";
    } else{
        message = @"Please enter a username.";
    }
    
    if(! isOK) {
        [Utils showAlertWithTitle:@"Error" message:message delegate:self cancelButtonTitle:@"Ok"];
    }
    
    return isOK;
}

-(void) didStartSearchingForLobbyAndWasError:(BOOL)isError {
    if(isError){
        [Utils showAlertWithTitle:@"Error" message:@"There was an error finding a lobby.  Please try again." delegate:self cancelButtonTitle:@"Ok"];
        [Utils removeLoaderOnView:self.view animated:YES];
    }
}

-(void) handleJoinLobby: (NSNotification*) notif {
    dispatch_async(dispatch_get_main_queue(), ^{
        [Utils removeLoaderOnView:self.view animated:YES];
        NSLog(@"Handling notif!");
        LobbyNotification *notification = notif.object;
        
        if(notification.error != nil || notification.gameLobby == nil) {
            NSLog(@"Error joining game lobby: %@", notification.error);
            
            NSString *message;
            if(type == HOST_A_GAME) {
                message = @"We were unable to create a game lobby.  Please try again";
            } else if(type == QUICK_MATCH) {
                message = @"No game lobby could be found.  Please try again";
            } else{
                message = [NSString stringWithFormat: @"The user '%@' is not currently hosting a game", detailstextField.text];
            }
            [Utils showAlertWithTitle:@"Error" message:message delegate:self cancelButtonTitle:@"Ok"];
        } else{
            NSLog(@"Did join game lobby: %@", notification.gameLobby);
            gameLobby = notification.gameLobby;
            [self performSegueWithIdentifier:@"joinedLobby" sender:self];
        }
    });
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    if([segue.destinationViewController isKindOfClass:[GameLobbyViewController class]]){
       GameLobbyViewController *controller = segue.destinationViewController;
       controller.gameLobby = gameLobby;
    }
}

@end
