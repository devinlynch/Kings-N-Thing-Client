//
//  GoldCollection.h
//  3004iPhone
//
//  Created by Richard Ison on 1/29/2014.
//
//

#import "SPSprite.h"
#import <UIKit/UIDevice.h>

@interface GoldCollection : SPSprite

+(GoldCollection*) getInstance;

-(void) setIncome: (NSString*) income;

-(void) setTotal: (NSString*) total;

-(void) setUsername: (NSString*) username;

@end
