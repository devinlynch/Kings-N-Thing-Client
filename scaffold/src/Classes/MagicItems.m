//
//  MagicItems.m
//  3004iPhone
//
//  Created by John Marsh on 1/15/2014.
//
//

#import "MagicItems.h"

@implementation MagicItems

@synthesize magicId = _magicId;
@synthesize magicType = _magicType;

-(MagicItems*) initWithId:(NSString *)magicId andMagicType:(NSString*)type andFilename:(NSString *)filename {
    self=[super init];
    _gamePieceId = [[NSString alloc] initWithString:magicId];
    _magicType = [[NSString alloc] initWithString:type];
    _fileName = [[NSString alloc] initWithString:filename];
    
    return self;
}


+(NSMutableDictionary*) initializeAllMagiciItems{
    NSMutableDictionary *magicItems = [[NSMutableDictionary alloc] init];
    
    [magicItems setObject:[[MagicItems alloc] initWithId:@"T_Magic_01-xx"
                                            andMagicType:@"Abwehrstaub"
                                             andFilename:@"magic_01.png"]
                   forKey:@"T_Magic_01-xx"];
    
    [magicItems setObject:[[MagicItems alloc] initWithId:@"T_Magic_02-xx"
                                            andMagicType:@"Ballon"
                                             andFilename:@"magic_02.png"]
                   forKey:@"T_Magic_02-xx"];
    [magicItems setObject:[[MagicItems alloc] initWithId:@"T_Magic_03-xx"
                                            andMagicType:@"Blasebalg"
                                             andFilename:@"magic_03.png"]
                   forKey:@"T_Magic_03-xx"];
    [magicItems setObject:[[MagicItems alloc] initWithId:@"T_Magic_04-xx"
                                            andMagicType:@"Elixier"
                                             andFilename:@"magic_04.png"]
                   forKey:@"T_Magic_04-xx"];
    [magicItems setObject:[[MagicItems alloc] initWithId:@"T_Magic_05-xx"
                                            andMagicType:@"Feuerwand"
                                             andFilename:@"magic_05.png"]
                   forKey:@"T_Magic_05-xx"];
    [magicItems setObject:[[MagicItems alloc] initWithId:@"T_Magic_06-xx"
                                            andMagicType:@"Glucksbringer"
                                             andFilename:@"magic_06.png"]
                   forKey:@"T_Magic_06-xx"];
    [magicItems setObject:[[MagicItems alloc] initWithId:@"T_Magic_07-xx"
                                            andMagicType:@"Golem"
                                             andFilename:@"magic_07.png"]
                   forKey:@"T_Magic_07-xx"];
    [magicItems setObject:[[MagicItems alloc] initWithId:@"T_Magic_08-xx"
                                            andMagicType:@"MagieBannen"
                                             andFilename:@"magic_08.png"]
                   forKey:@"T_Magic_08-xx"];
    [magicItems setObject:[[MagicItems alloc] initWithId:@"T_Magic_09-xx"
                                            andMagicType:@"Talisman"
                                             andFilename:@"magic_09.png"]
                   forKey:@"T_Magic_09-xx"];
    [magicItems setObject:[[MagicItems alloc] initWithId:@"T_Magic_10-xx"
                                            andMagicType:@"Zauberbogen"
                                             andFilename:@"magic_10.png"]
                   forKey:@"T_Magic_10-xx"];
    [magicItems setObject:[[MagicItems alloc] initWithId:@"T_Magic_11-xx"
                                            andMagicType:@"Zauberschwert"
                                             andFilename:@"magic_11.png"]
                   forKey:@"T_Magic_11-xx"];

    
    
    
    
    
    return magicItems;
};

@end
