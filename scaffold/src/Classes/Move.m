//
//  Move.m
//  3004iPhone
//
//  Created by John Marsh on 1/28/2014.
//
//

#import "Move.h"

@implementation Move

@synthesize moveMadeByID = _moveMadeByID;
@synthesize pieceID = _pieceID;
@synthesize destinationID = _destinationID;
@synthesize originID = _originID;

-(Move*) initWithMoveMadeBy:(NSString *)moveMadeBy movingPiece:(NSString *)gamePiece toDestination:(NSString *)destination fromOrigin:(NSString *)origin{
    self=[super init];
    _moveMadeByID = moveMadeBy;
    _pieceID = gamePiece;
    _destinationID = destination;
    _originID = origin;
    return self;
}

@end
