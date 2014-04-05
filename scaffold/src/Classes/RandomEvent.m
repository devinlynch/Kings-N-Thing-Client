//
//  RandomEvent.m
//  3004iPhone
//
//  Created by John Marsh on 1/15/2014.
//
//

#import "RandomEvent.h"

@implementation RandomEvent


@synthesize  randomId = _randomId;
@synthesize randomType = _randomType;

-(RandomEvent*) initWithId:(NSString *)randomId andRandomType:(NSString*)type andFilename:(NSString *)filename {
    self=[super init];
    _gamePieceId = [[NSString alloc] initWithString:randomId];
    _randomType = [[NSString alloc] initWithString:type];
    _fileName = [[NSString alloc] initWithString:filename];
    
    return self;
}


+(NSMutableDictionary*) initializeAllRandomEvent{
    NSMutableDictionary *randomEvents = [[NSMutableDictionary alloc] init];
    
    [randomEvents setObject:[[RandomEvent alloc] initWithId:@"RandomEvent_01"
                                            andRandomType:@"bidJuJu"
                                             andFilename:@"randomEvent_01.png"]
                   forKey:@"RandomEvent_01"];
    
    [randomEvents setObject:[[RandomEvent alloc] initWithId:@"RandomEvent_02"
                                              andRandomType:@"darkPlague"
                                                andFilename:@"randomEvent_02.png"]
                     forKey:@"RandomEvent_02"];
    
    [randomEvents setObject:[[RandomEvent alloc] initWithId:@"RandomEvent_03"
                                              andRandomType:@"defection"
                                                andFilename:@"randomEvent_03.png"]
                     forKey:@"RandomEvent_03"];
    

    [randomEvents setObject:[[RandomEvent alloc] initWithId:@"RandomEvent_04"
                                              andRandomType:@"goodHarvest"
                                                andFilename:@"randomEvent_04.png"]
                     forKey:@"RandomEvent_04"];
    

    [randomEvents setObject:[[RandomEvent alloc] initWithId:@"RandomEvent_05"
                                              andRandomType:@"motherLode"
                                                andFilename:@"randomEvent_05.png"]
                     forKey:@"RandomEvent_05"];
    

    [randomEvents setObject:[[RandomEvent alloc] initWithId:@"RandomEvent_06"
                                              andRandomType:@"teeniepox"
                                                andFilename:@"randomEvent_06.png"]
                     forKey:@"RandomEvent_06"];
    

    [randomEvents setObject:[[RandomEvent alloc] initWithId:@"RandomEvent_07"
                                              andRandomType:@"terrainDisaster"
                                                andFilename:@"randomEvent_07.png"]
                     forKey:@"RandomEvent_07"];
    

    [randomEvents setObject:[[RandomEvent alloc] initWithId:@"RandomEvent_08"
                                              andRandomType:@"vandals"
                                                andFilename:@"randomEvent_08.png"]
                     forKey:@"RandomEvent_08"];
    
    [randomEvents setObject:[[RandomEvent alloc] initWithId:@"RandomEvent_09"
                                              andRandomType:@"weatherControl"
                                                andFilename:@"randomEvent_09.png"]
                     forKey:@"RandomEvent_09"];
    
    [randomEvents setObject:[[RandomEvent alloc] initWithId:@"RandomEvent_10"
                                              andRandomType:@"willingWorkers"
                                                andFilename:@"randomEvent_10.png"]
                     forKey:@"RandomEvent_10"];
    
    return randomEvents;
};


@end
