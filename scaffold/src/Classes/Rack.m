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
#import "Player.h"

@implementation Rack

@synthesize owner = _owner;

-(id) initFromJSON:(NSDictionary *)json withOwner:(Player*) player{
    self = [super init];
    if(self && json != nil) {
        _locationId = [[NSString alloc] initWithString:[json objectForKey:@"locationId"]];
        
        NSArray *piecesJsonArr = [json objectForKey:@"gamePieces"];
        if(piecesJsonArr != nil){
            for(id o in piecesJsonArr) {
                if(o != nil && ([o isKindOfClass:[NSDictionary class]])){
                    NSDictionary *gamePieceDic = (NSDictionary*) o;
                    GamePiece *piece = [[GameResource getInstance] getPieceForId:[gamePieceDic objectForKey:@"id"]];
                    
                    [self addGamePieceToLocation:piece];
                    [player assignPiece:piece];
                    [_pieces setValue:piece forKey:[piece gamePieceId]];
                }
            }
        }
        
    }
    return self;
}

-(void) addGamePieceToLocation:(GamePiece *)piece {
    [super addGamePieceToLocation:piece];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"rackUpdated" object:self];
}
@end
