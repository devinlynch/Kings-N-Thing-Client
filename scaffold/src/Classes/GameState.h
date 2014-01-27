//
//  GameState.h
//  3004iPhone
//
//  Created by Devin Lynch on 2014-01-26.
//
//

#import <Foundation/Foundation.h>
#import "JSONSerializable.h"
@interface GameState : NSObject<JSONSerializable>
{
    NSMutableArray *_players;
}

@property NSMutableArray *players;
@end
