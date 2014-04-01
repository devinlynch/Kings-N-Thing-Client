//
//  HexLocation.m
//  3004iPhone
//
//  Created by John Marsh on 1/15/2014.
//
//

#import "HexLocation.h"
#import "HexTile.h"
#import "Stack.h"
#import "GameResource.h"
#import "Player.h"
#import "ScaledGamePiece.h"
#import "GameState.h"
#import "Game.h"
#import "Terrain.h"

@implementation HexLocation


@synthesize tile = _tile;
@synthesize neighbourIds = _neighbourIds;
@synthesize stacks = _stacks;
@synthesize tileNumber = _tileNumber;
@synthesize owner = _owner;
@synthesize isStartingPoint = _isStartingPoint;
@synthesize visited = _visited;


-(id<JSONSerializable>) initFromJSON:(NSDictionary *)json{
    self = [super initFromJSON:json];
    
    _tile = [[GameResource getInstance] getTileForId:[[json objectForKey:@"hexTile"] objectForKey:@"id"]];
    _tileNumber = [[json objectForKey:@"hexNumber"] integerValue];
    
    _tile.location = self;
    _stacks = [[NSMutableDictionary alloc] init];
    _visited = NO;
    
    switch (_tileNumber) {
        case 19:
            _isStartingPoint = YES;
            break;
        case 32:
            _isStartingPoint = YES;
            break;
        case 28:
            _isStartingPoint = YES;
            break;
        case 23:
            _isStartingPoint = YES;
            break;
        default:
            _isStartingPoint = NO;
            break;
    }
    
    switch(_tileNumber) {
        case 0: {
            _neighbourIds = [[NSArray alloc] initWithObjects:@"hexLocation_1",@"hexLocation_2",@"hexLocation_3",@"hexLocation_4",@"hexLocation_5",@"hexLocation_6", nil];
        }
            break;
        case 1: {
            _neighbourIds = [[NSArray alloc] initWithObjects:@"hexLocation_8",@"hexLocation_9",@"hexLocation_2",@"hexLocation_0",@"hexLocation_6",@"hexLocation_7", nil];
        }
            break;
        case 2: {
            _neighbourIds = [[NSArray alloc] initWithObjects:@"hexLocation_1",@"hexLocation_9",@"hexLocation_10",@"hexLocation_11",@"hexLocation_3",@"hexLocation_0", nil];
        }
            break;
        case 3: {
            _neighbourIds = [[NSArray alloc] initWithObjects:@"hexLocation_2",@"hexLocation_11",@"hexLocation_12",@"hexLocation_13",@"hexLocation_4",@"hexLocation_0", nil];
        }
            break;
        case 4: {
            _neighbourIds = [[NSArray alloc] initWithObjects:@"hexLocation_0",@"hexLocation_3",@"hexLocation_13",@"hexLocation_14",@"hexLocation_15",@"hexLocation_5", nil];
        }
            break;
        case 5: {
            _neighbourIds = [[NSArray alloc] initWithObjects:@"hexLocation_6",@"hexLocation_0",@"hexLocation_4",@"hexLocation_15",@"hexLocation_16",@"hexLocation_17", nil];
        }
            break;
        case 6: {
            _neighbourIds = [[NSArray alloc] initWithObjects:@"hexLocation_7",@"hexLocation_1",@"hexLocation_0",@"hexLocation_5",@"hexLocation_17",@"hexLocation_18", nil];
        }
            break;
        case 7: {
            _neighbourIds = [[NSArray alloc] initWithObjects:@"hexLocation_20",@"hexLocation_8",@"hexLocation_1",@"hexLocation_6",@"hexLocation_18",@"hexLocation_19", nil];
        }
            break;
        case 8: {
            _neighbourIds = [[NSArray alloc] initWithObjects:@"hexLocation_21",@"hexLocation_22",@"hexLocation_9",@"hexLocation_1",@"hexLocation_7",@"hexLocation_20", nil];
        }
            break;
        case 9: {
            _neighbourIds = [[NSArray alloc] initWithObjects:@"hexLocation_22",@"hexLocation_23",@"hexLocation_10",@"hexLocation_2",@"hexLocation_1",@"hexLocation_8", nil];
        }
            break;
        case 10: {
            _neighbourIds = [[NSArray alloc] initWithObjects:@"hexLocation_23",@"hexLocation_24",@"hexLocation_25",@"hexLocation_11",@"hexLocation_2",@"hexLocation_9", nil];
        }
            break;
        case 11: {
            _neighbourIds = [[NSArray alloc] initWithObjects:@"hexLocation_10",@"hexLocation_25",@"hexLocation_26",@"hexLocation_12",@"hexLocation_3",@"hexLocation_2", nil];
        }
            break;
        case 12: {
            _neighbourIds = [[NSArray alloc] initWithObjects:@"hexLocation_11",@"hexLocation_26",@"hexLocation_27",@"hexLocation_28",@"hexLocation_13",@"hexLocation_3", nil];
        }
            break;
        case 13: {
            _neighbourIds = [[NSArray alloc] initWithObjects:@"hexLocation_3",@"hexLocation_12",@"hexLocation_28",@"hexLocation_29",@"hexLocation_14",@"hexLocation_4", nil];
        }
            break;
        case 14: {
            _neighbourIds = [[NSArray alloc] initWithObjects:@"hexLocation_4",@"hexLocation_13",@"hexLocation_29",@"hexLocation_30",@"hexLocation_31",@"hexLocation_15", nil];
        }
            break;
        case 15: {
            _neighbourIds = [[NSArray alloc] initWithObjects:@"hexLocation_5",@"hexLocation_4",@"hexLocation_14",@"hexLocation_31",@"hexLocation_32",@"hexLocation_16", nil];
        }
            break;
        case 16: {
            _neighbourIds = [[NSArray alloc] initWithObjects:@"hexLocation_17",@"hexLocation_5",@"hexLocation_15",@"hexLocation_32",@"hexLocation_33",@"hexLocation_34", nil];
        }
            break;
        case 17: {
            _neighbourIds = [[NSArray alloc] initWithObjects:@"hexLocation_18",@"hexLocation_6",@"hexLocation_5",@"hexLocation_16",@"hexLocation_34",@"hexLocation_35", nil];
        }
            break;
        case 18: {
            _neighbourIds = [[NSArray alloc] initWithObjects:@"hexLocation_19",@"hexLocation_7",@"hexLocation_6",@"hexLocation_17",@"hexLocation_35",@"hexLocation_36", nil];
        }
            break;
        case 19: {
            _neighbourIds = [[NSArray alloc] initWithObjects:@"hexLocation_20",@"hexLocation_7",@"hexLocation_18",@"hexLocation_36", nil];
        }
            break;
        case 20: {
            _neighbourIds = [[NSArray alloc] initWithObjects:@"hexLocation_21",@"hexLocation_8",@"hexLocation_7",@"hexLocation_19", nil];
        }
            break;
        case 21: {
            _neighbourIds = [[NSArray alloc] initWithObjects:@"hexLocation_22",@"hexLocation_8",@"hexLocation_20", nil];
        }
            break;
        case 22: {
            _neighbourIds = [[NSArray alloc] initWithObjects:@"hexLocation_21",@"hexLocation_8",@"hexLocation_9",@"hexLocation_23", nil];
        }
            break;
        case 23: {
            _neighbourIds = [[NSArray alloc] initWithObjects:@"hexLocation_22",@"hexLocation_9",@"hexLocation_10",@"hexLocation_24", nil];
        }
            break;
        case 24: {
            _neighbourIds = [[NSArray alloc] initWithObjects:@"hexLocation_23",@"hexLocation_10",@"hexLocation_25", nil];
        }
            break;
        case 25: {
            _neighbourIds = [[NSArray alloc] initWithObjects:@"hexLocation_24",@"hexLocation_10",@"hexLocation_11",@"hexLocation_26", nil];
        }
            break;
        case 26: {
            _neighbourIds = [[NSArray alloc] initWithObjects:@"hexLocation_25",@"hexLocation_11",@"hexLocation_12",@"hexLocation_27", nil];
        }
            break;
        case 27: {
            _neighbourIds = [[NSArray alloc] initWithObjects:@"hexLocation_26",@"hexLocation_12",@"hexLocation_28", nil];
        }
            break;
        case 28: {
            _neighbourIds = [[NSArray alloc] initWithObjects:@"hexLocation_29",@"hexLocation_13",@"hexLocation_12",@"hexLocation_27", nil];
        }
            break;
        case 29: {
            _neighbourIds = [[NSArray alloc] initWithObjects:@"hexLocation_13",@"hexLocation_28",@"hexLocation_30",@"hexLocation_14", nil];
        }
            break;
        case 30: {
            _neighbourIds = [[NSArray alloc] initWithObjects:@"hexLocation_31",@"hexLocation_14",@"hexLocation_29", nil];
        }
            break;
        case 31: {
            _neighbourIds = [[NSArray alloc] initWithObjects:@"hexLocation_32",@"hexLocation_15",@"hexLocation_14",@"hexLocation_30", nil];
        }
            break;
        case 32: {
            _neighbourIds = [[NSArray alloc] initWithObjects:@"hexLocation_33",@"hexLocation_16",@"hexLocation_15",@"hexLocation_31", nil];
        }
            break;
        case 33: {
            _neighbourIds = [[NSArray alloc] initWithObjects:@"hexLocation_34",@"hexLocation_16",@"hexLocation_32", nil];
        }
            break;
        case 34: {
            _neighbourIds = [[NSArray alloc] initWithObjects:@"hexLocation_35",@"hexLocation_17",@"hexLocation_16",@"hexLocation_33", nil];
        }
            break;
        case 35: {
            _neighbourIds = [[NSArray alloc] initWithObjects:@"hexLocation_36",@"hexLocation_18",@"hexLocation_17",@"hexLocation_34", nil];
        }
            break;
        case 36: {
            _neighbourIds = [[NSArray alloc] initWithObjects:@"hexLocation_19",@"hexLocation_18",@"hexLocation_35", nil];
        }
            break;
    }
    
    return self;
}

