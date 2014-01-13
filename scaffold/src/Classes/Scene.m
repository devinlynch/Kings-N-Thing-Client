//
//  Scene.m
//  3004iPhone
//
//  Created by Richard Ison on 1/13/2014.
//
//

#import "Scene.h"

NSString *const EventTypeSceneClosing = @"closing";

@implementation Scene
{
    SPButton *_backButton;
}

- (instancetype)init
{
    if ((self = [super init]))
    {
        // create a button with the text "back" and display it at the bottom of the screen.
//        SPTexture *buttonTexture = [SPTexture textureWithContentsOfFile:@"Button-Normal@2x.png"];
//        
//        _backButton = [[SPButton alloc] initWithUpState:buttonTexture text:@"back"];
//        _backButton.x = CENTER_X - _backButton.width / 2.0f;
//        _backButton.y = GAME_HEIGHT - _backButton.height + 1;
//        [_backButton addEventListener:@selector(onBackButtonTriggered:) atObject:self
//                              forType:SP_EVENT_TYPE_TRIGGERED];
//        [self addChild:_backButton];
    }
    return self;
}

- (void)onBackButtonTriggered:(SPEvent *)event
{
    [_backButton removeEventListenersAtObject:self forType:SP_EVENT_TYPE_TRIGGERED];
    [self dispatchEventWithType:EventTypeSceneClosing bubbles:YES];
}

@end