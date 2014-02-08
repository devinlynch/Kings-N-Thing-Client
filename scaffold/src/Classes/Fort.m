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

    _gamePieceID = [[NSString alloc] initWithString:fortId];
    _combatValue = &value;
    _fortLevel = level;
    _pieceImage = [[ScaledGamePiece alloc] initWithContentsOfFile:fileName andOwner:self];
    _fileName = [[NSString alloc] initWithString:fileName];
    
    return  [super init];
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

    [forts setObject:[[Fort alloc] initWithId:@"F_Tower_000" andCombatValue: 1
                                andCombatType:[CombatType getMeleeInstance]
                                 andFortLevel:[FortLevel getTowerInstance] andFileName:@"Tower"]
              forKey:@"F_Tower_000"];

    return forts;

}




@end
