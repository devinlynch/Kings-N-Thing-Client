//
//  GameConfig.h
//  3004iPhone
//
//  Created by Devin Lynch on 2014-04-04.
//
//

#import <Foundation/Foundation.h>

@interface GameConfig : NSObject

+(BOOL) shouldPlayVoice;
+(void) setShouldPlayVoice: (BOOL) b;
+(void) loadFromDictionary:(NSDictionary *) dic;

@end
