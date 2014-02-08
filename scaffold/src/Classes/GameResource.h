//
//  GameResource.h
//  3004iPhone
//
//  Created by John Marsh on 2/6/2014.
//
//

#import <Foundation/Foundation.h>

@class GamePiece;

@interface GameResource : NSObject{
    NSMutableDictionary *_gamePieces;
}

@property NSMutableDictionary *gamePiece;

+(GameResource*) getInstance;


-(GamePiece*) getPieceForId: (NSString*) pieceId;

@end
