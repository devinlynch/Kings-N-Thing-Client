//
//  ScaleImage.h
//  3004iPhone
//
//  Created by Richard Ison on 1/16/2014.
//
//

#import "SPImage.h"
@class  GamePiece;


@interface ScaledGamePiece : SPImage{
    id<NSCopying> _owner;
}


- (id) initWithContentsOfFile:(NSString *)path andOwner: (GamePiece*) piece;
-(void) setOwner:(id<NSCopying>) owner;
@end
