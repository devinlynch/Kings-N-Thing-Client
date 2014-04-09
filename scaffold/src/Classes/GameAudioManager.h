//
//  GameAudioManager.h
//  3004iPhone
//
//  Created by Devin Lynch on 2014-04-08.
//
//

#import <Foundation/Foundation.h>

@interface GameAudioManager : NSObject

+(GameAudioManager*) instance;
-(void) startMainMusic;
-(void) stopMainMusic;
-(void) startCombatMusic;
-(void) stopCombatMusic;


@end
