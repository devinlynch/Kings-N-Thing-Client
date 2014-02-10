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
    _goldValue = &value;
    _fileName = [[NSString alloc] initWithString:filename];

    return self;
}

+(NSMutableDictionary*) initializeAllTreasures{
    NSMutableDictionary *treasures = [[NSMutableDictionary alloc] init];
    
    
    [treasures setObject:[[Treasure alloc] initWithId:@"T_TreasureChest_xxx-xx" andGoldValue:20 andFilename:@"treasure_01.png"] forKey:@"T_TreasureChest_xxx-xx"];
    
    [treasures setObject:[[Treasure alloc] initWithId:@"T_Ruby_xxx-xx" andGoldValue:10 andFilename:@"treasure_02.png"] forKey:@"T_Ruby_xxx-xx"];

    
    [treasures setObject:[[Treasure alloc] initWithId:@"T_Sapphire_xxx-xx" andGoldValue:5 andFilename:@"treasure_03.png"] forKey:@"T_Sapphire_xxx-xx"];

    
    [treasures setObject:[[Treasure alloc] initWithId:@"T_SilverMine_xxx-xx" andGoldValue:2 andFilename:@"treasure_04.png"] forKey:@"T_SilverMine_xxx-xx"];

    
    [treasures setObject:[[Treasure alloc] initWithId:@"T_SilverMine_xxx-xx" andGoldValue:2 andFilename:@"treasure_04.png"] forKey:@"T_SilverMine_xxx-xx"];

    
    [treasures setObject:[[Treasure alloc] initWithId:@"T_Pearl_xxx-xx" andGoldValue:5 andFilename:@"treasure_06.png"] forKey:@"T_Pearl_xxx-xx"];

    
    [treasures setObject:[[Treasure alloc] initWithId:@"T_Emerald_xxx-xx" andGoldValue:10 andFilename:@"treasure_07.png"] forKey:@"T_Emerald_xxx-xx"];

    
    [treasures setObject:[[Treasure alloc] initWithId:@"T_Diamond_xxx-xx" andGoldValue:5 andFilename:@"treasure_07.png"] forKey:@"T_Diamond_xxx-xx"];

    
    
    return  treasures;


};

@end
