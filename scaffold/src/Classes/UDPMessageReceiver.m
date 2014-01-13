//
//  UDPMessageReceiver.m
//  3004iPhone
//
//  Created by Devin Lynch on 2014-01-12.
//
//

#import "UDPMessageReceiver.h"

@implementation UDPMessageReceiver

-(id) init{
    self = [super init];
    if(self) {
        udpSocket = [[GCDAsyncUdpSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    }
    return self;
}

- (void)startListeningOnPort: (int) port
{
	if (!isRunning){
		NSError *error = nil;
		
		if (![udpSocket bindToPort:port error:&error])
		{
			NSLog(@"Error starting server (bind): %@", error);
			return;
		}
		if (![udpSocket beginReceiving:&error])
		{
			[udpSocket close];
			
			NSLog(@"Error starting server (recv): %@", error);
			return;
		}
		
		NSLog(@"Udp Echo server started on port %hu", [udpSocket localPort]);
		isRunning = YES;
	}
}

-(void) stop {
    if(isRunning){
        [udpSocket close];
        isRunning = false;
    }
}

- (void)udpSocket:(GCDAsyncUdpSocket *)sock didReceiveData:(NSData *)data
        fromAddress:(NSData *)address
        withFilterContext:(id)filterContext
{
	if (!isRunning) return;
	
	NSString *msg = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
	if (msg)
	{
		NSLog(@"Got message: %@", msg);
	}
	else
	{
		NSLog(@"Error converting received data into UTF-8 String");
	}
	
	[udpSocket sendData:data toAddress:address withTimeout:-1 tag:0];
}

@end
