//
//  JSONSerializable.h
//  3004iPhone
//
//  Created by Devin Lynch on 2014-01-21.
//
//

#import <Foundation/Foundation.h>

@protocol JSONSerializable <NSObject>
-(id<JSONSerializable>)initFromJSON:(NSDictionary*) json;
@end
