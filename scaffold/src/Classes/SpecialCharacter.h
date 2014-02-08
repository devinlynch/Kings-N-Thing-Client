//
//  SpecialCharacter.h
//  3004iPhone
//
//  Created by John Marsh on 1/15/2014.
//
//

#import "Counter.h"
#import "SpecialAbility.h"

@interface SpecialCharacter : Counter{
    SpecialAbility *_specialAbility;
    NSString * characterId;
    NSString *fileName;
}

@property SpecialAbility *specialAbility;
@property NSString *characterId, *fileName;


-(SpecialCharacter*) initWithId:(NSString*) characterId andSpecialAbility:(SpecialAbility*) ability andFilename: (NSString*) filename;


+(NSMutableDictionary*) initializeAllSpecialCharacters;

@end
