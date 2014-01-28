//
//  FourPlayerGame.m
//  3004iPhone
//
//  Created by Richard Ison on 1/28/2014.
//
//

#import "FourPlayerGame.h"
#import "ScaledGamePiece.h"
#import "TouchSheet.h"
#import "TileMenu.h"
#import "Scene.h"

@interface FourPlayerGame ()
- (void) setup;
- (void) showScene:(SPSprite*)scene;
@end

@implementation FourPlayerGame{
    NSMutableArray *gamePieces;
    
    SPSprite *_currentScene;
    SPSprite *_contents;
    
    TouchSheet *_sheet;
    
    int _gameWidth;
    int _gameHeight;
    
    SPImage *_backTile;
}

-(id) init
{
    if ((self = [super init]))
    {
        [self setup];
    }
    return self;
}

-(void) setup
{

    _gameWidth = Sparrow.stage.width;
    _gameHeight = Sparrow.stage.height;
    
    gamePieces = [[NSMutableArray alloc]init];
    
    _contents = [SPSprite sprite];
    [self addChild:_contents];
    
    SPImage *background = [[SPImage alloc] initWithContentsOfFile:@"masterGameBoard.png"];
    
    //necessary or else it gets placed off screen
    background.x = 0;
    background.y = 0;
    
    // used to handle movement and zooming of board
   // TouchSheet *sheet = [[TouchSheet alloc] initWithQuad:background];
    //TouchSheet *sheet = [[TouchSheet alloc] initWithQuad:background];
    _sheet = [[TouchSheet alloc] initWithQuad:background];
    
    //Add the sheet to the contents so that it appears
  //  [_contents addChild:sheet];
    //Add the sheet to the contents so that it appears
    [_contents addChild:_sheet];
    
    //Draw tiles
    [self drawTiles];
}

-(void) drawTiles
{
    //Hexagon
    
    //Drawing hexagons for middle (5)
    for (int i = 0; i < 5; i++){
        bool drawNext = false;
        _backTile = [[SPImage alloc]initWithContentsOfFile:@"back-tile.png"];
        _backTile.x = 133;
        _backTile.y = 20 + ((i  * (_backTile.height + 4)));
        
        //Draw missing tile
        if (i == 1){
            drawNext = true;
            _backTile = [[SPImage alloc]initWithContentsOfFile:@"back-tile.png"];
            _backTile.x = 133;
            _backTile.y = 20 + ((i  * (_backTile.height + 4)));
            [_sheet addChild: _backTile];
            
            [_backTile addEventListener:@selector(onClickTile:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
            
        }
        
        if (drawNext) {
            //Drawing hexagon for left side after first hexagon (4)
            for (int j = 0; j < 4; j ++) {
                _backTile = [[SPImage alloc]initWithContentsOfFile:@"back-tile.png"];
                _backTile.x = 133 - (_backTile.width - 10);
                _backTile.y = 20 + ((j  * (_backTile.height + 4))) + _backTile.height /2 ;
                [_sheet addChild: _backTile];
                
                [_backTile addEventListener:@selector(onClickTile:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
                
            }
            
            //Drawing hexagon for right side after first hexagon (4)
            for (int j = 0; j < 4; j ++) {
                _backTile = [[SPImage alloc]initWithContentsOfFile:@"back-tile.png"];
                _backTile.x = 133 + (_backTile.width - 10);
                _backTile.y = 20 + ((j  * (_backTile.height + 4))) + _backTile.height /2 ;
                [_sheet addChild: _backTile];
                
                [_backTile addEventListener:@selector(onClickTile:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
                
            }
            drawNext = false;
        }
        
        //Draw missing tile 2
        if (i == 2){
            drawNext = true;
            _backTile = [[SPImage alloc]initWithContentsOfFile:@"back-tile.png"];
            _backTile.x = 133;
            _backTile.y = 20 + ((i  * (_backTile.height + 4)));
            [_sheet addChild: _backTile];
            
            [_backTile addEventListener:@selector(onClickTile:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
            
        }
        if (drawNext) {
            //Drawing hexagon for left side after first hexagon (3)
            for (int j = 0; j < 3; j ++) {
                _backTile = [[SPImage alloc]initWithContentsOfFile:@"back-tile.png"];
                _backTile.x = 133 - ((_backTile.width * 2) - 20);
                _backTile.y = 20 + ((j  * (_backTile.height + 4))) + (_backTile.height) ;
                [_sheet addChild: _backTile];
                
                [_backTile addEventListener:@selector(onClickTile:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
            }
            
            //Drawing hexagon for right side after first hexagon (3)
            for (int j = 0; j < 3; j ++) {
                _backTile = [[SPImage alloc]initWithContentsOfFile:@"back-tile.png"];
                _backTile.x = 133 + ((_backTile.width * 2) - 20);
                _backTile.y = 20 + ((j  * (_backTile.height + 4))) + (_backTile.height) ;
                [_sheet addChild: _backTile];
                
                [_backTile addEventListener:@selector(onClickTile:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
            }
            
            drawNext = false;
        }
        
        [_sheet addChild: _backTile];
        
        
        [_backTile addEventListener:@selector(onClickTile:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    }
    


}

-(void) showScene:(SPSprite *)scene
{
    [self addChild:scene];
    scene.visible = YES;

}

@end
