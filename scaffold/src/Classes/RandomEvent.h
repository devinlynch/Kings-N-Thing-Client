//
//  RandomEvent.h
//  3004iPhone
//
//  Created by John Marsh on 1/15/2014.
//
//

#import "Thing.h"

@interface RandomEvent : Thing{
    NSString *_randomId;
    NSString *_fileName;
    NSString *_randomType;
}

@property NSString *randomId, *fileName, *randomType;

-(RandomEvent*) initWithId:(NSString*) randomId andRandomType:(NSString*) type andFilename: (NSString*) filename;

+(NSMutableDictionary*) initializeAllRandomEvent;


@end
