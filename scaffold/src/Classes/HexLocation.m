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

@implementation HexLocation


@synthesize tile = _tile;
@synthesize neighbours = _neighbours;
@synthesize stacks = _stacks;


-(id<JSONSerializable>) initFromJSON:(NSDictionary *)json{
    self = [super initFromJSON:json];
    
}

-(void) addStack:(Stack *)stack{
    [_stacks setObject:stack forKey:[stack locationID]];
}

-(void) removeStack: (Stack*) stack{
    [_stacks removeObjectForKey:[stack locationID]];
}


@end
