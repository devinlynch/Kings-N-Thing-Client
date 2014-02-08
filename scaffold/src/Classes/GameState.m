//
//  GameState.m
//  3004iPhone
//
//  Created by Devin Lynch on 2014-01-26.
//
//

#import "GameState.h"
#import "Player.h"
#import "Game.h"
#import "PlayingCup.h"
#import "Bank.h"
#import "HexLocation.h"
#import "Creature.h"


@implementation GameState

@synthesize players = _players;
@synthesize game = _game;

-(id<JSONSerializable>)initFromJSON:(NSDictionary*) json{
    self = [super init];
    if(self && json != nil) {
        NSArray *playersJsonArr = [json objectForKey:@"players"];
        if(playersJsonArr != nil){
            [self setPlayers:[[NSMutableArray alloc] init]];
            for(id o in playersJsonArr) {
                if(o != nil && ([o isKindOfClass:[NSDictionary class]])){
                    NSDictionary *playerDic = (NSDictionary*) o;
                    Player *u = [[Player alloc] initFromJSON:playerDic];
                    [self.players addObject:u];
                }
            }
        }
        _playingCup = [[PlayingCup alloc] initFromJSON:[json objectForKey:@"playingCup"]];
        NSArray *hexLocationJsonArr = [json objectForKey:@"hexLocations"];
        NSMutableDictionary *locationDic = [[NSMutableDictionary alloc] init];
        if(hexLocationJsonArr != nil){
            for(id o in hexLocationJsonArr) {
                if(o != nil && ([o isKindOfClass:[NSDictionary class]])){
                    [locationDic setObject:[[HexLocation alloc] initFromJSON:o] forKey:[o objectForKey:@"locationId"]];
                }
            }
            _hexLocations = locationDic;
        }
    }
    return self;
}


-(void)findPathFromLocation:(HexLocation *)location withMoves:(int)moves{
    
    if(location.tile.isHilighted){
        return;
    }
    
    if (moves == 0) {
        [[location tile] hilight];
        return;
    }
    else{
        [[location tile] hilight];
    }
    
    for (HexLocation *tileLocation in [location neighbours]){
        [self findPathFromLocation:tileLocation withMoves:--moves];
    }
    
    
    
}



@end
