//
//  Move.h
//  3004iPhone
//
//  Created by John Marsh on 1/28/2014.
//
//

#import <Foundation/Foundation.h>

@interface Move : NSObject{
    NSString *_moveMadeByID;
    NSString *_pieceID;
    NSString *_destinationID;
    NSString *_originID;
}

@property NSString *moveMadeByID, *pieceID, *destinationID, *originID;

-(Move*) initWithMoveMadeBy: (NSString*) moveMadeBy movingPiece: (NSString*) gamePiece toDestination: (NSString*) destination fromOrigin: (NSString*) origin;

@end
