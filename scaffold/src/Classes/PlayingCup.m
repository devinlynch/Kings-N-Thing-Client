//
//  PlayingCup.m
//  3004iPhone
//
//  Created by John Marsh on 1/15/2014.
//
//

#import "PlayingCup.h"

@implementation PlayingCup

-(id<JSONSerializable>) initFromJSON:(NSDictionary *)json{
    self = [super init];
    if(self && json != nil) {
        NSArray *piecesArray = [json objectForKey:@"gamePieces"];
        for(GamePiece *piece in piecesArray){
            
        }
    }
    return self;
}

@end
