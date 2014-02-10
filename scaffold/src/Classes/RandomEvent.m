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
@synthesize fileName = _fileName;
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
    
    [randomEvents setObject:[[RandomEvent alloc] initWithId:@"T_RandomEvent_01-xx"
                                            andRandomType:@"bidJuJu"
                                             andFilename:@"randomEvent_01.png"]
                   forKey:@"T_RandomEvent_01-xx"];
    
    [randomEvents setObject:[[RandomEvent alloc] initWithId:@"T_RandomEvent_02-xx"
                                              andRandomType:@"darkPlague"
                                                andFilename:@"randomEvent_02.png"]
                     forKey:@"T_RandomEvent_02-xx"];
    
    [randomEvents setObject:[[RandomEvent alloc] initWithId:@"T_RandomEvent_03-xx"
                                              andRandomType:@"defection"
                                                andFilename:@"randomEvent_03.png"]
                     forKey:@"T_RandomEvent_03-xx"];
    

    [randomEvents setObject:[[RandomEvent alloc] initWithId:@"T_RandomEvent_04-xx"
                                              andRandomType:@"goodHarvest"
                                                andFilename:@"randomEvent_04.png"]
                     forKey:@"T_RandomEvent_04-xx"];
    

    [randomEvents setObject:[[RandomEvent alloc] initWithId:@"T_RandomEvent_05-xx"
                                              andRandomType:@"motherLode"
                                                andFilename:@"randomEvent_05.png"]
                     forKey:@"T_RandomEvent_05-xx"];
    

    [randomEvents setObject:[[RandomEvent alloc] initWithId:@"T_RandomEvent_06-xx"
                                              andRandomType:@"teeniepox"
                                                andFilename:@"randomEvent_06.png"]
                     forKey:@"T_RandomEvent_06-xx"];
    

    [randomEvents setObject:[[RandomEvent alloc] initWithId:@"T_RandomEvent_07-xx"
                                              andRandomType:@"terrainDisaster"
                                                andFilename:@"randomEvent_07.png"]
                     forKey:@"T_RandomEvent_07-xx"];
    

    [randomEvents setObject:[[RandomEvent alloc] initWithId:@"T_RandomEvent_08-xx"
                                              andRandomType:@"vandals"
                                                andFilename:@"randomEvent_08.png"]
                     forKey:@"T_RandomEvent_08-xx"];
    
    [randomEvents setObject:[[RandomEvent alloc] initWithId:@"T_RandomEvent_09-xx"
                                              andRandomType:@"weatherControl"
                                                andFilename:@"randomEvent_09.png"]
                     forKey:@"T_RandomEvent_09-xx"];
    
    [randomEvents setObject:[[RandomEvent alloc] initWithId:@"T_RandomEvent_10-xx"
                                              andRandomType:@"willingWorkers"
                                                andFilename:@"randomEvent_10.png"]
                     forKey:@"T_RandomEvent_10-xx"];
    
    return randomEvents;
};


@end
