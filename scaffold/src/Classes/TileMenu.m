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
#import "Game.h"
#import "GameState.h"
#import "PiecesMenu.h"

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
    Stack    *_selectedStack;
    SPImage  *_selectedStackImage;
    SPImage  *_selectedPieceImage;
    SPTextField *_selectedText;
    PiecesMenu *_stackMenu;
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
        SPImage *stackImage;
        if ([[[stack owner] playerId] isEqualToString:@"player1"]) {
            stackImage = [[ScaledGamePiece alloc] initWithContentsOfFile:@"red-stack.png"];
        } else if ([[[stack owner] playerId] isEqualToString:@"player2"]) {
            stackImage = [[ScaledGamePiece alloc] initWithContentsOfFile:@"yellow-stack.png"];
        } else if ([[[stack owner] playerId] isEqualToString:@"player3"]) {
            stackImage = [[ScaledGamePiece alloc] initWithContentsOfFile:@"green-stack.png"];
        } else if ([[[stack owner] playerId] isEqualToString:@"player4"]) {
            stackImage = [[ScaledGamePiece alloc] initWithContentsOfFile:@"blue-stack.png"];
        }

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
        
        SPImage *borderImage;
        if ([[[piece owner] playerId] isEqualToString:@"player1"]) {
            borderImage = [[ScaledGamePiece alloc] initWithContentsOfFile:@"borderTileRed.png"];
        } else if ([[[piece owner] playerId] isEqualToString:@"player2"]) {
            borderImage = [[ScaledGamePiece alloc] initWithContentsOfFile:@"borderTileYellow.png"];
        } else if ([[[piece owner] playerId] isEqualToString:@"player3"]) {
            borderImage = [[ScaledGamePiece alloc] initWithContentsOfFile:@"borderTileGreen.png"];
        } else if ([[[piece owner] playerId] isEqualToString:@"player4"]) {
            borderImage = [[ScaledGamePiece alloc] initWithContentsOfFile:@"borderTileBlue.png"];
        }
        
        borderImage.x = x;
        borderImage.y = y;
        borderImage.width = pieceImage.width;
        borderImage.height = pieceImage.height;
        borderImage.touchable = NO;

        
        [_contents addChild:borderImage];
        
        
        if((x + pieceImage.x) > _gameWidth){
            x = 10;
            y = y + pieceImage.height + 5;
        } else{
            x = x + pieceImage.width + 5;
        }
        
    }
    
    SPTexture *backButtonTexture= [SPTexture textureWithContentsOfFile:@"back.png"];
    SPButton *backButton = [SPButton buttonWithUpState:backButtonTexture];
    
    backButton.x = 320 / 2 - backButton.width /2;
    backButton.y = 410;
    
    _selectedText = [SPTextField textFieldWithWidth:200 height:30 text:@"Selected:"];
    _selectedText.x = 320 / 2 - _selectedText.width;
    _selectedText.y = backButton.y - 35;
    _selectedText.color = SP_YELLOW;
    [_contents addChild:_selectedText];
    [_contents addChild:backButton];

    
    [backButton addEventListener:@selector(onButtonTriggered:) atObject:self forType:SP_EVENT_TYPE_TRIGGERED];





}


-(void) onStackSelected: (SPTouchEvent *) event
{
    SPImage *img = (SPImage*) event.target;
    
    NSArray *touches = [[event touchesWithTarget:self andPhase:SPTouchPhaseBegan] allObjects];
    
    Stack *stack = [[_location stacks] objectForKey:img.name];
    
    
    if (touches.count == 1)
    {
        SPTouch *clicks = [touches objectAtIndex:0];
        
        if (clicks.tapCount == 1){
            [self performSelector:@selector(stackSingleTap:) withObject:stack afterDelay:0.35f];
            
        } else if(clicks.tapCount == 2){
            [NSObject cancelPreviousPerformRequestsWithTarget:self];
            [self stackDoubleTap:stack];
        }
    }
    
}

