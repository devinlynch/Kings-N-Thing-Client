//
//  GameConfig.m
//  3004iPhone
//
//  Created by Devin Lynch on 2014-04-04.
//
//

#import "GameConfig.h"

@implementation GameConfig

static BOOL shouldPlayVoice;
static BOOL isDemo;

+(BOOL) shouldPlayVoice{
    return shouldPlayVoice;
}

+(void) setShouldPlayVoice: (BOOL) b{
    shouldPlayVoice = b;
}

+(void) loadFromDictionary:(NSDictionary *) dic{
    if([dic objectForKey:@"shouldPlayVoice"] != nil) {
        shouldPlayVoice = [[dic objectForKey:@"shouldPlayVoice"] isEqualToString:@"YES"];
        isDemo = [[dic objectForKey:@"isDemo"] isEqualToString:@"YES"];
    }
}

+(BOOL) isDemo{
    return isDemo;
}
+(void) setDemo: (BOOL) b{
    isDemo = b;
}


@end
