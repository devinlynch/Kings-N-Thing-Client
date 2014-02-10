//
//  PlayerRecruitment.h
//  3004iPhone
//
//  Created by Devin Lynch on 2014-02-09.
//
//

#import <Foundation/Foundation.h>
#import "Player.h"
#import "Thing.h"
#import "BoardLocation.h"

typedef enum RecruitmentType {
    RT_BUY,
    RT_TRADE,
    RT_FREE
} RecruitmentType;

@interface PlayerRecruitment : NSObject

@property Player* player;
@property Thing* thing;
@property BoardLocation* location;
@property RecruitmentType recruitmentType;

+(PlayerRecruitment*) fromDictionary: (NSDictionary*) dic;

@end