-(void) stackSingleTap: (Stack*) stack{
    
    NSArray *pieces = [[NSArray alloc] initWithObjects:_selectedPiece.gamePieceId,nil];

    
    if (_selectedPiece != nil) {
        [[InGameServerAccess instance] movementPhaseAddPiecesToStack:stack.locationId pieces:pieces withSuccess:^(ServerResponseMessage *message){
            dispatch_async(dispatch_get_main_queue(), ^{
                [stack addGamePieceToLocation:_selectedPiece];
                [_contents removeAllChildren];
                [self setupWithLocation:_location];
            });
        }];
    }else{
        [_selectedPieceImage removeFromParent];
        _selectedStack = stack;
        _selectedStackImage = [[SPImage alloc] initWithTexture:_selectedStack.stackImage.texture];
        _selectedStackImage.x = _selectedText.x + 100;
        _selectedStackImage.y = _selectedText.y - 25;
        [_contents addChild:_selectedStackImage];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"pieceSelected" object:stack];

    }
    
    
}


-(void) stackDoubleTap: (Stack*) stack{
    Player* me  = [[[Game currentGame] gameState] getMe];
    
    _stackMenu = [[PiecesMenu alloc] initForPlayer:stack.owner onLocation:stack withParent:_contents andIsOpposingPlayer:(me!=stack.owner)];
    
    [_stackMenu show];
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
    [_selectedStackImage removeFromParent];
    
    _selectedPieceImage = [[SPImage alloc] initWithContentsOfFile:[_selectedPiece fileName]];
    _selectedPieceImage.x = _selectedText.x + 150;
    _selectedPieceImage.y = _selectedText.y - 25;
    [_contents addChild:_selectedPieceImage];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"pieceSelected" object:piece];
    
    //_contents.visible = NO;
}

-(void) pieceDoubleTap: (SPImage*) img{
    if(_selectedPiece != nil){
        
        GamePiece *piece = [[GameResource getInstance] getPieceForId:img.name];
        
        NSArray *pieces = [[NSArray alloc] initWithObjects:piece.gamePieceId, _selectedPiece.gamePieceId,nil];
        
        Stack *newStack = [[Stack alloc] init];
    
        [[InGameServerAccess instance] movementPhaseCreateStack:[_location locationId] withPieces:pieces withSuccess:^(ServerResponseMessage *message){
            dispatch_async(dispatch_get_main_queue(), ^{
                if(message.data != nil && message.data.map != nil && [message.data.map objectForKey:@"createdStackId"] != nil) {
                    [newStack setLocationId:[message.data.map objectForKey:@"createdStackId"]];
                    [newStack addGamePieceToLocation:piece];
                    [newStack addGamePieceToLocation:_selectedPiece];
                    [newStack setOwner:[[[Game currentGame]gameState]getPlayerById:[[[Game currentGame] gameState]myPlayerId]]];
                    if ([[[[Game currentGame] gameState] myPlayerId] isEqualToString:@"player1"]) {
                        newStack.stackImage = [[ScaledGamePiece alloc] initWithContentsOfFile:@"red-stack.png"];
                        newStack.owner = [[[Game currentGame] gameState] getPlayerById:@"player1"];
                    } else if ([[[[Game currentGame] gameState] myPlayerId] isEqualToString:@"player2"]) {
                        newStack.stackImage = [[ScaledGamePiece alloc] initWithContentsOfFile:@"yellow-stack.png"];
                        newStack.owner = [[[Game currentGame] gameState] getPlayerById:@"player2"];
                    } else if ([[[[Game currentGame] gameState] myPlayerId] isEqualToString:@"player3"]) {
                        newStack.stackImage = [[ScaledGamePiece alloc] initWithContentsOfFile:@"green-stack.png"];
                        newStack.owner = [[[Game currentGame] gameState] getPlayerById:@"player3"];
                    } else if ([[[[Game currentGame] gameState] myPlayerId] isEqualToString:@"player4"]) {
                        newStack.stackImage = [[ScaledGamePiece alloc] initWithContentsOfFile:@"blue-stack.png"];
                        newStack.owner = [[[Game currentGame]  gameState] getPlayerById:@"player4"];
                    }
                    
                    
                    [newStack.stackImage setOwner:(id<NSCopying>)newStack];
                    [_location addStack:newStack];
                    [_contents removeAllChildren];
                    [_selectedPieceImage removeFromParent];
                    _selectedPiece = nil;
                    [self setupWithLocation:_location];
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"clearSelectedPiece" object:nil];
                }
            });
        }];
        
        
    }
}


-(void) onButtonTriggered: (SPEvent *) event
{
    NSLog(@"Back to board things");
    _contents.visible = NO;
    
}

-(void) setSelectedPiece: (GamePiece*) piece{
    [self pieceSingleTap:piece];
}


@end
