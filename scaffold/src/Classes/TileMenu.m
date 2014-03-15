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
    _gameWidth = Sparrow.stage.width;
    _gameHeight = Sparrow.stage.height;
    
    _contents = [SPSprite sprite];
    [self addChild:_contents];
    
    int offset = 10;
    
    SPImage *tileImage = [[SPImage alloc] initWithContentsOfFile: [NSString stringWithFormat:@"%@-menu@2x.png",[[location tile] fileName]]];
    [_contents addChild:tileImage];
    
    int x = 10;
    int y = 10;
    
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
    
    [_contents addChild:createStackButton];
    [_contents addChild:backButton];

    
    [backButton addEventListener:@selector(onButtonTriggered:) atObject:self forType:SP_EVENT_TYPE_TRIGGERED];





}


-(void) onPieceSelected: (SPEvent *) event
{
    SPImage *img = (SPImage*) event.target;
    
    GamePiece *gamePiece = [[GameResource getInstance] getPieceForId:img.name];
    
    NSLog(@"Back to board things");
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"recruitToBoardFree" object:gamePiece];
    
    _contents.visible = NO;
    
}

-(void) onButtonTriggered: (SPEvent *) event
{
    NSLog(@"Back to board things");
    _contents.visible = NO;
    
}


@end
