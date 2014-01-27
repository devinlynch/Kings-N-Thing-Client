//
//  IPManager.h
//  3004iPhone
//
//  Created by Devin Lynch on 2014-01-25.
//
//

#import <Foundation/Foundation.h>

@interface IPManager : NSObject

+ (NSString *)getIPAddress:(BOOL)preferIPv4;

@end
