//
//  Rack.h
//  3004iPhone
//
//  Created by John Marsh on 1/15/2014.
//
//

#import "BoardLocation.h"
#import "JSONSerializable.h"



@interface Rack : BoardLocation<JSONSerializable>{
    Player *_owner;
}

@property Player *owner;

-(id<JSONSerializable>) initFromJSON:(NSDictionary *)json withOwner:(Player*) player;


@end
