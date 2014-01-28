//
//  LobbyProtocol.h
//  3004iPhone
//
//  Created by Devin Lynch on 2014-01-25.
//
//

#import <Foundation/Foundation.h>

@protocol LobbyProtocol <NSObject>
-(void) didStartSearchingForLobbyAndWasError: (BOOL) isError;
@end
