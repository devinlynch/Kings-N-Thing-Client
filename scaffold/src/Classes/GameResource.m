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

@implementation GameResource

static GameResource *instance;

+(GameResource*) getInstance{
    if (instance == nil) {
        instance = [self init];
    }
    return  instance;
}


-(GameResource*) init{
    _allPieces = [[NSMutableDictionary alloc] init];
    _creaturePieces = [Creature initializeAllCreatures];
    [_allPieces addEntriesFromDictionary:_creaturePieces];
    _tilePieces = [HexTile initializeTiles];
    [_allPieces addEntriesFromDictionary:_creaturePieces];
    return [super init];
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


@end
