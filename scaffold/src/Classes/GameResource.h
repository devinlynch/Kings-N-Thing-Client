//
//  GameResource.h
//  3004iPhone
//
//  Created by John Marsh on 2/6/2014.
//
//

#import <Foundation/Foundation.h>

@class GamePiece, Creature, HexTile, Fort, CityVill, NonCityVill, SpecialCharacter,RandomEvent;

@interface GameResource : NSObject{
    NSMutableDictionary *_allPieces;
    NSMutableDictionary *_creaturePieces;
    NSMutableDictionary *_tilePieces;
    NSMutableDictionary *_fortPieces;
    NSMutableDictionary *_magicPieces;
    NSMutableDictionary *_treasurePieces;
    NSMutableDictionary *_randomPieces;
    NSMutableDictionary *_cityVillPieces;
    NSMutableDictionary *_nonCityVillPieces;
    NSMutableDictionary *_specialCharacterPieces;

}


+(GameResource*) getInstance;

-(GameResource*) init;

-(GamePiece*) getPieceForId: (NSString*) pieceId;


-(Creature*) getCreatureForId: (NSString*) pieceId;
-(HexTile*) getTileForId: (NSString*) pieceId;
-(Fort*) getFortForId: (NSString*) pieceId;
-(CityVill*) getCityVillForId: (NSString*) pieceId;
-(NonCityVill*) getNonCityVillForId: (NSString*) pieceId;
-(SpecialCharacter*) getSpecialCharacterForId: (NSString*) pieceId;
-(RandomEvent*) getRandomEventForId: (NSString*) pieceId;


@end
