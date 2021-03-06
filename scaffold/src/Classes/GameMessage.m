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
@synthesize gameId = _gameId;

-(GameMessage*) initWithType: (NSString*) t andDictionnary:(NSDictionary*) dic{
    self=[super init];
    _jsonDictionnary = dic;
    _type = [[NSString alloc] initWithString:t];
    _messageId = [dic objectForKey:@"messageId"];
    _gameId = [dic objectForKey:@"gameId"];
    return self;
}

-(id<JSONSerializable>) initFromJSON:(NSDictionary *)json{
    self = [self initWithType:[json objectForKey:@"type"] andDictionnary:json];
    return self;
}

@end

