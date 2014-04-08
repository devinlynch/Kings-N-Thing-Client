//
//  Stack.m
//  3004iPhone
//
//  Created by John Marsh on 1/28/2014.
//
//

#import "Stack.h"
#import "HexLocation.h"
#import "GamePiece.h"
#import "ScaledGamePiece.h"
#import "Player.h"

@implementation Stack

@synthesize location = _location;
@synthesize owner = _owner;
@synthesize stackImage = _stackImage;


-(id) initFromJSON:(NSDictionary *)json withGameState: (GameState*) gameState{
    self = [super initFromJSON:json withGameState:gameState];
    
    NSString *ownerId = [json objectForKey:@"ownerId"];
    
    if ([ownerId isEqualToString:@"player1"]) {
        _stackImage = [[ScaledGamePiece alloc] initWithContentsOfFile:@"red-stack.png"];
    } else if ([ownerId isEqualToString:@"player2"]) {
        _stackImage = [[ScaledGamePiece alloc] initWithContentsOfFile:@"yellow-stack.png"];
    } else if ([ownerId isEqualToString:@"player3"]) {
        _stackImage = [[ScaledGamePiece alloc] initWithContentsOfFile:@"green-stack.png"];
    } else if ([ownerId isEqualToString:@"player4"]) {
        _stackImage = [[ScaledGamePiece alloc] initWithContentsOfFile:@"blue-stack.png"];
    }
    
    [_stackImage setOwner:self];
    
    return self;
}

-(void) addGamePieceToLocation:(GamePiece *)piece{
    [super addGamePieceToLocation:piece];
    [piece.pieceImage removeFromParent];
}

-(void) destroy{
    [self.location removeStack:self];
    self.location = nil;
    self.owner = nil;
    [self.stackImage removeFromParent];
}

@end
