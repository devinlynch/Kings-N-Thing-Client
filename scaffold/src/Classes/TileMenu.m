//
//  TileMenu.m
//  3004iPhone
//
//  Created by Richard Ison on 1/14/2014.
//
//

#import "TileMenu.h"

@implementation TileMenu
{
    SPSprite *_contents;
    
    SPImage *_swamp_065;
    SPImage *_swamp_066;
    SPImage *_swamp_067;
    SPImage *_swamp_068;
    SPImage *_swamp_069;
    
    
 
}

- (id)init
{
    if ((self = [super init]))
    {
        [self setup];
    }
    return self;
}


- (void) setup {
    _contents = [SPSprite sprite];
    [self addChild:_contents];

    SPImage *background = [[SPImage alloc] initWithContentsOfFile:@"mainMenuBackground.png"];
    
    [_contents addChild:background];
    
    //Test: adding swamp cards
    _swamp_065 = [[SPImage alloc] initWithContentsOfFile:@"T_Swamp_065.png"];
    _swamp_065.x = 5;
    _swamp_065.y = 10;
    [_contents addChild:_swamp_065];
    _swamp_066 = [[SPImage alloc] initWithContentsOfFile:@"T_Swamp_066.png"];
    _swamp_066.x = 5;
    _swamp_066.y = 50;
    [_contents addChild:_swamp_066];
    _swamp_067 = [[SPImage alloc] initWithContentsOfFile:@"T_Swamp_067.png"];
    _swamp_067.x = 5;
    _swamp_067.y = 90;
    [_contents addChild:_swamp_067];
    _swamp_068 = [[SPImage alloc] initWithContentsOfFile:@"T_Swamp_068.png"];
    _swamp_068.x = 5;
    _swamp_068.y = 140;
    [_contents addChild:_swamp_068];
    _swamp_069 = [[SPImage alloc] initWithContentsOfFile:@"T_Swamp_069.png"];
    _swamp_069.x = 5;
    _swamp_069.y = 190;
    [_contents addChild:_swamp_069];
    
    
    
    
}



@end