-(void) addGamePieceToLocation: (GamePiece*) piece{
    [super addGamePieceToLocation:piece];
    
    SPTween *tween = [SPTween tweenWithTarget:piece.pieceImage time:0.25f
                                   transition:SP_TRANSITION_LINEAR];
    

    [tween animateProperty:@"x" targetValue:_tile.image.x + 10];
    [tween animateProperty:@"y" targetValue:_tile.image.y + 10];
    [tween animateProperty:@"scaleX" targetValue:0.25f];
    [tween animateProperty:@"scaleY" targetValue:0.25f];
    
    [Sparrow.juggler addObject:tween];

    [[_tile.image parent] addChild:piece.pieceImage];
}


-(void) changeOwnerToPlayer: (Player*) player{
    _owner = player;
    _tile.owner = player;
    [_tile changeOwnerTo: player.playerId];
}

-(void) addStack:(Stack *)stack{
    if(stack.location != nil && ! [stack.location isKindOfClass:[NSNull class]]) {
        [stack.location removeStack:stack];
    }
    
    if (stack.stackImage == nil) {
        stack.stackImage = [[ScaledGamePiece alloc] initWithContentsOfFile:@"T_Back.png"];
        [stack.stackImage setOwner:(id<NSCopying>)stack];
    }
    
    SPTween *tween = [SPTween tweenWithTarget:stack.stackImage time:0.25f
                                   transition:SP_TRANSITION_LINEAR];
    
    
    [tween animateProperty:@"x" targetValue:_tile.image.x + 10];
    [tween animateProperty:@"y" targetValue:_tile.image.y + 10];
    [tween animateProperty:@"scaleX" targetValue:0.25f];
    [tween animateProperty:@"scaleY" targetValue:0.25f];
    
    [Sparrow.juggler addObject:tween];

    [[_tile.image parent] addChild:stack.stackImage];
    
    stack.location = self;
    [_stacks setObject:stack forKey:[stack locationId]];
}

