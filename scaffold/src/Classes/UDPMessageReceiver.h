//
//  UDPMessageReceiver.h
//  3004iPhone
//
//  Created by Devin Lynch on 2014-01-12.
//
//

#import <Foundation/Foundation.h>
#import "GCDAsyncUdpSocket.h"

@interface UDPMessageReceiver : NSObject<GCDAsyncUdpSocketDelegate>
{
    GCDAsyncUdpSocket *udpSocket;
    BOOL isRunning;
}

- (void)startListeningOnPort: (int) port;
- (void)stop;
@end
