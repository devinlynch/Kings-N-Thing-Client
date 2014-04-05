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
#import "FourPlayerGame.h"
#import "Combat.h"
#import "RecruitThings.h"
#import "MessageHandler.h"
#import "TileMenu.h"
#import "SideMenu.h"
#import "GoldCollection.h"
#import "RecruitCharacter.h"
#import "RandomEventsMenu.h"
#import "ConstructionMenu.h"
#import "ChatScene.h"
#import "TestScreen.h"
#import "GameConfig.h"
#import "GameLobbyViewController.h"

#import <AVFoundation/AVFoundation.h>

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
    
    NSDictionary *config = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"config" ofType:@"plist"]];
    
    [GameConfig loadFromDictionary:config];
   
    _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    NSString *isTestScreenMode = [config objectForKey:@"test_screen_mode"];
    
    if(isTestScreenMode != nil && [isTestScreenMode isEqualToString:@"yes"]) {
        
        NSString *testScreenMethodName = [config objectForKey:@"test_screen_method"];
        
        TestScreen *testScreen = [[TestScreen alloc] init];
        
        SEL selector = NSSelectorFromString(testScreenMethodName);
        
        _viewController = [testScreen performSelector:selector withObject:_window];
        
        [_window setRootViewController:_viewController];
        
        [_window makeKeyAndVisible];
        
        
        
        return YES;
        
    }
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle: nil];
    UIViewController *yourController = [mainStoryboard instantiateInitialViewController];
    udpMessageReceiver = [[UDPMessageReceiver alloc] init];
    [udpMessageReceiver startListeningOnPort:3004];
    NSLog(@"My IP is: %@", [IPManager getIPAddress:YES]);
    [_window setRootViewController:yourController];
    [_window makeKeyAndVisible];
    [MessageHandler startMessageHandlerQueue];
    [self startNewMessageTimer];
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
        [GameLobbyViewController stopLobbyStateChecker];
        
        _viewController = [[SPViewController alloc] init];
        
        _viewController.multitouchEnabled = YES;
        
        // Enable some common settings here:
        _viewController.showStats = YES;
        _viewController.multitouchEnabled = YES;
        // _viewController.preferredFramesPerSecond = 60;
        _viewController.showStats=NO;
        
        [_viewController startWithRoot:[FourPlayerGame class] supportHighResolutions:YES doubleOnPad:YES];
        
        [_window setRootViewController:_viewController];
        [_window makeKeyAndVisible];
    });
}

-(void) handleGameOver: (NSNotification*) notif{
    dispatch_async(dispatch_get_main_queue(), ^{
        _viewController=nil;
        
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
