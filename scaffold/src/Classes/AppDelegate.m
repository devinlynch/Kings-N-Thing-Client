//
//  AppDelegate.m
//  AppScaffold
//

#import "AppDelegate.h"
#import "LoginMenu.h"
#import "UDPMessageReceiver.h"
#import "ServerAccess.h"
#import "LoginViewController.h"
#import "IPManager.h"
#import "Game.h"
#import "TwoThreePlayerGame.h"
#import "GameMenu.h"
#import "FourPlayerGame.h"
#import "Combat.h"
#import "RecruitThings.h"
#import "MessageHandler.h"
#import "TileMenu.h"
#import "SideMenu.h"
#import "GoldCollection.h"


void onUncaughtException(NSException *exception)
{
    NSLog(@"uncaught exception: %@", exception.description);
}

@implementation AppDelegate
{
    SPViewController *_viewController;
    UIWindow *_window;
    UIView *view;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
   NSSetUncaughtExceptionHandler(&onUncaughtException);
   
    _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    CGRect screenBounds = [UIScreen mainScreen].bounds;
    _window = [[UIWindow alloc] initWithFrame:screenBounds];

    _viewController = [[SPViewController alloc] init];
    
    _viewController.multitouchEnabled = YES;
    
    // Enable some common settings here:
    //
   // _viewController.showStats = YES;
   /* _viewController.multitouchEnabled = YES;
    // _viewController.preferredFramesPerSecond = 60;
    
    [_viewController startWithRoot:[FourPlayerGame class] supportHighResolutions:YES doubleOnPad:YES];
    
    [_window setRootViewController:_viewController];
    [_window makeKeyAndVisible];*/
    
    udpMessageReceiver = [[UDPMessageReceiver alloc] init];
    [udpMessageReceiver startListeningOnPort:3004];


    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle: nil];
    UIViewController *yourController = [mainStoryboard instantiateInitialViewController];
    
    udpMessageReceiver = [[UDPMessageReceiver alloc] init];
    [udpMessageReceiver startListeningOnPort:3004];
    
    NSLog(@"My IP is: %@", [IPManager getIPAddress:YES]);
    
    [_window setRootViewController:yourController];
    [_window makeKeyAndVisible];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleGameStarted:)
                                                 name:@"gameStarted"
                                               object:nil];
    
    udpMessageReceiver = [[UDPMessageReceiver alloc] init];
    [udpMessageReceiver startListeningOnPort:3004];
    
    [MessageHandler startMessageHandlerQueue];
    [self startNewMessageTimer];
    
    NSLog(@"My IP is: %@", [IPManager getIPAddress:YES]);
    
    [_window setRootViewController:yourController];
    [_window makeKeyAndVisible];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleGameStarted:)
                                                 name:@"gameStarted"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleGameOver:)
                                                 name:@"gameOver"
                                               object:nil];
    
    return YES;
}

-(void) handleGameStarted: (NSNotification*) notif{
    dispatch_async(dispatch_get_main_queue(), ^{

        Game *game = notif.object;
        // John/Richard, here is the game object in its initial state.  Do as you need with it
        
        CGRect screenBounds = [UIScreen mainScreen].bounds;
        _window = [[UIWindow alloc] initWithFrame:screenBounds];
        
        _viewController = [[SPViewController alloc] init];
        
        _viewController.multitouchEnabled = YES;
        
        // Enable some common settings here:
        _viewController.showStats = YES;
        _viewController.multitouchEnabled = YES;
        // _viewController.preferredFramesPerSecond = 60;
        
        [_viewController startWithRoot:[FourPlayerGame class] supportHighResolutions:YES doubleOnPad:YES];
        
        [_window setRootViewController:_viewController];
        [_window makeKeyAndVisible];
    });
}

-(void) handleGameOver: (NSNotification*) notif{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"Got game over message, going back to lobby");
        
        [Game setInstance: nil];
        
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle: nil];
        UIViewController *yourController = [mainStoryboard instantiateInitialViewController];
        
        [_window setRootViewController:yourController];
        [_window makeKeyAndVisible];
        
    });
}

- (void) startNewMessageTimer
{
    newMessageTimer = [NSTimer scheduledTimerWithTimeInterval:5
                                                         target:self
                                                       selector:@selector(getNewMessages:)
                                                       userInfo:nil
                                                        repeats:YES];
}

- (void)stopNewMessageTimer
{
    if(newMessageTimer != nil)
        [newMessageTimer invalidate];
}

-(void) getNewMessages:(NSTimer*)timer{
    [MessageHandler handleGetNewMessage];
}
     


@end
