//
//  InGameServerAccess.m
//  3004iPhone
//
//  Created by Devin Lynch on 2014-02-09.
//
//

#import "InGameServerAccess.h"
#import "ServerAccess.h"

@implementation InGameServerAccess

static InGameServerAccess *instance;
+(InGameServerAccess*) instance{
    @synchronized(self){
        if(!instance)
            instance = [[InGameServerAccess alloc] init];
    }
    return instance;
}


// Setup
-(void) setupPhaseReadyForPlacement{
    
}

@end
