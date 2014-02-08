//
//  GameResource.m
//  3004iPhone
//
//  Created by John Marsh on 2/6/2014.
//
//

#import "GameResource.h"
#import "Creature.h"

@implementation GameResource

static GameResource *instance;

+(GameResource*) getInstance{
    if (instance == nil) {
        instance = [self init];
    }
    return  instance;
}


-(GameResource*) init{
    _gamePiece = [Creature initializeAllCreatures];

    return [super init];
}


-(GamePiece*) getPieceForId:(NSString *)pieceId{
    return [_gamePieces objectForKey:pieceId];
}


@end
