//
//  Game.m
//  3004iPhone
//
//  Created by John Marsh on 1/21/2014.
//
//

#import "Game.h"
#import "GameChatMessage.h"
#import "LogMessage.h"
#import "User.h"
#import <AVFoundation/AVFoundation.h>

@implementation Game{
    AVSpeechSynthesizer * synthesizer;
}

@synthesize gameID = _gameID;
@synthesize gameState = _gameState;
@synthesize users = _users;
@synthesize chatMessages = _chatMessages;
@synthesize logMessages = _logMessages;

static Game *instance;

+(id) currentGame{
    @synchronized(self){
        return instance;
    }
}

+(void) setInstance: (Game*) game {
    @synchronized(self){
        instance = game;
    }
}

-(id) init{
    self = [super init];
    if(self) {
        [self setChatMessages:[[NSMutableArray alloc] init]];
        [self setLogMessages:[[NSMutableArray alloc] init]];
        synthesizer = [[AVSpeechSynthesizer alloc] init];
    }
    return self;
}

-(id<JSONSerializable>)initFromJSON:(NSDictionary*) json{
    self=[self init];
    if(self && json != nil) {
        [self setGameID:[json objectForKey:@"gameId"]];
        
        NSArray *usersJsonArr = [json objectForKey:@"users"];
        [self setUsers:[[NSMutableArray alloc] init]];
        if(usersJsonArr != nil){
            for(id o in usersJsonArr) {
                if(o != nil && ([o isKindOfClass:[NSDictionary class]])){
                    NSDictionary *userDic = (NSDictionary*) o;
                    User *u = [[User alloc] initFromJSON:userDic];
                    [self.users addObject:u];
                }
            }
        }
    }
    return self;
}

-(User*) getUserByUserId:(NSString*) userId{
    for(User *u in self.users) {
        if([userId isEqualToString:u.userID])
            return u;
    }
    return nil;
}

-(void) addChatMessage: (GameChatMessage*) message{
    [self.chatMessages addObject:message];
}

-(void) addLogMessage: (NSString*) message{
    if([GameConfig shouldPlayVoice]){
        dispatch_async(dispatch_get_main_queue(), ^{
            AVSpeechUtterance *utterance = [[AVSpeechUtterance alloc] initWithString:message];
            [utterance setRate:0.4f];
            [synthesizer speakUtterance:utterance];
        });
    }
    [self addLogMessageWithoutVoice:message];
}

-(void) addLogMessageWithoutTalking: (NSString*) message;
{
    [self addLogMessageWithoutVoice:message];
}

-(void) addLogMessageWithoutVoice: (NSString*) message{
    NSLog(@"%@",message);
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"newLogMessage" object:self];
    
    LogMessage *msg = [[LogMessage alloc] initWithMessage:message];
    [self.logMessages addObject:msg];
}

+(void) addLogMessageToCurrentGame: (NSString*) message{
    Game *g = [self currentGame];
    if(g != nil)
       [g addLogMessage:message];
}

+(void) addLogMessageWithoutVoiceToCurrentGame: (NSString*) message{
    Game *g = [self currentGame];
    if(g != nil)
        [g addLogMessageWithoutVoice:message];
}





@end
