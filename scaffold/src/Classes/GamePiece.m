//
//  GamePiece.m
//  3004iPhone
//
//  Created by John Marsh on 1/15/2014.
//
//

#import "GamePiece.h"

@implementation GamePiece

@synthesize gamePieceId = _gamePieceId;
@synthesize pieceImage  = _pieceImage;
@synthesize location    = _location;
@synthesize owner     = _owner;
@synthesize fileName  = _fileName;
@synthesize name = _name;
@synthesize isBluff = _isBluff;
@synthesize bluffImage = _bluffImage;

-(id) init{
    self = [super init];
    if(self) {
        _owner = nil;
        _location=nil;
        _pieceImage=nil;
        _gamePieceId=nil;
    }
    return self;
}


@end
