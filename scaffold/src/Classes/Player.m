//
//  Player.m
//  3004iPhone
//
//  Created by John Marsh on 1/15/2014.
//
//

#import "Player.h"

@implementation Player

@synthesize user = _user;
@synthesize rack1 = _rack1;
@synthesize rack2 = _rack2;
@synthesize gold = _gold;


-(id<JSONSerializable>)initFromJSON:(NSDictionary*) json{
    self=[super init];
    if(self && json != nil) {
        NSDictionary *userDic = [json objectForKey:@"user"];
        if(userDic != nil) {
            self.user=[[User alloc] initFromJSON:userDic];
        }
    }
    return self;
}

@end
