//
//  GUIStateHandler.m
//  3004iPhone
//
//  Created by John Marsh on 1/28/2014.
//
//

#import "GUIStateHandler.h"
#import "Event.h"
#import "Message.h"

@implementation GUIStateHandler

-(void)handleEvent:(Event *)event{
    
    NSString *type = event.type;
    
    
    if(type != nil) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:type object:event.msg];
        });
    }

}

@end
