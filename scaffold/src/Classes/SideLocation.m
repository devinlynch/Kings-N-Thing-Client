//
//  SideLocation.m
//  3004iPhone
//
//  Created by Richard Ison on 2/8/2014.
//
//

#import "SideLocation.h"
#import "GamePiece.h"
#import "GameResource.h"

@implementation SideLocation

@synthesize sidePieces = _sidePieces;



-(id <JSONSerializable>) initFromJSON:(NSDictionary *)json{
    self = [super init];
    if (self && json != nil){
        _locationId = [[NSString alloc] initWithString:[json objectForKey:@"locationId"]];
        _ownerId = [[NSString alloc] initWithString:[json objectForKey:@"ownerId"]];
        
        
        
        NSArray *sidePiecesJsonArr = [json objectForKey:@"sideLocation"];
        if (sidePiecesJsonArr != nil){
            for(id o in sidePiecesJsonArr){
                if (o != nil && ([o isKindOfClass:[NSDictionary class]])) {
                    NSDictionary *sideGamePieceDic = (NSDictionary*) o;
                    GamePiece *piece = [[GameResource getInstance] getPieceForId:[sideGamePieceDic objectForKey:@"id"]];
                    [_pieces setValue:piece forKey:[piece gamePieceId]];
                }
            }
        }
    }

    return self;
}


-(SideLocation*) init{
    _locationId = [[NSString alloc] init];
    _locationName = [[NSString alloc] init];
    _sidePieces = [[NSMutableDictionary alloc]init];
    
    return [super init];
}






@end
