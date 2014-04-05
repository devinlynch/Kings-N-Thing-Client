//
//  RandomEvent.m
//  3004iPhone
//
//  Created by John Marsh on 1/15/2014.
//
//

#import "RandomEvent.h"
#import "ScaledGamePiece.h"

@implementation RandomEvent


@synthesize  randomId = _randomId;
@synthesize randomType = _randomType;

-(RandomEvent*) initWithId:(NSString *)randomId andRandomType:(NSString*)type andFilename:(NSString *)filename {
    self=[super init];
    _gamePieceId = [[NSString alloc] initWithString:randomId];
    _randomType = [[NSString alloc] initWithString:type];
    _fileName = [[NSString alloc] initWithString:filename];
    
    _pieceImage = [[ScaledGamePiece alloc] initWithContentsOfFile:filename andOwner:self];
    [_pieceImage addEventListener:@selector(creatureDoubleClick:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    
    return self;
}

-(void) creatureDoubleClick: (SPTouchEvent*) event
{
    NSArray *touches = [[event touchesWithTarget:[self pieceImage] andPhase:SPTouchPhaseBegan] allObjects];
    
    if (touches.count == 1)
    {
        //Double Click
        SPTouch *clicks = [touches objectAtIndex:0];
        if (clicks.tapCount == 2){
            NSLog(@"le double click");
            [[NSNotificationCenter defaultCenter] postNotificationName:@"pieceSelected" object:self];
        }
        
    }
    
}


+(NSMutableDictionary*) initializeAllRandomEvent{
    NSMutableDictionary *randomEvents = [[NSMutableDictionary alloc] init];
    
    [randomEvents setObject:[[RandomEvent alloc] initWithId:@"RandomEvent_01"
                                            andRandomType:@"bidJuJu"
                                             andFilename:@"T_Event_337.png"]
                   forKey:@"RandomEvent_01"];
    
    [randomEvents setObject:[[RandomEvent alloc] initWithId:@"RandomEvent_02"
                                              andRandomType:@"darkPlague"
                                                andFilename:@"T_Event_338.png"]
                     forKey:@"RandomEvent_02"];
    
    [randomEvents setObject:[[RandomEvent alloc] initWithId:@"RandomEvent_03"
                                              andRandomType:@"defection"
                                                andFilename:@"T_Event_342.png"]
                     forKey:@"RandomEvent_03"];
    

    [randomEvents setObject:[[RandomEvent alloc] initWithId:@"RandomEvent_04"
                                              andRandomType:@"goodHarvest"
                                                andFilename:@"T_Event_340.png"]
                     forKey:@"RandomEvent_04"];
    

    [randomEvents setObject:[[RandomEvent alloc] initWithId:@"RandomEvent_05"
                                              andRandomType:@"motherLode"
                                                andFilename:@"T_Event_339.png"]
                     forKey:@"RandomEvent_05"];
    

    [randomEvents setObject:[[RandomEvent alloc] initWithId:@"RandomEvent_06"
                                              andRandomType:@"teeniepox"
                                                andFilename:@"T_Event_341.png"]
                     forKey:@"RandomEvent_06"];
    

    [randomEvents setObject:[[RandomEvent alloc] initWithId:@"RandomEvent_07"
                                              andRandomType:@"terrainDisaster"
                                                andFilename:@"T_Event_336.png"]
                     forKey:@"RandomEvent_07"];
    

    [randomEvents setObject:[[RandomEvent alloc] initWithId:@"RandomEvent_08"
                                              andRandomType:@"vandals"
                                                andFilename:@"T_Event_343.png"]
                     forKey:@"RandomEvent_08"];
    
    [randomEvents setObject:[[RandomEvent alloc] initWithId:@"RandomEvent_09"
                                              andRandomType:@"weatherControl"
                                                andFilename:@"T_Event_344.png"]
                     forKey:@"RandomEvent_09"];
    
    [randomEvents setObject:[[RandomEvent alloc] initWithId:@"RandomEvent_10"
                                              andRandomType:@"willingWorkers"
                                                andFilename:@"T_Event_335.png"]
                     forKey:@"RandomEvent_10"];
    
    return randomEvents;
};


@end
