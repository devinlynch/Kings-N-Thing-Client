//
//  SPScrollSprite.h
//  PixelBrush
//
//  Created by Sunny Hong on 1/23/11.
//  Copyright 2011 Sunny Hong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SPSprite.h"

@interface SPScrollSprite : SPSprite 
{
	@private
	SPRectangle *mScrollRect;
	BOOL mScrollEnabled;
}

/// Indicates the bounds of the clipped area.
@property (nonatomic, retain) SPRectangle * scrollRect;

/// Indicates the height of the content area.
@property (nonatomic, readonly) float contentHeight;

/// Indicates the width of the content area.
@property (nonatomic, readonly) float contentWidth;

/// Indicates whether scrolling by touch is enabled.
@property (nonatomic, assign) BOOL scrollEnabled;

/// Factory
+(SPScrollSprite*)sprite;

@end
