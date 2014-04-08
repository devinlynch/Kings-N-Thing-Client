//
//  DefectionMenu.h
//  3004iPhone
//
//  Created by Devin Lynch on 2014-04-07.
//
//

#import "PiecesMenu.h"

@class RandomEventsMenu;
@interface DefectionMenu : PiecesMenu
-(id) initFromParent:(RandomEventsMenu *)parent withDefectionPiece: (GamePiece*) defectionPiece;
@end
