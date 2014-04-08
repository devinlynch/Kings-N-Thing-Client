//
//  GameResource.m
//  3004iPhone
//
//  Created by John Marsh on 2/6/2014.
//
//

#import "GameResource.h"
#import "Creature.h"
#import "HexTile.h"
#import "Fort.h"
#import "CityVill.h"
#import "NonCityVill.h"
#import "SpecialCharacter.h"
#import "Treasure.h"
#import "MagicItems.h"
#import "RandomEvent.h"

@implementation GameResource

static GameResource *instance;

+(GameResource*) getInstance{
    if (instance == nil) {
        instance = [[GameResource alloc] init];
    }
    return  instance;
}


-(GameResource*) init{
    self=[super init];
    _allPieces = [[NSMutableDictionary alloc] init];
    _creaturePieces = [Creature initializeAllCreatures];
    
    [_allPieces addEntriesFromDictionary:_creaturePieces];
    
    _tilePieces = [HexTile initializeTiles];
    [_allPieces addEntriesFromDictionary:_tilePieces];
    
    _fortPieces = [Fort initializeAllForts];
    [_allPieces addEntriesFromDictionary:_fortPieces];
    
    _cityVillPieces = [CityVill initializeAllCityVill];
    [_allPieces addEntriesFromDictionary: _cityVillPieces];
    
    _nonCityVillPieces = [NonCityVill initializeAllNonCityVill];
    [_allPieces addEntriesFromDictionary: _nonCityVillPieces];
    
    _specialCharacterPieces = [SpecialCharacter initializeAllSpecialCharacters];
    [_allPieces addEntriesFromDictionary: _specialCharacterPieces];
    
    _treasurePieces = [Treasure initializeAllTreasures];
    [_allPieces addEntriesFromDictionary: _treasurePieces];
    
    _magicPieces = [MagicItems initializeAllMagicItems];
    [_allPieces addEntriesFromDictionary: _magicPieces];
    
    _randomPieces = [RandomEvent initializeAllRandomEvent];
    [_allPieces addEntriesFromDictionary: _randomPieces];
    
    return self;
}

-(CityVill*) getCityVillForId: (NSString*) pieceId{
    return [_cityVillPieces objectForKey:pieceId];
}

-(NonCityVill*) getNonCityVillForId: (NSString*) pieceId{
    return [_nonCityVillPieces objectForKey:pieceId];
}

-(GamePiece*) getPieceForId: (NSString*) pieceId{
    return [_allPieces objectForKey:pieceId];
}


-(Creature*) getCreatureForId:(NSString *)pieceId{
    return [_creaturePieces objectForKey:pieceId];
}

-(HexTile*) getTileForId:(NSString *)pieceId{
    return [_tilePieces objectForKey:pieceId];
}

-(Fort*) getFortForId: (NSString*) pieceId{
    return [_fortPieces objectForKey:pieceId];
}
-(SpecialCharacter*) getSpecialCharacterForId: (NSString*) pieceId{
    return [_specialCharacterPieces objectForKeyedSubscript:pieceId];
}

-(RandomEvent*) getRandomEventForId:(NSString*) pieceId {
    return [_randomPieces objectForKey:pieceId];
}

-(NSMutableDictionary*) getAllSpecialChars{
    return _specialCharacterPieces;
}


@end
