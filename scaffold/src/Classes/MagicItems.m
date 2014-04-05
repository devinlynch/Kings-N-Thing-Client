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


+(NSMutableDictionary*) initializeAllMagicItems{
    NSMutableDictionary *magicItems = [[NSMutableDictionary alloc] init];
    
    [magicItems setObject:[[MagicItems alloc] initWithId:@"magic_01"
                                            andMagicType:@"Abwehrstaub"
                                             andFilename:@"magic_01.png"]
                   forKey:@"magic_01"];
    
    [magicItems setObject:[[MagicItems alloc] initWithId:@"magic_02"
                                            andMagicType:@"Ballon"
                                             andFilename:@"magic_02.png"]
                   forKey:@"magic_02"];
    [magicItems setObject:[[MagicItems alloc] initWithId:@"magic_03"
                                            andMagicType:@"Blasebalg"
                                             andFilename:@"magic_03.png"]
                   forKey:@"magic_03"];
    [magicItems setObject:[[MagicItems alloc] initWithId:@"magic_04"
                                            andMagicType:@"Elixier"
                                             andFilename:@"magic_04.png"]
                   forKey:@"magic_04"];
    [magicItems setObject:[[MagicItems alloc] initWithId:@"magic_05"
                                            andMagicType:@"Feuerwand"
                                             andFilename:@"magic_05.png"]
                   forKey:@"magic_05"];
    [magicItems setObject:[[MagicItems alloc] initWithId:@"magic_06"
                                            andMagicType:@"Glucksbringer"
                                             andFilename:@"magic_06.png"]
                   forKey:@"magic_06"];
    [magicItems setObject:[[MagicItems alloc] initWithId:@"magic_07"
                                            andMagicType:@"Golem"
                                             andFilename:@"magic_07.png"]
                   forKey:@"magic_07"];
    [magicItems setObject:[[MagicItems alloc] initWithId:@"magic_08"
                                            andMagicType:@"MagieBannen"
                                             andFilename:@"magic_08.png"]
                   forKey:@"magic_08"];
    [magicItems setObject:[[MagicItems alloc] initWithId:@"magic_09"
                                            andMagicType:@"Talisman"
                                             andFilename:@"magic_09.png"]
                   forKey:@"magic_09"];
    [magicItems setObject:[[MagicItems alloc] initWithId:@"magic_10"
                                            andMagicType:@"Zauberbogen"
                                             andFilename:@"magic_10.png"]
                   forKey:@"magic_10"];
    [magicItems setObject:[[MagicItems alloc] initWithId:@"magic_11"
                                            andMagicType:@"Zauberschwert"
                                             andFilename:@"magic_11.png"]
                   forKey:@"magic_11"];

    
    
    
    
    
    return magicItems;
};

@end
