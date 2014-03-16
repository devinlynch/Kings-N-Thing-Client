//
//  AppDelegate.h
//  AppScaffold
//

#import <UIKit/UIKit.h>
@class UDPMessageReceiver;
@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    UDPMessageReceiver *udpMessageReceiver;
}
@end
