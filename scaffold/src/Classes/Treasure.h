//
//  Treasure.h
//  3004iPhone
//
//  Created by John Marsh on 1/15/2014.
//
//

#import "Thing.h"

@interface Treasure : Thing{
    NSInteger *_goldValue;
    NSString *_treasureId;
    NSString *_fileName;
    
    
}

@property NSInteger *goldValue;
@property NSString *treasureId, *fileName;

-(Treasure*) initWithId:(NSString*) treasureId andGoldValue: (int) value andFilename: (NSString*) filename;

+(NSMutableDictionary*) initializeAllTreasures;

@end
