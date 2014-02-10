//
//  Rack.m
//  3004iPhone
//
//  Created by John Marsh on 1/15/2014.
//
//

#import "Rack.h"
#import "GameResource.h"
#import "GamePiece.h"

@implementation Rack

@synthesize owner = _owner;

-(id<JSONSerializable>) initFromJSON:(NSDictionary *)json withOwner:(Player*) player{
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
                    piece.owner  = player;
                    [_pieces setValue:piece forKey:[piece gamePieceId]];
                }
            }
        }
        
    }
    return self;
}
@end
