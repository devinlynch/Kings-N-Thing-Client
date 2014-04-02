//
//  LogMessage.h
//  3004iPhone
//
//  Created by Devin Lynch on 2014-04-01.
//
//

#import <Foundation/Foundation.h>

@interface LogMessage : NSObject

@property NSString *message;
@property NSDate *date;

-(id) initWithMessage: (NSString*) _message;

@end
