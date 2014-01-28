//
//  GameState.h
//  3004iPhone
//
//  Created by Devin Lynch on 2014-01-26.
//
//

#import <Foundation/Foundation.h>
#import "JSONSerializable.h"

@class Game;

@interface GameState : NSObject<JSONSerializable>{
    NSMutableArray *_players;
    Game *_game;
}

@property NSMutableArray *players;
@property Game *game;

@end
