//
//  Treasure.m
//  3004iPhone
//
//  Created by John Marsh on 1/15/2014.
//
//

#import "Treasure.h"

@implementation Treasure

@synthesize goldValue = _goldValue;
@synthesize treasureId = _treasureId;

-(Treasure*) initWithId:(NSString *)treasureId andGoldValue:(int)value andFilename:(NSString *)filename{
    self=[super init];
    _gamePieceId = [[NSString alloc] initWithString:treasureId];
    _goldValue = value;
    _fileName = [[NSString alloc] initWithString:filename];

    return self;
}

+(NSMutableDictionary*) initializeAllTreasures{
    NSMutableDictionary *treasures = [[NSMutableDictionary alloc] init];
    
    
    [treasures setObject:[[Treasure alloc] initWithId:@"treasure_01-01" andGoldValue:20 andFilename:@"treasure_01.png"] forKey:@"treasure_01-01"];
    
    [treasures setObject:[[Treasure alloc] initWithId:@"treasure_02-01" andGoldValue:10 andFilename:@"treasure_02.png"] forKey:@"treasure_02-01"];

    
    [treasures setObject:[[Treasure alloc] initWithId:@"treasure_03-01" andGoldValue:5 andFilename:@"treasure_03.png"] forKey:@"treasure_03-01"];

    
   // [treasures setObject:[[Treasure alloc] initWithId:@"T_SilverMine_xxx-xx" andGoldValue:2 andFilename:@"treasure_04.png"] forKey:@"T_SilverMine_xxx-xx"];

    
//    [treasures setObject:[[Treasure alloc] initWithId:@"T_SilverMine_xxx-xx" andGoldValue:2 andFilename:@"treasure_04.png"] forKey:@"T_SilverMine_xxx-xx"];

    
    [treasures setObject:[[Treasure alloc] initWithId:@"treasure_04-01" andGoldValue:5 andFilename:@"treasure_06.png"] forKey:@"treasure_04-01"];

    
    [treasures setObject:[[Treasure alloc] initWithId:@"treasure_05-01" andGoldValue:10 andFilename:@"treasure_07.png"] forKey:@"treasure_05-01"];

    
    [treasures setObject:[[Treasure alloc] initWithId:@"treasure_06-01" andGoldValue:5 andFilename:@"treasure_07.png"] forKey:@"treasure_06-01"];

    
    
    return  treasures;


};

@end
