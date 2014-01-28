//
//  Game.m
//  3004iPhone
//
//  Created by John Marsh on 1/21/2014.
//
//

#import "Game.h"

@implementation Game


@synthesize bank = _bank;
@synthesize rack = _rack;
@synthesize hexLocations = _hexLocations;
@synthesize users = _users;

-(id<JSONSerializable>)initFromJSON:(NSDictionary*) json{
    self=[super init];
    if(self && json != nil) {
        NSArray *playersJsonArr = [json objectForKey:@"players"];
        if(playersJsonArr != nil){
            [self setUsers:[[NSMutableArray alloc] init]];
            for(id o in playersJsonArr) {
                if(o != nil && ([o isKindOfClass:[NSDictionary class]])){
                    NSDictionary *playerDic = (NSDictionary*) o;
                    User *u = [[User alloc] initFromJSON:playerDic];
                    [self.users addObject:u];
                }
            }
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
