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
    

    return self;
}


-(void) addStack:(Stack *)stack{
    [_stacks setObject:stack forKey:[stack locationId]];
}

-(void) removeStack: (Stack*) stack{
    [_stacks removeObjectForKey:[stack locationId]];
}

-(NSString*) description{
    return [NSString stringWithFormat:@"Tile with number %d", _tileNumber];
}


@end
