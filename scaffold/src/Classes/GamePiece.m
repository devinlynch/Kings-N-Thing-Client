//
//  GamePiece.m
//  3004iPhone
//
//  Created by John Marsh on 1/15/2014.
//
//

#import "GamePiece.h"

@implementation GamePiece

@synthesize gamePieceID = _gamePieceID;


-(GamePiece*) initWithImageFileName:(NSString*)name{
    _image = [[ScaledGamePiece alloc]initWithContentsOfFile:name];
    return [super init];
}

@end
