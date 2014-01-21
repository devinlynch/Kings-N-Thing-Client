//
//  FortLevel.h
//  3004iPhone
//
//  Created by John Marsh on 1/15/2014.
//
//

#import <Foundation/Foundation.h>

@interface FortLevel : NSObject{
    NSString *_fortLevelID;
    NSInteger *_levelNum;
    NSInteger *_cost;
}

@property NSString *fortLevelID;
@property NSInteger *levelNum, *cost;



@end
