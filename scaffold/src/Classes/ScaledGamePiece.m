//
//  ScaleImage.m
//  3004iPhone
//
//  Created by Richard Ison on 1/16/2014.
//
//

#import "ScaledGamePiece.h"
#import "GamePiece.h"

@implementation ScaledGamePiece{


}

- (id) initWithContentsOfFile:(NSString *)path andOwner:(GamePiece *)piece
{
    
    _owner = (id<NSCopying>) piece;
    
    self = [super initWithContentsOfFile:path generateMipmaps:NO];
    
    self.scaleX = 0.75f;
    self.scaleY = 0.75f;
    
    [self addEventListener:@selector(onImageTouched:) atObject:self forType:SP_EVENT_TYPE_TOUCH];

    
    return self;
}


- (id) initWithContentsOfFile:(NSString *)path
{
    
   // _owner = piece;
    
    self = [super initWithContentsOfFile:path generateMipmaps:NO];
    
    self.scaleX = 0.75f;
    self.scaleY = 0.75f;
    
    [self addEventListener:@selector(onImageTouched:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    
    
    return self;
}

- (void)onImageTouched:(SPTouchEvent*)event {
    
    SPImage *img = (SPImage*)event.target;
    
    NSArray *touches = [[event touchesWithTarget:self andPhase:SPTouchPhaseBegan] allObjects];
    if (touches.count == 1)
    {
        //Double Click
        SPTouch * clickTileMenu = [touches objectAtIndex:0];
        if (clickTileMenu.tapCount == 2){
            NSLog(@"le double click");
            [NSObject cancelPreviousPerformRequestsWithTarget:self];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"pieceSelected" object:_owner];
        }
        
    }
}

-(void) setOwner:(id<NSCopying>) owner{
    _owner = owner;
}

@end
