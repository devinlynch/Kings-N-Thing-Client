//
//  Treasure.m
//  3004iPhone
//
//  Created by John Marsh on 1/15/2014.
//
//

#import "Treasure.h"
#import "ScaledGamePiece.h"

@implementation Treasure

@synthesize goldValue = _goldValue;
@synthesize treasureId = _treasureId;

-(Treasure*) initWithId:(NSString *)treasureId andGoldValue:(int)value andFilename:(NSString *)filename{
    self=[super init];
    _gamePieceId = [[NSString alloc] initWithString:treasureId];
    _goldValue = value;
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

+(NSMutableDictionary*) initializeAllTreasures{
    NSMutableDictionary *treasures = [[NSMutableDictionary alloc] init];
    
    
    [treasures setObject:[[Treasure alloc] initWithId:@"treasure_01-01" andGoldValue:20 andFilename:@"T_Event_360.png"] forKey:@"treasure_01-01"];
    
    [treasures setObject:[[Treasure alloc] initWithId:@"treasure_02-01" andGoldValue:10 andFilename:@"T_Event_358.png"] forKey:@"treasure_02-01"];

    
    [treasures setObject:[[Treasure alloc] initWithId:@"treasure_03-01" andGoldValue:5 andFilename:@"T_Event_359.png"] forKey:@"treasure_03-01"];

    
   // [treasures setObject:[[Treasure alloc] initWithId:@"T_SilverMine_xxx-xx" andGoldValue:2 andFilename:@"treasure_04.png"] forKey:@"T_SilverMine_xxx-xx"];

    
//    [treasures setObject:[[Treasure alloc] initWithId:@"T_SilverMine_xxx-xx" andGoldValue:2 andFilename:@"treasure_04.png"] forKey:@"T_SilverMine_xxx-xx"];

    
    [treasures setObject:[[Treasure alloc] initWithId:@"treasure_04-01" andGoldValue:5 andFilename:@"T_Event_357.png"] forKey:@"treasure_04-01"];

    
    [treasures setObject:[[Treasure alloc] initWithId:@"treasure_05-01" andGoldValue:10 andFilename:@"T_Event_361.png"] forKey:@"treasure_05-01"];

    
    [treasures setObject:[[Treasure alloc] initWithId:@"treasure_06-01" andGoldValue:5 andFilename:@"T_Event_356.png"] forKey:@"treasure_06-01"];

    
    
    return  treasures;


};

@end
