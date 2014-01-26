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

void onUncaughtException(NSException *exception)
{
    NSLog(@"uncaught exception: %@", exception.description);
}

// ---

@implementation AppDelegate
{
    SPViewController *_viewController;
    UIWindow *_window;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
   /* NSSetUncaughtExceptionHandler(&onUncaughtException);
    
    CGRect screenBounds = [UIScreen mainScreen].bounds;
    _window = [[UIWindow alloc] initWithFrame:screenBounds];
    
    /*_viewController = [[SPViewController alloc] init];
    
    _viewController.multitouchEnabled = YES;
    
    // Enable some common settings here:
    //
     _viewController.showStats = YES;
     _viewController.multitouchEnabled = YES;
    // _viewController.preferredFramesPerSecond = 60;
    
    [_viewController startWithRoot:[LoginMenu class] supportHighResolutions:YES doubleOnPad:YES];
    
    
    LoginViewController *_view = [[LoginViewController alloc] initWithNibName:@"LoginView" bundle:nil];
    [_window makeKeyAndVisible];
    [_window setRootViewController:_view];
    //[_window makeKeyAndVisible];
    
    
    ///TEST
    ServerAccess *a = [[ServerAccess alloc] init];
    [a loginWithUsername:@"test" andPassword:@"test"];
    
    udpMessageReceiver = [[UDPMessageReceiver alloc] init];
    [udpMessageReceiver startListeningOnPort:3004];*/
    
    CGRect screenBounds = [UIScreen mainScreen].bounds;
    _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle: nil];
    UIViewController *yourController = [mainStoryboard instantiateInitialViewController];
    
    udpMessageReceiver = [[UDPMessageReceiver alloc] init];
    [udpMessageReceiver startListeningOnPort:3004];
    
    NSLog(@"My IP is: %@", [IPManager getIPAddress:YES]);
    
    [_window setRootViewController:yourController];
    [_window makeKeyAndVisible];
    return YES;
}

@end
