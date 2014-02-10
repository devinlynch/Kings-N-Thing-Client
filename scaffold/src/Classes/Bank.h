//
//  Bank.h
//  3004iPhone
//
//  Created by John Marsh on 1/21/2014.
//
//

#import "BoardLocation.h"
#import "JSONSerializable.h"

@interface Bank : NSObject<JSONSerializable>{
    int _currentTotal;
}

@property int currentTotal;

-(Bank*) initWithTotal: (int) total;

-(void) decreaseByAmount: (int) amount;

-(void) increaseByAmount: (int) amount;



@end
