//
//  BoardLocation.m
//  3004iPhone
//
//  Created by John Marsh on 1/15/2014.
//
//

#import "BoardLocation.h"
#import "GamePiece.h"
#import "GameResource.h"

@implementation BoardLocation

@synthesize locationID   = _locationID;
@synthesize locationName = _locationName;
@synthesize pieces       = _pieces;
@synthesize ownerId      = _ownerId;


-(id<JSONSerializable>) initFromJSON:(NSDictionary *)json{
    self = [super init];
        if(self && json != nil) {
            _locationID = [[NSString alloc] initWithString:[json objectForKey:@"locationId"]];
            _ownerId = [[NSString alloc] initWithString:[json objectForKey:@"ownerId"]];
            
            NSArray *piecesJsonArr = [json objectForKey:@"gamePieces"];
            if(piecesJsonArr != nil){
                for(id o in piecesJsonArr) {
                    if(o != nil && ([o isKindOfClass:[NSDictionary class]])){
                        NSDictionary *gamePieceDic = (NSDictionary*) o;
                        GamePiece *piece = [[GameResource getInstance] getPieceForId:[gamePieceDic objectForKey:@"id"]];
                        [_pieces setValue:piece forKey:[piece gamePieceID]];
                    }
                }
            }

        }
    return self;
}


-(BoardLocation*) init{
    _locationID = [[NSString alloc] init];
    _locationName = [[NSString alloc] init];
    _pieces = [[NSMutableDictionary alloc] init];
    return [super init];
}

-(void) addGamePieceToLocation: (GamePiece*) piece{
    [_pieces setObject:piece forKey:[piece gamePieceID]];
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
