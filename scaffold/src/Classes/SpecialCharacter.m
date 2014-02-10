//
//  SpecialCharacter.m
//  3004iPhone
//
//  Created by John Marsh on 1/15/2014.
//
//

#import "SpecialCharacter.h"

@implementation SpecialCharacter

@synthesize specialAbility = _specialAbility;
@synthesize characterId = _characterId;


-(SpecialCharacter*) initWithId:(NSString*) characterId andSpecialAbility:(SpecialAbility*) ability andFilename: (NSString*) filename{
    self = [super init];
    _gamePieceId = [[NSString alloc] initWithString:characterId];
    _specialAbility = ability;
    _fileName = fileName;


    return self;
}


+(NSMutableDictionary*) initializeAllSpecialCharacters{
    NSMutableDictionary * specialCharacters = [[NSMutableDictionary alloc] init];
    
    
    
    
    
    return specialCharacters;




}


@end
