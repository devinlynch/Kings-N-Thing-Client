//
//  TileLocation.m
//  3004iPhone
//
//  Created by Devin Lynch on 2014-04-07.
//
//

#import "TileLocation.h"

@implementation TileLocation
@synthesize column,row, hexNumber;

-(id) initWithHexNumber: (int) hNumber andColumn: (int) c andRow: (int) r{
    self = [super init];
    if(self) {
        column = c;
        row = r;
        hexNumber = hNumber;
    }
    return self;
}

@end