-(void) removeStack: (Stack*) stack{
    [_stacks removeObjectForKey:[stack locationId]];
}

-(BOOL) hasNeighbourOwnedByPlayer: (Player*) player{
    for (NSString *hexId in _neighbourIds) {
        if ([[[[[Game currentGame] gameState] hexLocations] objectForKey:hexId] owner] == player) {
            return YES;
        }
    }
    return NO;
}


-(NSString*) description{
    return [NSString stringWithFormat:@"Tile with number %d", _tileNumber];
}

-(void) hilightPossibleMoves{
    [self hilightPossibleMovesRecursive:5];
}

-(void) hilightPossibleMovesRecursive: (int) movesLeft{
    
    if(movesLeft <= 0){
        return;
    }
    
    [self setVisited:YES];
    
    [self.tile hilight];
    
    for (NSString *hexId in _neighbourIds) {
        HexLocation *location = [[[[Game currentGame] gameState] hexLocations] objectForKey:hexId];
        if(!location.visited && ![location.tile.terrain isEqual:[Terrain getSeaInstance]]){
           // swamp, mountain, forest and jungle hex cost 2
            if ([location.tile.terrain isEqual:[Terrain getSwampInstance]] ||
                [location.tile.terrain isEqual:[Terrain getForestInstance]] ||
                [location.tile.terrain isEqual:[Terrain getMountainInstance]] ||
                [location.tile.terrain isEqual:[Terrain getJungleInstance]]) {
                [location hilightPossibleMovesRecursive:movesLeft-2];
            } else{
                [location hilightPossibleMovesRecursive:movesLeft-1];
            }
        }
    }
    [self setVisited:NO];
}


@end
