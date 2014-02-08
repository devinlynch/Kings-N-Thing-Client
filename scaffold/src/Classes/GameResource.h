//
//  GameResource.h
//  3004iPhone
//
//  Created by John Marsh on 2/6/2014.
//
//

#import <Foundation/Foundation.h>

@class GamePiece, Creature, HexTile;

@interface GameResource : NSObject{
    NSMutableDictionary *_allPieces;
    NSMutableDictionary *_creaturePieces;
    NSMutableDictionary *_tilePieces;
    NSMutableDictionary *_fortPieces;
    NSMutableDictionary *_magicPieces;
    NSMutableDictionary *_treasurePieces;
    NSMutableDictionary *_randomPieces;

}


+(GameResource*) getInstance;

-(GamePiece*) getPieceForId: (NSString*) pieceId;


-(Creature*) getCreatureForId: (NSString*) pieceId;
-(HexTile*) getTileForId: (NSString*) pieceId;

@end
