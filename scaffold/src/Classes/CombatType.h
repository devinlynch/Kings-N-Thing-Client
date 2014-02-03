//
//  CombatType.h
//  3004iPhone
//
//  Created by John Marsh on 1/15/2014.
//
//

#import <Foundation/Foundation.h>

@interface CombatType : NSObject{
    NSString *_combatTypeID;
    NSString *_combatTypeName;
}

@property NSString *combatTypeID, *combatTypeName;


+(CombatType*) getMagicInstance;
+(CombatType*) getRangeInstance;
+(CombatType*) getFlyingInstance;
+(CombatType*) getMeleeInstance;
+(CombatType*) getChargedInstance;


-(CombatType*) initWithId: (NSString*) typeId andName: (NSString*) name;

@end
