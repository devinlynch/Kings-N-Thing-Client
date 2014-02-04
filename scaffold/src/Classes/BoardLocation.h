//
//  BoardLocation.h
//  3004iPhone
//
//  Created by John Marsh on 1/15/2014.
//
//

#import <Foundation/Foundation.h>

@class GamePiece, Player;

@interface BoardLocation : NSObject{
    NSString *_locationID;
    NSString *_locationName;
    NSMutableDictionary *_pieces;
    Player *_owner;
}

@property NSString *locationID, *locationName;
@property NSMutableDictionary *pieces;
@property Player *owner;


-(BoardLocation*) init;

-(void) addGamePieceToLocation: (GamePiece*) piece;

-(GamePiece*) removePieceWithIdFromLocation: (NSString*) gamePieceId;

-(GamePiece*) getPieceWithIdFromLocation: (NSString*) gamePieceId;



@end
