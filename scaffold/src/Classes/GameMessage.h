//
//  GameMessage.h
//  3004iPhone
//
//  Created by John Marsh on 2/8/2014.
//
//

#import "Message.h"

@interface GameMessage : Message<JSONSerializable>{
    NSDictionary *_jsonDictionnary;
}

@property NSDictionary *jsonDictionnary;

-(GameMessage*) initWithType: (NSString*) t andDictionnary:(NSDictionary*) dic;

@end
