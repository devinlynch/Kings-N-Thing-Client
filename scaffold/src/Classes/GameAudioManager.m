//
//  GameAudioManager.m
//  3004iPhone
//
//  Created by Devin Lynch on 2014-04-08.
//
//

#import "GameAudioManager.h"
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>

@implementation GameAudioManager
{
    AVAudioPlayer *_mainMusic;
    AVAudioPlayer *_combatMusic;
}

static GameAudioManager*_instance;
+(GameAudioManager*) instance{
    if(_instance == nil) {
        _instance = [[GameAudioManager alloc] init];
    }
    return _instance;
}

-(void) startMainMusic{
    if(_mainMusic == nil) {
        NSString *soundFilePath = [[NSBundle mainBundle] pathForResource:@"8bit" ofType:@"mp3"];
        NSURL *soundFileURL = [NSURL fileURLWithPath:soundFilePath];
        _mainMusic = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFileURL error:nil];
        _mainMusic.numberOfLoops = -1; //infinite
        _mainMusic.volume=0.5;
    }
    
    [_mainMusic play];
}
-(void) stopMainMusic{
    if(_mainMusic != nil) {
        [_mainMusic stop];
    }
}
-(void) startCombatMusic{
    if(_combatMusic == nil) {
        NSString *soundFilePath = [[NSBundle mainBundle] pathForResource:@"battle" ofType:@"mp3"];
        NSURL *soundFileURL = [NSURL fileURLWithPath:soundFilePath];
        _combatMusic = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFileURL error:nil];
        _combatMusic.numberOfLoops = -1; //infinite
        _combatMusic.volume=0.5;
    }
    
    [self stopMainMusic];
    [_combatMusic play];
}

-(void) stopCombatMusic{
    if(_combatMusic != nil) {
        [_combatMusic stop];
    }
    [self startMainMusic];
}

@end
