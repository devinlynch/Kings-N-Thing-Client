//
//  GameLobbyViewController.m
//  3004iPhone
//
//  Created by Devin Lynch on 2014-01-25.
//
//

#import "GameLobbyViewController.h"
#import "GameLobby.h"
#import "User.h"
#import "LobbyNotification.h"
#import "ServerAccess.h"
#import "MainMenuViewController.h"

@interface GameLobbyViewController ()

@end

@implementation GameLobbyViewController
@synthesize usersTableView, playersInLobbyLabel, playersNeededLabel, gameLobby;
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
	usersTableView.delegate = self;
    usersTableView.dataSource = self;
    self.navigationItem.hidesBackButton = YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleNewLobbyState:)
                                                 name:@"newLobbyState"
                                               object:nil];
    [self reloadValuesForGameLobby];
    [self startLobbyStateChecker];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) handleNewLobbyState: (NSNotification*) notif{
    LobbyNotification *notification = notif.object;
    
    GameLobby *newGameLobby = notification.gameLobby;
    if(newGameLobby != nil) {
        gameLobby = newGameLobby;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self reloadValuesForGameLobby];
        });
    }
}

-(void) reloadValuesForGameLobby{
    playersInLobbyLabel.text= [NSString stringWithFormat: @"Players in lobby: %d", gameLobby.users.count];
    playersNeededLabel.text= [NSString stringWithFormat: @"Players needed for match: %d", gameLobby.numberOfPlayersWanted];
    [self.usersTableView reloadData];
}

#pragma mark - tableview

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int num = 0;
    if(gameLobby != nil && gameLobby.users != nil)
        num = [[gameLobby users] count];
    
    return num;
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    int index = indexPath.row;
    
    static NSString *CellIdentifier = @"Cell";
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [usersTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:simpleTableIdentifier];
    }
    
    User *user = [[gameLobby users] objectAtIndex:index];
    
    cell.textLabel.text = user.username;
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Users in Lobby";
}

-(IBAction)didPressLeave:(id)sender{
    [[ServerAccess instance] unregisterFromLobby];
    [self performSegueWithIdentifier:@"backToMainMenu" sender:self];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    [self stopLobbyStateChecker];
    UIViewController *controller = segue.destinationViewController;
    if([controller isKindOfClass:[MainMenuViewController class]]){
        
    }
}

- (void) startLobbyStateChecker
{
    lobbyStateChecker = [NSTimer scheduledTimerWithTimeInterval:3
                                                    target:self
                                                  selector:@selector(updateState:)
                                                  userInfo:nil
                                                   repeats:YES];
}

- (void) stopLobbyStateChecker
{
    if(lobbyStateChecker != nil)
        [lobbyStateChecker invalidate];
}

-(void) updateState:(NSTimer*)theTimer {
    [[ServerAccess instance] getLobbyState];
}

@end
