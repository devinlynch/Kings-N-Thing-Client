//
//  GeneralGameEventHandler.m
//  3004iPhone
//
//  Created by Devin Lynch on 2014-02-27.
//
//

#import "GeneralGameEventHandler.h"
#import "Event.h"
#import "Game.h"

@implementation GeneralGameEventHandler

-(void) handleGameOver:(Event*) event{
    if([Game currentGame] != nil) {
        NSLog(@"Handling game over message");
        [[NSNotificationCenter defaultCenter] postNotificationName:@"gameOver" object:nil];
    }
}

@end
