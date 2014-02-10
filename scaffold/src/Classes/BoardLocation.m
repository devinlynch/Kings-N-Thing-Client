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
#import "Game.h"
#import "GameState.h"

@implementation BoardLocation

@synthesize locationId   = _locationId;
@synthesize locationName = _locationName;
@synthesize pieces       = _pieces;


-(id<JSONSerializable>) initFromJSON:(NSDictionary *)json{
    self = [super init];
    if(self && json != nil) {
        _locationId = [[NSString alloc] initWithString:[json objectForKey:@"locationId"]];
        
        NSArray *piecesJsonArr = [json objectForKey:@"gamePieces"];
        if(piecesJsonArr != nil){
            for(id o in piecesJsonArr) {
                if(o != nil && ([o isKindOfClass:[NSDictionary class]])){
                    NSDictionary *gamePieceDic = (NSDictionary*) o;
                    GamePiece *piece = [[GameResource getInstance] getPieceForId:[gamePieceDic objectForKey:@"id"]];
                    piece.location = self;
                    
                    NSString *ownerId = [gamePieceDic objectForKey:@"ownerId"];
                    if(ownerId != nil && ![ownerId isKindOfClass:[NSNull class]]){
                        Game *currentGame = [Game currentGame];
                        if(currentGame != nil) {
                            GameState *gameState = [currentGame gameState];
                            if(gameState != nil) {
                                Player *p = [gameState getPlayerById:ownerId];
                                piece.owner=p;
                            }
                        }
                    }
                    [_pieces setValue:piece forKey:[piece gamePieceId]];
                }
            }

        }
    return self;
}


-(BoardLocation*) init{
    self=[super init];
    _locationId = [[NSString alloc] init];
    _locationName = [[NSString alloc] init];
    _pieces = [[NSMutableDictionary alloc] init];
    return self;
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
