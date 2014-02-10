//
//  CombatType.m
//  3004iPhone
//
//  Created by John Marsh on 1/15/2014.
//
//

#import "CombatType.h"

@implementation CombatType

@synthesize combatTypeID   = _combatTypeID;
@synthesize combatTypeName = _combatTypeName;

static CombatType *magic = nil;
static CombatType *range = nil;
static CombatType *melee = nil;
static CombatType *flying = nil;
static CombatType *charged = nil;


+(CombatType*) getMagicInstance{
    if (magic == nil) {
        magic = [[CombatType alloc] initWithId:@"CT_Magic" andName:@"Magic"];
    }
    return magic;
}

+(CombatType*) getRangeInstance{
    if (range == nil) {
        range = [[CombatType alloc] initWithId:@"CT_Range" andName:@"Range"];
    }
    return range;
}

+(CombatType*) getFlyingInstance{
    if (flying == nil) {
        flying =  [[CombatType alloc] initWithId:@"CT_Flying" andName:@"Flying"];
    }
    return flying;
}

+(CombatType*) getMeleeInstance{
    if (melee == nil) {
        melee =  [[CombatType alloc] initWithId:@"CT_Melee" andName:@"Melee"];
    }
    return melee;
}

+(CombatType*) getChargedInstance{
    if (charged == nil) {
        charged = [[CombatType alloc] initWithId:@"CT_Charged" andName:@"Charged"];
    }
    return charged;
}




-(CombatType*) initWithId: (NSString*) typeId andName: (NSString*) name{
    self=[super init];
    _combatTypeID = [[NSString alloc] initWithString:typeId];
    _combatTypeName = [[NSString alloc] initWithString:name];
    return self;
}


@end
