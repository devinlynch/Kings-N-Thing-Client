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

@implementation HexLocation


@synthesize tile = _tile;
@synthesize neighbourIds = _neighbourIds;
@synthesize stacks = _stacks;
@synthesize tileNumber = _tileNumber;
@synthesize owner = _owner;


-(id<JSONSerializable>) initFromJSON:(NSDictionary *)json{
    self = [super initFromJSON:json];
    
    _tile = [[GameResource getInstance] getTileForId:[[json objectForKey:@"hexTile"] objectForKey:@"id"]];
    _tileNumber = [[json objectForKey:@"hexNumber"] integerValue];
    
    _tile.location = self;
    _stacks = [[NSMutableDictionary alloc] init];

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
    }
    
    stack.stackImage.x = _tile.image.x + 10;
    stack.stackImage.y = _tile.image.y + 10;
    stack.stackImage.scaleX = 0.25f;
    stack.stackImage.scaleY = 0.25f;
    [[_tile.image parent] addChild:stack.stackImage];
    
    stack.location = self;
    [_stacks setObject:stack forKey:[stack locationId]];
}

-(void) removeStack: (Stack*) stack{
    [_stacks removeObjectForKey:[stack locationId]];
}

-(NSString*) description{
    return [NSString stringWithFormat:@"Tile with number %d", _tileNumber];
}


@end
