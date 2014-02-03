//
//  BoardLocation.m
//  3004iPhone
//
//  Created by John Marsh on 1/15/2014.
//
//

#import "BoardLocation.h"
#import "GamePiece.h"

@implementation BoardLocation

@synthesize locationID       = _locationID;
@synthesize locationName     = _locationName;
@synthesize pieces           = _pieces;



-(BoardLocation*) init{
    _locationID = [[NSString alloc] init];
    _locationName = [[NSString alloc] init];
    _pieces = [[NSMutableDictionary alloc] init];
    return [super init];
}

-(void) addGamePieceToLocation: (GamePiece*) piece{
    [_pieces setObject:piece forKey:[piece gamePieceID]];
}

-(GamePiece*) removePieceWithIdFromLocation: (NSString*) gamePieceId{
    GamePiece *tempPiece = [_pieces objectForKey:gamePieceId];
    [_pieces removeObjectForKey:gamePieceId];
    return tempPiece;
}

-(GamePiece*) getPieceWithIdFromLocation: (NSString*) gamePieceId{
    return [_pieces objectForKey:gamePieceId];
}


@end
