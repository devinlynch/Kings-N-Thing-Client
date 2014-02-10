//
//  Fort.m
//  3004iPhone
//
//  Created by John Marsh on 1/15/2014.
//
//

#import "Fort.h"


@implementation Fort

@synthesize combatValue = _combatValue;
@synthesize fortLevel = _fortLevel;
@synthesize fileName = _fileName;


- (Fort *) initWithId:(NSString *)fortId andCombatValue:(int)value
        andCombatType:(CombatType*) type andFortLevel:(FortLevel *)level andFileName:(NSString *)fileName{
    self=[super init];
    _gamePieceId = [[NSString alloc] initWithString:fortId];
    _combatValue = &value;
    _fortLevel = level;
    _pieceImage = [[ScaledGamePiece alloc] initWithContentsOfFile:fileName andOwner:self];
    _fileName = [[NSString alloc] initWithString:fileName];
    
    return self;
}


-(void) fortDoubleClick: (SPTouchEvent*) event
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


- (void) takeHit:(int)damage{};


+(NSMutableDictionary*)initializeAllForts{
    
    NSMutableDictionary *forts = [[NSMutableDictionary alloc]init];

    [forts setObject:[[Fort alloc] initWithId:@"Fort_01-01" andCombatValue:1 andCombatType:[CombatType getMeleeInstance]  andFortLevel: [FortLevel getTowerInstance] andFileName:@"C_Fort_375.png"] forKey:@"Fort_01-01"];
    [forts setObject:[[Fort alloc] initWithId:@"Fort_01-02" andCombatValue:1 andCombatType:[CombatType getMeleeInstance]  andFortLevel: [FortLevel getTowerInstance] andFileName:@"C_Fort_375.png"] forKey:@"Fort_01-02"];
    [forts setObject:[[Fort alloc] initWithId:@"Fort_01-03" andCombatValue:1 andCombatType:[CombatType getMeleeInstance]  andFortLevel: [FortLevel getTowerInstance] andFileName:@"C_Fort_375.png"] forKey:@"Fort_01-03"];
    [forts setObject:[[Fort alloc] initWithId:@"Fort_01-04" andCombatValue:1 andCombatType:[CombatType getMeleeInstance]  andFortLevel: [FortLevel getTowerInstance] andFileName:@"C_Fort_375.png"] forKey:@"Fort_01-04"];
    [forts setObject:[[Fort alloc] initWithId:@"Fort_01-05" andCombatValue:1 andCombatType:[CombatType getMeleeInstance]  andFortLevel: [FortLevel getTowerInstance] andFileName:@"C_Fort_375.png"] forKey:@"Fort_01-05"];
    [forts setObject:[[Fort alloc] initWithId:@"Fort_01-06" andCombatValue:1 andCombatType:[CombatType getMeleeInstance]  andFortLevel: [FortLevel getTowerInstance] andFileName:@"C_Fort_375.png"] forKey:@"Fort_01-06"];
    [forts setObject:[[Fort alloc] initWithId:@"Fort_01-07" andCombatValue:1 andCombatType:[CombatType getMeleeInstance]  andFortLevel: [FortLevel getTowerInstance] andFileName:@"C_Fort_375.png"] forKey:@"Fort_01-07"];
    [forts setObject:[[Fort alloc] initWithId:@"Fort_01-08" andCombatValue:1 andCombatType:[CombatType getMeleeInstance]  andFortLevel: [FortLevel getTowerInstance] andFileName:@"C_Fort_375.png"] forKey:@"Fort_01-08"];
    [forts setObject:[[Fort alloc] initWithId:@"Fort_01-09" andCombatValue:1 andCombatType:[CombatType getMeleeInstance]  andFortLevel: [FortLevel getTowerInstance] andFileName:@"C_Fort_375.png"] forKey:@"Fort_01-09"];
    [forts setObject:[[Fort alloc] initWithId:@"Fort_01-10" andCombatValue:1 andCombatType:[CombatType getMeleeInstance]  andFortLevel: [FortLevel getTowerInstance] andFileName:@"C_Fort_375.png"] forKey:@"Fort_01-10"];
    
    [forts setObject:[[Fort alloc] initWithId:@"Fort_02-01" andCombatValue:2 andCombatType:[CombatType getMeleeInstance]  andFortLevel: [FortLevel getKeepInstance] andFileName:@"C_Fort_377.png"] forKey:@"Fort_02-01"];
    [forts setObject:[[Fort alloc] initWithId:@"Fort_02-02" andCombatValue:2 andCombatType:[CombatType getMeleeInstance]  andFortLevel: [FortLevel getKeepInstance] andFileName:@"C_Fort_377.png"] forKey:@"Fort_02-02"];
    [forts setObject:[[Fort alloc] initWithId:@"Fort_02-03" andCombatValue:2 andCombatType:[CombatType getMeleeInstance]  andFortLevel: [FortLevel getKeepInstance] andFileName:@"C_Fort_377.png"] forKey:@"Fort_02-03"];
    [forts setObject:[[Fort alloc] initWithId:@"Fort_02-04" andCombatValue:2 andCombatType:[CombatType getMeleeInstance]  andFortLevel: [FortLevel getKeepInstance] andFileName:@"C_Fort_377.png"] forKey:@"Fort_02-04"];
    [forts setObject:[[Fort alloc] initWithId:@"Fort_02-05" andCombatValue:2 andCombatType:[CombatType getMeleeInstance]  andFortLevel: [FortLevel getKeepInstance] andFileName:@"C_Fort_377.png"] forKey:@"Fort_02-05"];
    [forts setObject:[[Fort alloc] initWithId:@"Fort_02-06" andCombatValue:2 andCombatType:[CombatType getMeleeInstance]  andFortLevel: [FortLevel getKeepInstance] andFileName:@"C_Fort_377.png"] forKey:@"Fort_02-06"];
    [forts setObject:[[Fort alloc] initWithId:@"Fort_02-07" andCombatValue:2 andCombatType:[CombatType getMeleeInstance]  andFortLevel: [FortLevel getKeepInstance] andFileName:@"C_Fort_377.png"] forKey:@"Fort_02-07"];
    [forts setObject:[[Fort alloc] initWithId:@"Fort_02-08" andCombatValue:2 andCombatType:[CombatType getMeleeInstance]  andFortLevel: [FortLevel getKeepInstance] andFileName:@"C_Fort_377.png"] forKey:@"Fort_02-08"];
    
    [forts setObject:[[Fort alloc] initWithId:@"Fort_03-01" andCombatValue:3 andCombatType:[CombatType getRangeInstance]  andFortLevel: [FortLevel getCastleInstance] andFileName:@"C_Fort_379.png"] forKey:@"Fort_03-01"];
    [forts setObject:[[Fort alloc] initWithId:@"Fort_03-02" andCombatValue:3 andCombatType:[CombatType getRangeInstance]  andFortLevel: [FortLevel getCastleInstance] andFileName:@"C_Fort_379.png"] forKey:@"Fort_03-02"];
    [forts setObject:[[Fort alloc] initWithId:@"Fort_03-03" andCombatValue:3 andCombatType:[CombatType getRangeInstance]  andFortLevel: [FortLevel getCastleInstance] andFileName:@"C_Fort_379.png"] forKey:@"Fort_03-03"];
    [forts setObject:[[Fort alloc] initWithId:@"Fort_03-04" andCombatValue:3 andCombatType:[CombatType getRangeInstance]  andFortLevel: [FortLevel getCastleInstance] andFileName:@"C_Fort_379.png"] forKey:@"Fort_03-04"];
    [forts setObject:[[Fort alloc] initWithId:@"Fort_03-05" andCombatValue:3 andCombatType:[CombatType getRangeInstance]  andFortLevel: [FortLevel getCastleInstance] andFileName:@"C_Fort_379.png"] forKey:@"Fort_03-05"];
    [forts setObject:[[Fort alloc] initWithId:@"Fort_03-06" andCombatValue:3 andCombatType:[CombatType getRangeInstance]  andFortLevel: [FortLevel getCastleInstance] andFileName:@"C_Fort_379.png"] forKey:@"Fort_03-06"];
    [forts setObject:[[Fort alloc] initWithId:@"Fort_03-07" andCombatValue:3 andCombatType:[CombatType getRangeInstance]  andFortLevel: [FortLevel getCastleInstance] andFileName:@"C_Fort_379.png"] forKey:@"Fort_03-07"];
    [forts setObject:[[Fort alloc] initWithId:@"Fort_03-08" andCombatValue:3 andCombatType:[CombatType getRangeInstance]  andFortLevel: [FortLevel getCastleInstance] andFileName:@"C_Fort_379.png"] forKey:@"Fort_03-08"];
    
    [forts setObject:[[Fort alloc] initWithId:@"Fort_04-01" andCombatValue:4 andCombatType:[CombatType getMagicInstance]  andFortLevel: [FortLevel getCitadelInstance] andFileName:@"C_Fort_381.png"] forKey:@"Fort_04-01"];
    [forts setObject:[[Fort alloc] initWithId:@"Fort_04-02" andCombatValue:4 andCombatType:[CombatType getMagicInstance]  andFortLevel: [FortLevel getCitadelInstance] andFileName:@"C_Fort_381.png"] forKey:@"Fort_04-02"];
    [forts setObject:[[Fort alloc] initWithId:@"Fort_04-03" andCombatValue:4 andCombatType:[CombatType getMagicInstance]  andFortLevel: [FortLevel getCitadelInstance] andFileName:@"C_Fort_381.png"] forKey:@"Fort_04-03"];
    [forts setObject:[[Fort alloc] initWithId:@"Fort_04-04" andCombatValue:4 andCombatType:[CombatType getMagicInstance]  andFortLevel: [FortLevel getCitadelInstance] andFileName:@"C_Fort_381.png"] forKey:@"Fort_04-04"];
    [forts setObject:[[Fort alloc] initWithId:@"Fort_04-05" andCombatValue:4 andCombatType:[CombatType getMagicInstance]  andFortLevel: [FortLevel getCitadelInstance] andFileName:@"C_Fort_381.png"] forKey:@"Fort_04-05"];
    [forts setObject:[[Fort alloc] initWithId:@"Fort_04-06" andCombatValue:4 andCombatType:[CombatType getMagicInstance]  andFortLevel: [FortLevel getCitadelInstance] andFileName:@"C_Fort_381.png"] forKey:@"Fort_04-06"];

    return forts;

}




@end
