//
//  Treasure.h
//  3004iPhone
//
//  Created by John Marsh on 1/15/2014.
//
//

#import "Thing.h"

@interface Treasure : Thing{
    int _goldValue;
    NSString *_treasureId;
}

@property int goldValue;
@property NSString *treasureId, *fileName;

-(Treasure*) initWithId:(NSString*) treasureId andGoldValue: (int) value andFilename: (NSString*) filename;

+(NSMutableDictionary*) initializeAllTreasures;

@end
