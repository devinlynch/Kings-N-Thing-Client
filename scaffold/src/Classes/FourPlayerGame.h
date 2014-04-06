//
//  FourPlayerGame.h
//  3004iPhone
//
//  Created by Richard Ison on 1/28/2014.
//
//

#import "SPImage.h"
#import <UIKit/UIDevice.h>

typedef enum PhaseType{
    SETUP,
    PLACEMENT,
    SC_RECRUITMENT,
    RECRUITMENT,
    GOLD,
    MOVEMENT,
    COMBAT,
    CONSTRUCTION
} PhaseType;

typedef NS_ENUM(NSInteger, PlacementStep) {
    PLACE_CM_1,
    PLACE_CM_2,
    PLACE_CM_3,
    PLACE_FORT
} ;

typedef NS_ENUM(NSInteger, WasBought) {
    WAS_BOUGHT,
    WAS_NOT_BOUGHT
} ;

@interface FourPlayerGame : SPSprite<UIAlertViewDelegate>{
    PhaseType _phase;
}

-(void) startedRecruitThingsPhase: (NSNotification*) notif;
-(void) addChildToContents: (SPDisplayObject*) sprite;

-(void) setPhase: (PhaseType) phase;
-(PhaseType) getPhase;
-(void) reinitializeCombatScreenAndShowGold;

@end
