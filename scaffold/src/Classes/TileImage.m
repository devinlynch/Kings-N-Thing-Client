//
//  TileImage.m
//  3004iPhone
//
//  Created by John Marsh on 2/10/2014.
//
//

#import "TileImage.h"

@implementation TileImage

@synthesize owner = _owner;


- (id) initWithContentsOfFile:(NSString *)path andOwner:(GamePiece *)piece
{
    
    _owner = piece;
    
    self = [super initWithContentsOfFile:path generateMipmaps:NO];
    

    
    
    return self;
}


- (id) initWithContentsOfFile:(NSString *)path
{
    
    // _owner = piece;
    
    self = [super initWithContentsOfFile:path generateMipmaps:NO];
    
    
    
    return self;
}

@end
