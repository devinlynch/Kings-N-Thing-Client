//
//  RackPiecesMenu.m
//  3004iPhone
//
//  Created by Devin Lynch on 2014-04-05.
//
//

#import "RackPiecesMenu.h"
#import "GamePiece.h"
#import "GameResource.h"

@implementation RackPiecesMenu

-(void) didClickOnRecruit:(SPEvent *) event{
    [super didClickOnRecruit: event];
    
    SPImage *selectedPiece = (SPImage*)event.target;
    
    GamePiece *gp = [[GameResource getInstance] getPieceForId:selectedPiece.name];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"pieceSelected" object:gp];
}

@end
