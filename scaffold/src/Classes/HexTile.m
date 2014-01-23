//
//  HexTile.m
//  3004iPhone
//
//  Created by John Marsh on 1/15/2014.
//
//

#import "HexTile.h"

@implementation HexTile

@synthesize terrain = _terrain;
@synthesize isHilighted = _isHilighted;
@synthesize neighbours = _neighbours;


- (void)unhilight{
    _isHilighted = NO;
}

- (void)hilight{
    _isHilighted = YES;
}

@end
