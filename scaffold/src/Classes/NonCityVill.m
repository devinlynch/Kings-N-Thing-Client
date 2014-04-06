//
//  NonCityVill.m
//  3004iPhone
//
//  Created by John Marsh on 1/15/2014.
//
//

#import "NonCityVill.h"
#import "ScaledGamePiece.h"

@implementation NonCityVill

@synthesize terrain = _terrain;
//@synthesize fileName = _fileName;


-(NonCityVill*) initWithId:(NSString*) nonCityVillId
               terrainType:(Terrain*) type
                 goldValue:(int) value
                  fileName:(NSString*) name{
    self=[super init];
    
    _gamePieceId = [[NSString alloc] initWithString:nonCityVillId];
    _terrain = type;
    _goldValue = value;
    _fileName = [[NSString alloc] initWithString:name];
    
    _pieceImage = [[ScaledGamePiece alloc] initWithContentsOfFile:name andOwner:self];
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

+(NSMutableDictionary*) initializeAllNonCityVill{
    NSMutableDictionary *nonCityVill = [[NSMutableDictionary alloc]init];
    
    
    [nonCityVill setObject:[[NonCityVill alloc] initWithId:@"specialIncomeCounter_01-01"
                                               terrainType:[Terrain getForestInstance] goldValue:1 fileName:@"T_Income_367.png"] forKey:@"specialIncomeCounter_01-01"];
    
    [nonCityVill setObject:[[NonCityVill alloc] initWithId:@"specialIncomeCounter_02-01"
                                               terrainType:[Terrain getFrozenInstance] goldValue:3 fileName:@"T_Income_368.png"] forKey:@"specialIncomeCounter_02-01"];
    
    [nonCityVill setObject:[[NonCityVill alloc] initWithId:@"specialIncomeCounter_03-01"
                                               terrainType:[Terrain getSwampInstance] goldValue:1 fileName:@"T_Income_370.png"] forKey:@"specialIncomeCounter_03-01"];
    
    [nonCityVill setObject:[[NonCityVill alloc] initWithId:@"specialIncomeCounter_04-01"
                                               terrainType:[Terrain getPlainesInstance] goldValue:1 fileName:@"T_Income_364.png"] forKey:@"specialIncomeCounter_04-01"];
    
    [nonCityVill setObject:[[NonCityVill alloc] initWithId:@"specialIncomeCounter_05-01"
                                               terrainType:[Terrain getMountainInstance] goldValue:3 fileName:@"T_Income_365.png"] forKey:@"specialIncomeCounter_05-01"];
    
    [nonCityVill setObject:[[NonCityVill alloc] initWithId:@"specialIncomeCounter_06-01"
                                               terrainType:[Terrain getJungleInstance] goldValue:3 fileName:@"T_Income_363.png"] forKey:@"specialIncomeCounter_06-01"];
    
    [nonCityVill setObject:[[NonCityVill alloc] initWithId:@"specialIncomeCounter_07-01"
                                               terrainType:[Terrain getDesertInstance] goldValue:1 fileName:@"T_Income_362.png"] forKey:@"specialIncomeCounter_07-01"];
    
    [nonCityVill setObject:[[NonCityVill alloc] initWithId:@"specialIncomeCounter_08-01"
                                               terrainType:[Terrain getMountainInstance] goldValue:1 fileName:@"T_Income_366.png"] forKey:@"specialIncomeCounter_08-01"];
    
    [nonCityVill setObject:[[NonCityVill alloc] initWithId:@"specialIncomeCounter_09-01"
                                               terrainType:[Terrain getMountainInstance] goldValue:1 fileName:@"T_Income_369.png"] forKey:@"specialIncomeCounter_09-01"];
    
    [nonCityVill setObject:[[NonCityVill alloc] initWithId:@"specialIncomeCounter_09-02"
                                               terrainType:[Terrain getMountainInstance] goldValue:1 fileName:@"T_Income_369.png"] forKey:@"specialIncomeCounter_09-02"];
    
    
    return nonCityVill;
}

@end
