//
//  YourPiecesMenu.m
//  3004iPhone
//
//  Created by Richard Ison on 2014-03-27.
//
//

#import "PiecesMenu.h"
#import "GameResource.h"
#import "GamePiece.h"
#import "InGameServerAccess.h"
#import "Utils.h"
#import "HexLocation.h"
#import "Player.h"

@implementation PiecesMenu{    
    GamePiece *_selectedPiece;
    SPImage *borderImage;
    BOOL _isOpposingPlayer;
}

@synthesize location = _location;
@synthesize player = _player;

-(id) initForPlayer: (Player*) player onLocation: (BoardLocation*) location withParent: (SPSprite*) parent andIsOpposingPlayer: (BOOL) isOpposingPlayer
{
    if ((self = [super initFromParent:parent]))
    {
        _player = player;
        _location = location;
        _isOpposingPlayer = isOpposingPlayer;
        [self setup];
    }
    
    return self;
}


-(void) setup{
    [super setup];
    
    NSString *bgImageName = @"YourPiecesBackground@2x.png";
    if(_isOpposingPlayer) {
        bgImageName = @"EnemyPiecesBackground@2x.png";
    }
    
    SPImage *background = [[SPImage alloc] initWithContentsOfFile:bgImageName];
    background.x = 0;
    background.y = 0;
    
    [_contents addChild:background];
    

    
    NSArray *pieces = [_location getAllPiecesForPlayer:_player];
    
    int numInRow=1;
    int row=1;
    for(GamePiece *gp in pieces) {
        SPButton *_selectedPieceImage;
        SPTexture *text = [SPTexture textureWithContentsOfFile:[gp fileName]];
        _selectedPieceImage = [SPButton buttonWithUpState:text];
        _selectedPieceImage.x = (_gameWidth/4)*numInRow-70;
        _selectedPieceImage.y = 40+(90*row);
        [_selectedPieceImage setName:gp.gamePieceId];
        
        [_selectedPieceImage addEventListener:@selector(didClickOnRecruit:) atObject:self forType:SP_EVENT_TYPE_TRIGGERED];
        
        [_contents addChild:_selectedPieceImage];
        numInRow++;
        if(numInRow>5) {
            row++;
            numInRow=1;
        }
    }
    
    //Username text
    SPTextField *welcomeTF = [SPTextField textFieldWithWidth:300 height:120
                                                        text:_player.user.username];
    welcomeTF.x = welcomeTF.y = 10;
    welcomeTF.fontName = @"ArialMT";
    welcomeTF.fontSize = 25;
    welcomeTF.color = 0xffffff;
    [_contents addChild:welcomeTF];
    
    
    
    //Done Button
    SPTexture *skipButtonTexture = [SPTexture textureWithContentsOfFile:@"done.png"];
    SPButton *skipButton = [SPButton buttonWithUpState:skipButtonTexture];
    skipButton.x = _gameWidth /2 - skipButton.width/2 + 20;
    skipButton.y = 480;
    skipButton.scaleX = skipButton.scaleY = 0.8;
    [_contents addChild:skipButton];
    [skipButton addEventListener:@selector(didClickOnSkip:) atObject:self forType:SP_EVENT_TYPE_TRIGGERED];
}

-(void) didClickOnPlay:(SPTouchEvent*) event{
    NSArray *touches = [[event touchesWithTarget:self andPhase:SPTouchPhaseBegan] allObjects];
    
    
    if (touches.count == 1) {
        
        // Find card id, show pop up of description
        
        
    } else if (touches.count == 2){
        
        //Selects the card
        
        
    }
    
    
}
-(void) didClickOnRecruit:(SPEvent *) event{
    SPImage *selectedPiece = (SPImage*)event.target;
    
    if(borderImage != nil) {
        [borderImage removeFromParent];
    }
    
    _selectedPiece = [[GameResource getInstance] getPieceForId:selectedPiece.name];
    if(_selectedPiece != nil) {
        borderImage = [[SPImage alloc] initWithContentsOfFile:@"borderTile.png"];
        borderImage.x = selectedPiece.x;
        borderImage.y = selectedPiece.y;
    }
    
    [_contents addChild:borderImage];
}


- (void) didClickOnSkip:(SPEvent *) event{
    [self hide];
}

@end
