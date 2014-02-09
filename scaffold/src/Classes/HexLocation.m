//
//  HexLocation.m
//  3004iPhone
//
//  Created by John Marsh on 1/15/2014.
//
//

#import "HexLocation.h"
#import "HexTile.h"
#import "Stack.h"
#import "GameResource.h"

@implementation HexLocation


@synthesize tile = _tile;
@synthesize neighbourIds = _neighbourIds;
@synthesize stacks = _stacks;
@synthesize tileNumber = _tileNumber;


-(id<JSONSerializable>) initFromJSON:(NSDictionary *)json{
    self = [super initFromJSON:json];
    
    _tile = [[GameResource getInstance] getTileForId:[[json objectForKey:@"hexTile"] objectForKey:@"id"]];
    _tileNumber = (int) [json objectForKey:@"hexNumber"];
    
 //   _neighbourIds = [[NSMutableArray alloc] init];
    
//    int level;
//    
//    if (_tileNumber == 0) {
//        level = 0;
//    } else if(_tileNumber >= 1 && _tileNumber <= 6){
//        level = 6;
//    } else if(_tileNumber >= 7 && _tileNumber <=18){
//        level = 12;
//    } else{
//        level = 24;
//    }
//
//    if (level == 0) {
//        [_neighbourIds addObject:@"hexLocation_1"];
//        [_neighbourIds addObject:@"hexLocation_2"];
//        [_neighbourIds addObject:@"hexLocation_3"];
//        [_neighbourIds addObject:@"hexLocation_4"];
//        [_neighbourIds addObject:@"hexLocation_5"];
//        [_neighbourIds addObject:@"hexLocation_6"];
//    } else if(level == 6){
//        [_neighbourIds addObject:[[NSString alloc] initWithFormat:@"hexLocation_%d", (_tileNumber + level + 2 )]];
//        [_neighbourIds addObject:[[NSString alloc] initWithFormat:@"hexLocation_%d", (_tileNumber + level + 1 )]];
//        [_neighbourIds addObject:[[NSString alloc] initWithFormat:@"hexLocation_%d", (_tileNumber + level + 3 )]];
//        [_neighbourIds addObject:[[NSString alloc] initWithFormat:@"hexLocation_%d", (_tileNumber +  1) % level]];
//        [_neighbourIds addObject:[[NSString alloc] initWithFormat:@"hexLocation_%d", (_tileNumber + level - 1) % level]];
//        [_neighbourIds addObject:[[NSString alloc] initWithFormat:@"hexLocation_%d", 0]];
//
//    } else if(level == 12){
//        if ((_tileNumber % 2) == 0) {
//            [_neighbourIds addObject:[[NSString alloc] initWithFormat:@"hexLocation_%d", (_tileNumber + level + 2 )]];
//            [_neighbourIds addObject:[[NSString alloc] initWithFormat:@"hexLocation_%d", (_tileNumber + level + 1 )]];
//            [_neighbourIds addObject:[[NSString alloc] initWithFormat:@"hexLocation_%d", (_tileNumber + level + 3 )]];
//            [_neighbourIds addObject:[[NSString alloc] initWithFormat:@"hexLocation_%d", (_tileNumber +  1) % level]];
//            [_neighbourIds addObject:[[NSString alloc] initWithFormat:@"hexLocation_%d", (_tileNumber + level - 1) % level]];
//            [_neighbourIds addObject:[[NSString alloc] initWithFormat:@"hexLocation_%d", (_tileNumber - (level/2))/2]];
//        } else{
//            switch (_tileNumber) {
//                case 7:
//                    [_neighbourIds addObject:[[NSString alloc] initWithFormat:@"hexLocation_%d", 1]];
//                    [_neighbourIds addObject:[[NSString alloc] initWithFormat:@"hexLocation_%d", 6]];
//                    [_neighbourIds addObject:[[NSString alloc] initWithFormat:@"hexLocation_%d", 8]];
//                    [_neighbourIds addObject:[[NSString alloc] initWithFormat:@"hexLocation_%d", 18]];
//                    [_neighbourIds addObject:[[NSString alloc] initWithFormat:@"hexLocation_%d", 19]];
//                    [_neighbourIds addObject:[[NSString alloc] initWithFormat:@"hexLocation_%d", 20]];
//                   break;
//                case 9:
//                    [_neighbourIds addObject:[[NSString alloc] initWithFormat:@"hexLocation_%d", 1]];
//                    [_neighbourIds addObject:[[NSString alloc] initWithFormat:@"hexLocation_%d", 2]];
//                    [_neighbourIds addObject:[[NSString alloc] initWithFormat:@"hexLocation_%d", 8]];
//                    [_neighbourIds addObject:[[NSString alloc] initWithFormat:@"hexLocation_%d", 10]];
//                    [_neighbourIds addObject:[[NSString alloc] initWithFormat:@"hexLocation_%d", 22]];
//                    [_neighbourIds addObject:[[NSString alloc] initWithFormat:@"hexLocation_%d", 23]];
//                    break;
//                case 11:
//                    [_neighbourIds addObject:[[NSString alloc] initWithFormat:@"hexLocation_%d", 2]];
//                    [_neighbourIds addObject:[[NSString alloc] initWithFormat:@"hexLocation_%d", 3]];
//                    [_neighbourIds addObject:[[NSString alloc] initWithFormat:@"hexLocation_%d", 10]];
//                    [_neighbourIds addObject:[[NSString alloc] initWithFormat:@"hexLocation_%d", 12]];
//                    [_neighbourIds addObject:[[NSString alloc] initWithFormat:@"hexLocation_%d", 25]];
//                    [_neighbourIds addObject:[[NSString alloc] initWithFormat:@"hexLocation_%d", 26]];
//                    break;
//                case 13:
//                    [_neighbourIds addObject:[[NSString alloc] initWithFormat:@"hexLocation_%d", 4]];
//                    [_neighbourIds addObject:[[NSString alloc] initWithFormat:@"hexLocation_%d", 3]];
//                    [_neighbourIds addObject:[[NSString alloc] initWithFormat:@"hexLocation_%d", 12]];
//                    [_neighbourIds addObject:[[NSString alloc] initWithFormat:@"hexLocation_%d", 14]];
//                    [_neighbourIds addObject:[[NSString alloc] initWithFormat:@"hexLocation_%d", 28]];
//                    [_neighbourIds addObject:[[NSString alloc] initWithFormat:@"hexLocation_%d", 29]];
//                    break;
//                case 15:
//                    [_neighbourIds addObject:[[NSString alloc] initWithFormat:@"hexLocation_%d", 4]];
//                    [_neighbourIds addObject:[[NSString alloc] initWithFormat:@"hexLocation_%d", 5]];
//                    [_neighbourIds addObject:[[NSString alloc] initWithFormat:@"hexLocation_%d", 14]];
//                    [_neighbourIds addObject:[[NSString alloc] initWithFormat:@"hexLocation_%d", 16]];
//                    [_neighbourIds addObject:[[NSString alloc] initWithFormat:@"hexLocation_%d", 32]];
//                    [_neighbourIds addObject:[[NSString alloc] initWithFormat:@"hexLocation_%d", 31]];
//                    break;
//                case 17:
//                    [_neighbourIds addObject:[[NSString alloc] initWithFormat:@"hexLocation_%d", 5]];
//                    [_neighbourIds addObject:[[NSString alloc] initWithFormat:@"hexLocation_%d", 6]];
//                    [_neighbourIds addObject:[[NSString alloc] initWithFormat:@"hexLocation_%d", 16]];
//                    [_neighbourIds addObject:[[NSString alloc] initWithFormat:@"hexLocation_%d", 18]];
//                    [_neighbourIds addObject:[[NSString alloc] initWithFormat:@"hexLocation_%d", 34]];
//                    [_neighbourIds addObject:[[NSString alloc] initWithFormat:@"hexLocation_%d", 35]];
//                    break;
//            }
//        } else if(level == 24){
//            if ((_tileNumber % 2) == 0) {
//                if (_tileNumber == 36) {
//                    [_neighbourIds addObject:[[NSString alloc] initWithFormat:@"hexLocation_%d", 18]];
//                    [_neighbourIds addObject:[[NSString alloc] initWithFormat:@"hexLocation_%d", 19]];
//                    [_neighbourIds addObject:[[NSString alloc] initWithFormat:@"hexLocation_%d", 35]];
//
//                }else{
//                    [_neighbourIds addObject:[[NSString alloc] initWithFormat:@"hexLocation_%d", (_tileNumber + 1)]];
//                    [_neighbourIds addObject:[[NSString alloc] initWithFormat:@"hexLocation_%d", (_tileNumber -1)]];
//                    [_neighbourIds addObject:[[NSString alloc] initWithFormat:@"hexLocation_%d", 16]];
//                }
//            } else{
//                if (_tileNumber == 19) {
//                    [_neighbourIds addObject:[[NSString alloc] initWithFormat:@"hexLocation_%d", 36]];
//                    [_neighbourIds addObject:[[NSString alloc] initWithFormat:@"hexLocation_%d", 20]];
//                    [_neighbourIds addObject:[[NSString alloc] initWithFormat:@"hexLocation_%d", 18]];
//                    
//                }else{
//                    [_neighbourIds addObject:[[NSString alloc] initWithFormat:@"hexLocation_%d", 5]];
//                    [_neighbourIds addObject:[[NSString alloc] initWithFormat:@"hexLocation_%d", 6]];
//                    [_neighbourIds addObject:[[NSString alloc] initWithFormat:@"hexLocation_%d", 16]];
//                    [_neighbourIds addObject:[[NSString alloc] initWithFormat:@"hexLocation_%d", 18]];
//                }
//            }
//            
//        }
//    }

    return self;
}


-(void) addStack:(Stack *)stack{
    [_stacks setObject:stack forKey:[stack locationId]];
}

-(void) removeStack: (Stack*) stack{
    [_stacks removeObjectForKey:[stack locationId]];
}


@end
