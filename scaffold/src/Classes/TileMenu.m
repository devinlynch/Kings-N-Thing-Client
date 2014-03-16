//
//  TileMenu.m
//  3004iPhone
//
//  Created by Richard Ison on 2/9/2014.
//
//

#import "TileMenu.h"



#import "TileMenu.h"
#import "TwoThreePlayerGame.h"
#import "Scene.h"
#import "ScaledGamePiece.h"
#import "HexLocation.h"
#import "HexTile.h"
#import "GamePiece.h"
#import "GameResource.h"
#import "Stack.h"
#import "InGameServerAccess.h"


@interface TileMenu ()
- (void) setup;
- (void) showScene:(SPSprite*)scene;
@end



@implementation TileMenu
{
    SPSprite *_contents;
    SPSprite *_currentScene;
    
    int _gameWidth;
    int _gameHeight;
    
    HexLocation *_location;
    GamePiece *_selectedPiece;
    SPImage  *_selectedPieceImage;
    SPTextField *_selectedText;
}


-(id) initWithHexLocation: (HexLocation*) location;
{
    if ((self = [super init]))
    {
        [self setupWithLocation:location];
    }
    return self;
}


-(void) setupWithLocation: (HexLocation*) location;
{
    
    _location = location;
    
    _gameWidth = Sparrow.stage.width;
    _gameHeight = Sparrow.stage.height;
    
    _contents = [SPSprite sprite];
    [self addChild:_contents];
    

    
    int offset = 10;
    
    SPImage *tileImage = [[SPImage alloc] initWithContentsOfFile: [NSString stringWithFormat:@"%@-menu@2x.png",[[location tile] fileName]]];
    [_contents addChild:tileImage];
    
    int x = 10;
    int y = 10;
    
    for (NSString *key in [location stacks]) {
        Stack *stack = [[location stacks] objectForKey:key];
        SPImage *stackImage = [[SPImage alloc] initWithContentsOfFile:@"T_Back.png"];
        stackImage.name = [stack locationId];
        stackImage.x = x;
        stackImage.y = y;
        
        [stackImage addEventListener:@selector(onStackSelected:) atObject:self forType:SP_EVENT_TYPE_TOUCH];

        
        [_contents addChild:stackImage];
        
        if((x + stackImage.x) > _gameWidth){
            x = 10;
            y = y + stackImage.y + 5;
        } else{
            x = x + stackImage.width + 5;
        }


    }
    
    for (NSString *key in [location pieces]) {
        GamePiece *piece = [[location pieces] objectForKey:key];
        SPImage *pieceImage = [[SPImage alloc] initWithContentsOfFile: [NSString stringWithFormat:@"%@",[piece fileName]]];
        pieceImage.name = [piece gamePieceId];
        pieceImage.x = x;
        pieceImage.y = y;
        
        [pieceImage addEventListener:@selector(onPieceSelected:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
        
        [_contents addChild:pieceImage];
        
        if((x + pieceImage.x) > _gameWidth){
            x = 10;
            y = y + pieceImage.y + 5;
        } else{
            x = x + pieceImage.width + 5;
        }
        
    }
    
    SPTexture *backButtonTexture= [SPTexture textureWithContentsOfFile:@"back.png"];
    SPButton *backButton = [SPButton buttonWithUpState:backButtonTexture];
    
    backButton.x = 320 / 2 - backButton.width /2;
    backButton.y = 410;
    
    SPTexture *buttonTexture = [SPTexture textureWithContentsOfFile:@"Button-Normal@2x.png"];
    SPButton *createStackButton = [SPButton buttonWithUpState:buttonTexture text:@"Create Stack"];
    
    createStackButton.x = 320 / 2 - createStackButton.width /2;
    createStackButton.y = 410 - createStackButton.height + 5;
    
    _selectedText = [SPTextField textFieldWithWidth:200 height:30 text:@"Selected:"];
    _selectedText.x = 320 / 2 - _selectedText.width /2;
    _selectedText.y = createStackButton.y - 35;
    _selectedText.color = SP_YELLOW;
    [_contents addChild:_selectedText];
    
    [_contents addChild:createStackButton];
    [_contents addChild:backButton];

    
    [backButton addEventListener:@selector(onButtonTriggered:) atObject:self forType:SP_EVENT_TYPE_TRIGGERED];





}


-(void) onStackSelected: (SPTouchEvent *) event
{
    SPImage *img = (SPImage*) event.target;
    
    NSArray *touches = [[event touchesWithTarget:self andPhase:SPTouchPhaseBegan] allObjects];
    
    Stack *stack = [[_location stacks] objectForKey:img.name];
    
    SPTouch *clicks = [touches objectAtIndex:0];
    
    if (clicks.tapCount == 1){
        
    } else if(clicks.tapCount == 2){
        [NSObject cancelPreviousPerformRequestsWithTarget:self];
    }
    
}

-(void) onPieceSelected: (SPTouchEvent *) event
{
    SPImage *img = (SPImage*) event.target;
    
    NSArray *touches = [[event touchesWithTarget:self andPhase:SPTouchPhaseBegan] allObjects];
    
    GamePiece *gamePiece = [[GameResource getInstance] getPieceForId:img.name];
    
    if (touches.count == 1)
    {
        SPTouch *clicks = [touches objectAtIndex:0];
        
        if (clicks.tapCount == 1){
            [self performSelector:@selector(pieceSingleTap:) withObject:gamePiece afterDelay:0.35f];
            
        } else if(clicks.tapCount == 2){
            [NSObject cancelPreviousPerformRequestsWithTarget:self];
            [self pieceDoubleTap:img];
        }
    }
    
}

-(void) pieceSingleTap: (GamePiece*) piece{
    
    NSLog(@"Back to board things");
    
    _selectedPiece = piece;
    
    [_selectedPieceImage removeFromParent];
    
    _selectedPieceImage = [[SPImage alloc] initWithContentsOfFile:[_selectedPiece fileName]];
    _selectedPieceImage.x = _selectedText.x + 100;
    _selectedPieceImage.y = _selectedText.y - 25;
    [_contents addChild:_selectedPieceImage];
    
    //[[NSNotificationCenter defaultCenter] postNotificationName:@"recruitToBoardFree" object:piece];
    
    //_contents.visible = NO;
}

-(void) pieceDoubleTap: (SPImage*) img{
    if(_selectedPiece != nil){
        
        GamePiece *piece = [[GameResource getInstance] getPieceForId:img.name];
        
        NSArray *pieces = [[NSArray alloc] initWithObjects:piece.gamePieceId, _selectedPiece.gamePieceId,nil];
        
        [[InGameServerAccess instance] movementPhaseCreateStack:[_location locationId] withPieces:pieces];
        
        
        [_contents removeAllChildren];
        
        [self setupWithLocation:_location];
    }
}


-(void) onButtonTriggered: (SPEvent *) event
{
    NSLog(@"Back to board things");
    _contents.visible = NO;
    
}


@end
