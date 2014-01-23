//
//  Game.m
//  3004iPhone
//
//  Created by John Marsh on 1/21/2014.
//
//

#import "Game.h"

@implementation Game

@synthesize players = _players;


-(void)findPathFromTile:(HexTile *)location withMoves:(int)moves{
    
    if(location.isHilighted){
        return;
    }
    
    if (moves == 0) {
        [location hilight];
        return;
    }
    else{
        [location hilight];
    }
    
    for (HexTile *tile in [location neighbours]){
        [self findPathFromTile:tile withMoves:--moves];
    }
    
    

}

@end
