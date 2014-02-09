//
//  BoardLocation.m
//  3004iPhone
//
//  Created by John Marsh on 1/15/2014.
//
//

#import "BoardLocation.h"
#import "GamePiece.h"
#import "Creature.h"
#import "GameResource.h"

@implementation BoardLocation

@synthesize locationId   = _locationId;
@synthesize locationName = _locationName;
@synthesize pieces       = _pieces;





-(BoardLocation*) init{
    _locationId = [[NSString alloc] init];
    _locationName = [[NSString alloc] init];
    _pieces = [[NSMutableDictionary alloc] init];
    return [super init];
}

-(void) addGamePieceToLocation: (GamePiece*) piece{
    
    [piece.location removePieceWithIdFromLocation:piece.gamePieceId];
    
    piece.location = self;
    
    [_pieces setObject:piece forKey:[piece gamePieceId]];
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
