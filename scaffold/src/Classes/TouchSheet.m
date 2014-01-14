//
//  TouchSheet.m
//  Sparrow
//
//  Created by Daniel Sperl on 08.05.09.
//  Copyright 2011 Gamua. All rights reserved.
//

#import "TouchSheet.h"

// --- private interface ---------------------------------------------------------------------------

@interface TouchSheet ()

- (void)onTouchEvent:(SPTouchEvent*)event;

@end

// --- class implementation ------------------------------------------------------------------------

@implementation TouchSheet
{
    SPQuad *_quad;
}

- (id)initWithQuad:(SPQuad*)quad
{
    if ((self = [super init]))
    {
        // move quad to center, so that scaling works like expected
        _quad = quad;
        _quad.x = _quad.y = 0;
        [_quad addEventListener:@selector(onTouchEvent:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
        [self addChild:_quad];
    }
    return self;    
}

- (id)init
{
    // the designated initializer of the base class should always be overridden -- we do that here.
    SPQuad *quad = [[SPQuad alloc] init];
    return [self initWithQuad:quad];
}

- (void)onTouchEvent:(SPTouchEvent*)event
{
    NSArray *touches = [[event touchesWithTarget:self andPhase:SPTouchPhaseMoved] allObjects];
    
    if (touches.count == 1)
    {
        // one finger touching -> move
        SPTouch *touch = touches[0];
        SPPoint *movement = [touch movementInSpace:self.parent];
        
        self.x += movement.x;
        self.y += movement.y;
        
    }
    else if (touches.count >= 2)
    {
        // two fingers touching -> rotate and scale
        SPTouch *touch1 = touches[0];
        SPTouch *touch2 = touches[1];
        
        SPPoint *touch1PrevPos = [touch1 previousLocationInSpace:self.parent];
        SPPoint *touch1Pos = [touch1 locationInSpace:self.parent];
        SPPoint *touch2PrevPos = [touch2 previousLocationInSpace:self.parent];
        SPPoint *touch2Pos = [touch2 locationInSpace:self.parent];
        
        SPPoint *prevVector = [touch1PrevPos subtractPoint:touch2PrevPos];
        SPPoint *vector = [touch1Pos subtractPoint:touch2Pos];

        // update pivot point based on previous center
        SPPoint *touch1PrevLocalPos = [touch1 previousLocationInSpace:self];
        SPPoint *touch2PrevLocalPos = [touch2 previousLocationInSpace:self];
        self.pivotX = (touch1PrevLocalPos.x + touch2PrevLocalPos.x) * 0.5f;
        self.pivotY = (touch1PrevLocalPos.y + touch2PrevLocalPos.y) * 0.5f;
        
        // update location based on the current center
        self.x = (touch1Pos.x + touch2Pos.x) * 0.5f;
        self.y = (touch1Pos.y + touch2Pos.y) * 0.5f;

        // update location based on the current center
        
        self.x = (touch1Pos.x + touch2Pos.x) * 0.5f;
        self.y = (touch1Pos.y + touch2Pos.y) * 0.5f;
        
        //Rotation code
        
        //        float angleDiff = vector.angle - prevVector.angle;
        //        self.rotation += angleDiff;
        
        
        
        float sizeDiff = vector.length / prevVector.length;
        
        //dont let it zoom out under its original size or too big
        if(self.scaleX * sizeDiff >= 1.00f && self.scaleX * sizeDiff <= 3.00f){
            self.scaleX = self.scaleY = MAX(0.5f, self.scaleX * sizeDiff);
        }
    }
}

- (void)dealloc
{
    // event listeners should always be removed to avoid memory leaks!
    [_quad removeEventListenersAtObject:self forType:SP_EVENT_TYPE_TOUCH];
}

@end
