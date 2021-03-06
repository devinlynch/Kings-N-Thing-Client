//
//  GamePiece.m
//  3004iPhone
//
//  Created by John Marsh on 1/15/2014.
//
//

#import "GamePiece.h"
#import "GameState.h"
#import "BoardLocation.h"
#import "Player.h"
#import "ScaledGamePiece.h"

@implementation GamePiece

@synthesize gamePieceId = _gamePieceId;
@synthesize pieceImage  = _pieceImage;
@synthesize location    = _location;
@synthesize owner     = _owner;
@synthesize fileName  = _fileName;
@synthesize name = _name;
@synthesize isBluff = _isBluff;
@synthesize borderImage = _borderImage;

-(id) init{
    self = [super init];
    if(self) {
        _owner = nil;
        _location=nil;
        _pieceImage=nil;
        _gamePieceId=nil;
    }
    return self;
}

-(void) updateFromSerializedJson: (NSDictionary*) json forGameState: (GameState*) gameState{
    if(json != nil) {
        if([json objectForKey:@"locationId"] != nil) {
            BoardLocation *loc =[gameState getBoardLocationById:[json objectForKey:@"locationId"]];
            if(loc != nil && loc != _location) {
                [loc addGamePieceToLocation:self];
            }
        }
        if([json objectForKey:@"ownerId"] != nil) {
            Player *o=[gameState getPlayerById:[json objectForKey:@"ownerId"]];
            if(o != _owner) {
                [o assignPiece:self];
            }
        }
        if([json objectForKey:@"isBluff"] != nil) {
            _isBluff = [[json objectForKey:@"isBluff"] boolValue];
            if(_isBluff){
                _pieceImage = [[ScaledGamePiece alloc] initWithContentsOfFile:@"T_Back.png"];
            } else{
                _pieceImage = [[ScaledGamePiece alloc] initWithContentsOfFile:_fileName];
            }
        }
    }
    

    
}


-(void) changeOwnerToPlayer: (Player*) player{
    _owner = player;
}

@end
