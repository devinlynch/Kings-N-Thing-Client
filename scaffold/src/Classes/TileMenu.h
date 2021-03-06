//
//  TileMenu.h
//  3004iPhone
//
//  Created by Richard Ison on 2/9/2014.
//
//

#import "SPSprite.h"

@class HexLocation, GamePiece;

@interface TileMenu : SPSprite

-(TileMenu*) initWithHexLocation: (HexLocation*) location;

-(void) setSelectedPiece: (GamePiece*) piece;

@end
