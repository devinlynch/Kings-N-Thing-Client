//
//  BoardLocation.h
//  3004iPhone
//
//  Created by John Marsh on 1/15/2014.
//
//

#import <Foundation/Foundation.h>
#import "JSONSerializable.h"

@class GamePiece, Player;

@interface BoardLocation : NSObject<JSONSerializable>{
    NSString *_locationId;
    NSString *_locationName;
    NSMutableDictionary *_pieces;
}

@property NSString *locationId, *locationName;
@property NSMutableDictionary *pieces;


-(BoardLocation*) init;

-(void) addGamePieceToLocation: (GamePiece*) piece;

-(GamePiece*) removePieceWithIdFromLocation: (NSString*) gamePieceId;

-(GamePiece*) getPieceWithIdFromLocation: (NSString*) gamePieceId;



@end
