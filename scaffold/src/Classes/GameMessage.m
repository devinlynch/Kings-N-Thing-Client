//
//  GameMessage.m
//  3004iPhone
//
//  Created by John Marsh on 2/8/2014.
//
//

#import "GameMessage.h"

@implementation GameMessage

@synthesize jsonDictionnary = _jsonDictionnary;


-(GameMessage*) initWithType: (NSString*) t andDictionnary:(NSDictionary*) dic{
    self=[super init];
    _jsonDictionnary = dic;
    _type = [[NSString alloc] initWithString:t];
    return self;
}

-(id<JSONSerializable>) initFromJSON:(NSDictionary *)json{
    return [[GameMessage alloc] initWithType:[json objectForKey:@"type"] andDictionnary:json];
}

@end

