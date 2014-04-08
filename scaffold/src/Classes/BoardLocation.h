//
//  BoardLocation.h
//  3004iPhone
//
//  Created by John Marsh on 1/15/2014.
//
//

#import <Foundation/Foundation.h>
#import "JSONSerializable.h"

@class GamePiece, Player, GameState;

@interface BoardLocation : NSObject{
    NSString *_locationId;
    NSString *_locationName;
    NSMutableDictionary *_pieces;
}

@property NSString *locationId, *locationName;
@property NSMutableDictionary *pieces;
@property GameState *gameState;


-(BoardLocation*) init;

-(void) addGamePieceToLocation: (GamePiece*) piece;

-(GamePiece*) removePieceWithIdFromLocation: (NSString*) gamePieceId;

-(GamePiece*) getPieceWithIdFromLocation: (NSString*) gamePieceId;

-(void) updateLocationWithPieces: (NSArray*) array;

-(void) updateLocationFromSerializedJSONDictionary: (NSDictionary*) dic;

-(NSArray*) getAllPiecesForPlayer: (Player*) p;

-(id) initFromJSON:(NSDictionary *)json withGameState: (GameState*) gameState;

@end
