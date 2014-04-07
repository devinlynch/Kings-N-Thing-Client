//
//  MagicItems.m
//  3004iPhone
//
//  Created by John Marsh on 1/15/2014.
//
//

#import "MagicItems.h"
#import "ScaledGamePiece.h"

@implementation MagicItems

@synthesize magicId = _magicId;
@synthesize magicType = _magicType;

-(MagicItems*) initWithId:(NSString *)magicId andMagicType:(NSString*)type andFilename:(NSString *)filename {
    self=[super init];
    _gamePieceId = [[NSString alloc] initWithString:magicId];
    _magicType = [[NSString alloc] initWithString:type];
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



+(NSMutableDictionary*) initializeAllMagicItems{
    NSMutableDictionary *magicItems = [[NSMutableDictionary alloc] init];
    
    [magicItems setObject:[[MagicItems alloc] initWithId:@"magic_01"
                                            andMagicType:@"Abwehrstaub"
                                             andFilename:@"T_Event_345.png"]
                   forKey:@"magic_01"];
    
    [magicItems setObject:[[MagicItems alloc] initWithId:@"magic_02"
                                            andMagicType:@"Ballon"
                                             andFilename:@"T_Event_346.png"]
                   forKey:@"magic_02"];
    [magicItems setObject:[[MagicItems alloc] initWithId:@"magic_03"
                                            andMagicType:@"Blasebalg"
                                             andFilename:@"T_Event_347.png"]
                   forKey:@"magic_03"];
    [magicItems setObject:[[MagicItems alloc] initWithId:@"magic_04"
                                            andMagicType:@"Elixier"
                                             andFilename:@"T_Event_348.png"]
                   forKey:@"magic_04"];
    [magicItems setObject:[[MagicItems alloc] initWithId:@"magic_05"
                                            andMagicType:@"Feuerwand"
                                             andFilename:@"T_Event_349.png"]
                   forKey:@"magic_05"];
    [magicItems setObject:[[MagicItems alloc] initWithId:@"magic_06"
                                            andMagicType:@"Glucksbringer"
                                             andFilename:@"T_Event_350.png"]
                   forKey:@"magic_06"];
    [magicItems setObject:[[MagicItems alloc] initWithId:@"magic_07"
                                            andMagicType:@"Golem"
                                             andFilename:@"T_Event_351.png"]
                   forKey:@"magic_07"];
    [magicItems setObject:[[MagicItems alloc] initWithId:@"magic_08"
                                            andMagicType:@"MagieBannen"
                                             andFilename:@"T_Event_352.png"]
                   forKey:@"magic_08"];
    [magicItems setObject:[[MagicItems alloc] initWithId:@"magic_09"
                                            andMagicType:@"Talisman"
                                             andFilename:@"T_Event_353.png"]
                   forKey:@"magic_09"];
    [magicItems setObject:[[MagicItems alloc] initWithId:@"magic_10"
                                            andMagicType:@"Zauberbogen"
                                             andFilename:@"T_Event_354.png"]
                   forKey:@"magic_10"];
    [magicItems setObject:[[MagicItems alloc] initWithId:@"magic_11"
                                            andMagicType:@"Zauberschwert"
                                             andFilename:@"T_Event_355.png"]
                   forKey:@"magic_11"];

    
    
    
    
    
    return magicItems;
};

@end
