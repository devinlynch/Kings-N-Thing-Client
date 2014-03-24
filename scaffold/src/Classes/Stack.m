//
//  Stack.m
//  3004iPhone
//
//  Created by John Marsh on 1/28/2014.
//
//

#import "Stack.h"
#import "HexLocation.h"
#import "GamePiece.h"
#import "ScaledGamePiece.h"

@implementation Stack

@synthesize location = _location;
@synthesize owner = _owner;
@synthesize stackImage = _stackImage;

-(void) addGamePieceToLocation:(GamePiece *)piece{
    [super addGamePieceToLocation:piece];
    [piece.pieceImage removeFromParent];
}

@end
