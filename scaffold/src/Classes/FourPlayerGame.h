//
//  FourPlayerGame.h
//  3004iPhone
//
//  Created by Richard Ison on 1/28/2014.
//
//

#import "SPImage.h"
#import <UIKit/UIDevice.h>

typedef NS_ENUM(NSInteger, GamePhase) {
    SETUP,
    PLACEMENT,
    RECRUITMENT,
    GOLD,
    MOVEMENT,
    COMBAT
} ;

typedef NS_ENUM(NSInteger, PlacementStep) {
    PLACE_CM_2,
    PLACE_CM_3,
    PLACE_FORT
} ;

@interface FourPlayerGame : SPSprite




@end
