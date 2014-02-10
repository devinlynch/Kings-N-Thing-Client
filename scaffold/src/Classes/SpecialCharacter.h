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
    NSString *_characterId;
}

@property SpecialAbility *specialAbility;
@property NSString *characterId;


-(SpecialCharacter*) initWithId:(NSString*) characterId andSpecialAbility:(SpecialAbility*) ability andFilename: (NSString*) filename;


+(NSMutableDictionary*) initializeAllSpecialCharacters;

@end
