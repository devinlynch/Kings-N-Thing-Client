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

@implementation GameResource

static GameResource *instance;

+(GameResource*) getInstance{
    if (instance == nil) {
        instance = [[GameResource alloc] init];
    }
    return  instance;
}


-(GameResource*) init{
    
    _allPieces = [[NSMutableDictionary alloc] init];
    _creaturePieces = [Creature initializeAllCreatures];
    
    [_allPieces addEntriesFromDictionary:_creaturePieces];
    
    _tilePieces = [HexTile initializeTiles];
    [_allPieces addEntriesFromDictionary:_creaturePieces];
    
    _fortPieces = [Fort initializeAllForts];
    [_allPieces addEntriesFromDictionary:_fortPieces];
    
    _cityVillPieces = [CityVill initializeAllCityVill];
    [_allPieces addEntriesFromDictionary: _cityVillPieces];
    
    _nonCityVillPieces = [NonCityVill initializeAllNonCityVill];
    [_allPieces addEntriesFromDictionary: _nonCityVillPieces];
    
    return [super init];
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



@end
