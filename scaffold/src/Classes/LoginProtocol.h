//
//  LoginProtocol.h
//  3004iPhone
//
//  Created by Devin Lynch on 2014-01-23.
//
//

#import <Foundation/Foundation.h>
@class ServerMessageError;

@protocol LoginProtocol <NSObject>

-(void) didLoginWithSuccess: (BOOL) success andError: (ServerMessageError*) error;

@end
