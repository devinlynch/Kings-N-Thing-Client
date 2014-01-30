//
//  Bank.h
//  3004iPhone
//
//  Created by John Marsh on 1/21/2014.
//
//

#import "BoardLocation.h"

@interface Bank : NSObject{
    int _currentTotal;
}

@property int currentTotal;

-(Bank*) initWithTotal: (int) total;

@end
