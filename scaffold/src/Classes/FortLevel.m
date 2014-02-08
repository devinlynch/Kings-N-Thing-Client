//
//  FortLevel.m
//  3004iPhone
//
//  Created by John Marsh on 1/15/2014.
//
//

#import "FortLevel.h"

@implementation FortLevel

@synthesize fortLevelID = _fortLevelID;
@synthesize cost        = _cost;
@synthesize levelNum    = _levelNum;

static FortLevel * tower = nil;
static FortLevel * keep = nil;
static FortLevel * castle = nil;
static FortLevel * citadel = nil;


+(FortLevel*) getTowerInstance{
    if (tower == nil){
        tower = [[FortLevel alloc] initWithid:@"FL_Tower" withName:@"Tower" withLevel:1 andCost:5];
    }
    
    return tower;
}

+(FortLevel*) getKeepInstance{
    if (keep == nil){
        keep = [[FortLevel alloc] initWithid:@"FL_Keep" withName:@"Keep" withLevel:2 andCost:5];    }
    
    return keep;
}
+(FortLevel*) getCastleInstance{
    if (castle == nil){
        castle = [[FortLevel alloc] initWithid:@"FL_Castle" withName:@"Castle" withLevel:3 andCost:5];
    }
    
    return castle;
}
+(FortLevel*) getCitadelInstance{
    if (citadel == nil){
       citadel = [[FortLevel alloc] initWithid:@"FL_Citadel" withName:@"Citadel" withLevel:4 andCost:5];
    }
    
    return citadel;
}


-(FortLevel*) initWithid:(NSString *)typeId
                withName:(NSString*) levelName
               withLevel:(int)level andCost:(int)cost{

    _fortLevelID = [[NSString alloc] initWithString:typeId];
    _fortLevelName = [[NSString alloc] initWithString:levelName];
    _levelNum = level;
    _cost = cost;
    
    return [super init];

}





@end
