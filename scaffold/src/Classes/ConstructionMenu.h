//
//  ConstructionMenu.h
//  3004iPhone
//
//  Created by Richard Ison on 2014-03-18.
//
//

#import "SPSprite.h"
#import "AbstractInGameScreen.h"



typedef enum ConstructionState{
    CS_WAITING,
    CS_BUYING,
    CS_UPGRADING
} ConstructionState;


@interface ConstructionMenu : AbstractInGameScreen

@end
