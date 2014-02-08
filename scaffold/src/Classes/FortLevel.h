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
    int _levelNum;
    int _cost;
}

@property NSString *fortLevelID;
@property int levelNum, cost;



@end
