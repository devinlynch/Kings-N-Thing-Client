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

+(BOOL) shouldPlayVoice{
    return shouldPlayVoice;
}

+(void) setShouldPlayVoice: (BOOL) b{
    shouldPlayVoice = b;
}

+(void) loadFromDictionary:(NSDictionary *) dic{
    if([dic objectForKey:@"shouldPlayVoice"] != nil) {
        shouldPlayVoice = [[dic objectForKey:@"shouldPlayVoice"] isEqualToString:@"YES"];
    }
}


@end
