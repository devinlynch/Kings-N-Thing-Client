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
@synthesize fileName = _fileName;


-(SpecialCharacter*) initWithId:(NSString*) characterId andSpecialAbility:(SpecialAbility*) ability andFilename: (NSString*) filename{

    _gamePieceID = [[NSString alloc] initWithString:characterId];
    _specialAbility = ability;
    _fileName = fileName;


    return [super init];
}


+(NSMutableDictionary*) initializeAllSpecialCharacters{
    NSMutableDictionary * specialCharacters = [[NSMutableDictionary alloc] init];
    
    
    
    
    
    return specialCharacters;




}


@end
