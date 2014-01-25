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
@synthesize bank = _bank;
@synthesize rack = _rack;
@synthesize hexLocations = _hexLocations;


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
