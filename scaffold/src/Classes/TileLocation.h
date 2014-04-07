//
//  TileLocation.h
//  3004iPhone
//
//  Created by Devin Lynch on 2014-04-07.
//
//

#import <Foundation/Foundation.h>

@interface TileLocation : NSObject

@property int hexNumber;
@property int column;
@property int row;

-(id) initWithHexNumber: (int) hNumber andColumn: (int) c andRow: (int) row;

@end
