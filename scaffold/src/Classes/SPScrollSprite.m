//
//  SPScrollSprite.m
//  PixelBrush
//
//  Created by Sunny Hong on 1/23/11.
//  Copyright 2011 Sunny Hong. All rights reserved.
//

#import "SPScrollSprite.h"


// --- class implementation ------------------------------------------------------------------------

@implementation SPScrollSprite

#pragma mark @Init

+ (SPScrollSprite *)sprite
{
    return [[SPScrollSprite alloc] init] ;
}

- (id)init
{    
    if (self = [super init])
    {
        self.scrollEnabled = YES; // default value, and sets up listener
    }
    return self;
}

#pragma mark @Properties

@synthesize contentHeight;
@synthesize contentWidth;
@synthesize scrollEnabled = mScrollEnabled;
@synthesize scrollRect = mScrollRect;

- (void)setScrollEnabled:(BOOL)value
{
	mScrollEnabled = value;
	if (value)
	{
		[self addEventListener:@selector(onScroll:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
	}
	else
	{
		[self removeEventListener:@selector(onScroll:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
	}
}

- (float)height
{
	if (mScrollRect != nil)
	{
		return MIN(super.height, mScrollRect.height);
	}
    return super.height;
}

- (float)width
{
	if (mScrollRect != nil)
	{
		return MIN(super.width, mScrollRect.width);
	}
    return super.width;
}

- (float)contentHeight
{
    return [self bounds].height;
}

- (float)contentWidth
{
    return [self bounds].width;
}

- (void)setScaleX:(float)value
{
    [NSException raise:SP_EXC_INVALID_OPERATION format:@"cannot scale SPScrollSprite"];
}

- (void)setScaleY:(float)value
{
    [NSException raise:SP_EXC_INVALID_OPERATION format:@"cannot scale SPScrollSprite"];
}

- (void)setRotation:(float)value
{
    [NSException raise:SP_EXC_INVALID_OPERATION format:@"cannot rotate SPScrollSprite"];
}

#pragma mark @Events

- (void)onScroll:(SPTouchEvent*)event
{
	if (mScrollRect == nil)
	{
		return;
	}
	
    NSArray *touches = [[event touchesWithTarget:self andPhase:SPTouchPhaseMoved] allObjects];
    
    if (touches.count == 1)
    {
        SPTouch *touch = [touches objectAtIndex:0];

		SPPoint *point = [self localToGlobal:[SPPoint pointWithX:self.x y:self.y]];
		SPRectangle *rect = [SPRectangle rectangleWithX:point.x y:point.y width:self.width height:self.height];
		if ([rect containsX:touch.globalX y:touch.globalY] == NO)
		{
			return;
		}
		
        SPPoint *currentPos = [touch locationInSpace:self.parent];
        SPPoint *previousPos = [touch previousLocationInSpace:self.parent];
        SPPoint *dist = [currentPos subtractPoint:previousPos];
        
		mScrollRect.x -= dist.x;
		mScrollRect.y -= dist.y;
		
		if (mScrollRect.x < 0 || self.contentWidth <= mScrollRect.width)
		{
			mScrollRect.x = 0;
		}
		else if (mScrollRect.x > self.contentWidth - mScrollRect.width)
		{
			mScrollRect.x = self.contentWidth - mScrollRect.width;
		}
		
		if (mScrollRect.y < 0 || self.contentHeight <= mScrollRect.height)
		{
			mScrollRect.y = 0;
		}
		else if (mScrollRect.y > self.contentHeight - mScrollRect.height)
		{
			mScrollRect.y = self.contentHeight - mScrollRect.height;
		}
    }
	
}

#pragma mark @Overrides

- (void)render:(SPRenderSupport *)support;
{
	if (mScrollRect == nil)
	{
		[super render:support];
	}
	else
	{
		SPPoint *point = [self localToGlobal:[SPPoint pointWithX:self.x y:self.y]];
		glScissor(point.x, self.stage.height - point.y - self.height, self.width, self.height);
		glEnable(GL_SCISSOR_TEST);
		glTranslatef(-mScrollRect.x, -mScrollRect.y, 0);
		[super render:support];
		glDisable(GL_SCISSOR_TEST);
	}
}

/// BUG FIX - remove if fixed in Sparrow Framework
//- (SPPoint*)localToGlobal:(SPPoint*)localPoint
//{
//    // move up until parent is nil
//    SPMatrix *transformationMatrix = [[SPMatrix alloc] init];
//    SPDisplayObject *currentObject = self.parent;
//    while (currentObject)
//    {
//        [transformationMatrix concatMatrix:currentObject.transformationMatrix];
//        currentObject = [currentObject parent];
//    }
//    
//    SPPoint *globalPoint = [transformationMatrix transformPoint:localPoint];
//    //[transformationMatrix release];
//    return globalPoint;
//}

//- (void)dealloc
//{
//	[mScrollRect release];
//    [super dealloc];
//}

@end

