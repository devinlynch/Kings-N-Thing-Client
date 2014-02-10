//
//  FortLevel.h
//  3004iPhone
//
//  Created by John Marsh on 1/15/2014.
//
//

#import <Foundation/Foundation.h>

@interface FortLevel : NSObject{
    NSString *_fortLevelID;
    NSString *_fortLevelName;
    int _levelNum;
    int _cost;
}

@property NSString *fortLevelID, *fortLevelName;
@property int levelNum, cost;

+(FortLevel*) getTowerInstance;
+(FortLevel*) getKeepInstance;
+(FortLevel*) getCastleInstance;
+(FortLevel*) getCitadelInstance;

-(FortLevel*) initWithId: (NSString*) typeId withName: (NSString*) levelName
               withLevel:(int) level withCost:(int) cost;

@end
