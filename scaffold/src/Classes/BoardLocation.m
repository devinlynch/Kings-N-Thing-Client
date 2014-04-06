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
#import "AIPlayer.h"

@implementation BoardLocation

@synthesize locationId   = _locationId;
@synthesize locationName = _locationName;
@synthesize pieces       = _pieces;
@synthesize gameState;


-(id<JSONSerializable>) initFromJSON:(NSDictionary *)json{
    self = [super init];
        if(self && json != nil) {
            _locationId = [[NSString alloc] initWithString:[json objectForKey:@"locationId"]];
            
            if([json objectForKey:@"name"] != nil && ! [[json objectForKey:@"name"] isKindOfClass:[NSNull class]])
                _locationName = [[NSString alloc] initWithString:[json objectForKey:@"name"]];

            
            NSArray *piecesJsonArr = [json objectForKey:@"gamePieces"];
            
            _pieces = [[NSMutableDictionary alloc] init];

            if(piecesJsonArr != nil){
                for(id o in piecesJsonArr) {
                    if(o != nil && ([o isKindOfClass:[NSDictionary class]])){
                        NSDictionary *gamePieceDic = (NSDictionary*) o;
                        GamePiece *piece = [[GameResource getInstance] getPieceForId:[gamePieceDic objectForKey:@"id"]];
                        [self addGamePieceToLocation:piece];
                    }
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
    [piece.pieceImage removeFromParent];
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

-(void) updateLocationWithPieces: (NSArray*) array{
    for(NSDictionary *pieceMap in array) {
        if(! [pieceMap isKindOfClass:[NSDictionary class]])
            continue;
        
        NSString *pieceId = [pieceMap objectForKey:@"id"];

        if(pieceId == nil || [_pieces objectForKey:pieceId] != nil) {
            continue;
        }
        
        GamePiece *piece = [[GameResource getInstance] getPieceForId:pieceId];
        
        [self addGamePieceToLocation:piece];
        [piece updateFromSerializedJson:pieceMap forGameState:[[Game currentGame] gameState]];
    }
}

-(void) updateLocationFromSerializedJSONDictionary: (NSDictionary*) dic{
    if(dic != nil && [dic isKindOfClass:[NSDictionary class]]) {
        [self setLocationId:[dic objectForKey:@"locationId"]];
        
        if([dic objectForKey:@"name"] != nil)
            [self setLocationName:[dic objectForKey:@"name"]];
        
        if([dic objectForKey:@"gamePieces"] != nil && [[dic objectForKey:@"gamePieces"] isKindOfClass:[NSArray class]]){
            [self updateLocationWithPieces:[dic objectForKey:@"gamePieces"]];
        }
    }
}

-(NSArray*) getAllPiecesForPlayer: (Player*) p{
    NSMutableArray *pieces  = [[NSMutableArray alloc] init];
    
    NSEnumerator *enumerator = [_pieces keyEnumerator];
    id key;
    while ((key = [enumerator nextObject])) {
        GamePiece *gp = [_pieces objectForKey:key];
        if(gp != nil) {
            if([p isKindOfClass:[AIPlayer class]] && gp.owner == nil)
                [pieces addObject:gp];
            else if(gp.owner == p)
               [pieces addObject:gp];
        }
    }
    return pieces;
}



@end
