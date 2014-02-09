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
    
    _owner = piece;
    
    ScaledGamePiece *img = [super initWithContentsOfFile:path generateMipmaps:NO];
    
    img.scaleX = 0.75f;
    img.scaleY = 0.75f;
    
   // [img addEventListener:@selector(onMoveTile:) atObject:self forType:SP_EVENT_TYPE_TOUCH];

 
    return img;
}


- (id) initWithContentsOfFile:(NSString *)path
{
    
   // _owner = piece;
    
    ScaledGamePiece *img = [super initWithContentsOfFile:path generateMipmaps:NO];
    
    img.scaleX = 0.75f;
    img.scaleY = 0.75f;
    
    // [img addEventListener:@selector(onMoveTile:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    
    
    return img;
}

- (void)onMoveTile:(SPTouchEvent*)event {
    
    SPImage *img = (SPImage*)event.target;
    
    NSArray *touches = [[event touchesWithTarget:self andPhase:SPTouchPhaseMoved] allObjects];
    
    NSLog(@"Touching piece with ID of %@", [[self owner] gamePieceId]);
    
    if (touches.count == 1)
    {
        // one finger touching -> move
        SPTouch *touch = touches[0];
        SPPoint *movement = [touch movementInSpace:self.parent];
        
        img.x += movement.x;
        img.y += movement.y;
    }
}

@end
