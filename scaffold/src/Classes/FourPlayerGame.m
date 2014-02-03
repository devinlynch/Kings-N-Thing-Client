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
    
    SPImage *_hexTile;
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
    //Drawing hexagons for middle (7)
    for (int i = 0; i < 7; i++){
        
        bool drawNext = false;
        
        if (i == 0) {
            drawNext = true;
            _hexTile = [[SPImage alloc]initWithContentsOfFile:@"jungle-tile.png"];
            _hexTile.x = 133;
            _hexTile.y = 20 + ((i  * (_hexTile.height + 4)));
            [_sheet addChild: _hexTile];;
        }
        
        if (i == 4) {
            drawNext = true;
            _hexTile = [[SPImage alloc]initWithContentsOfFile:@"sea-tile.png"];
            _hexTile.x = 133;
            _hexTile.y = 20 + ((i  * (_hexTile.height + 4)));
            [_sheet addChild: _hexTile];;
        }
        if (i == 5) {
            drawNext = true;
            _hexTile = [[SPImage alloc]initWithContentsOfFile:@"forest-tile.png"];
            _hexTile.x = 133;
            _hexTile.y = 20 + ((i  * (_hexTile.height + 4)));
            [_sheet addChild: _hexTile];;
        }
        if (i == 6) {
            drawNext = true;
            _hexTile = [[SPImage alloc]initWithContentsOfFile:@"desert-tile.png"];
            _hexTile.x = 133;
            _hexTile.y = 20 + ((i  * (_hexTile.height + 4)));
            [_sheet addChild: _hexTile];;
        }
        
        //Draw missing tile
        if (i == 1){
            drawNext = true;
            _hexTile = [[SPImage alloc]initWithContentsOfFile:@"frozen-tile.png"];
            _hexTile.x = 133;
            _hexTile.y = 20 + ((i  * (_hexTile.height + 4)));
            [_sheet addChild: _hexTile];
        }
        
        
        if (drawNext) {
            //Drawing hexagon for left side after first hexagon (6)
            for (int j = 0; j < 6; j ++) {
                
                
                if (j == 0){
                    _hexTile = [[SPImage alloc]initWithContentsOfFile:@"mountain-tile.png"];
                    _hexTile.x = 133 - (_hexTile.width - 10);
                    _hexTile.y = 20 + ((j  * (_hexTile.height + 4))) + _hexTile.height /2 ;
                    [_sheet addChild: _hexTile];
                }
                
                if (j == 1){
                    _hexTile = [[SPImage alloc]initWithContentsOfFile:@"plaines-tile.png"];
                    _hexTile.x = 133 - (_hexTile.width - 10);
                    _hexTile.y = 20 + ((j  * (_hexTile.height + 4))) + _hexTile.height /2 ;
                    [_sheet addChild: _hexTile];
                }
                if (j == 2){
                    _hexTile = [[SPImage alloc]initWithContentsOfFile:@"swamp-tile.png"];
                    _hexTile.x = 133 - (_hexTile.width - 10);
                    _hexTile.y = 20 + ((j  * (_hexTile.height + 4))) + _hexTile.height /2 ;
                    [_sheet addChild: _hexTile];
                }
                if (j == 3){
                    _hexTile = [[SPImage alloc]initWithContentsOfFile:@"forest-tile.png"];
                    _hexTile.x = 133 - (_hexTile.width - 10);
                    _hexTile.y = 20 + ((j  * (_hexTile.height + 4))) + _hexTile.height /2 ;
                    [_sheet addChild: _hexTile];
                }
                if (j == 4){
                    _hexTile = [[SPImage alloc]initWithContentsOfFile:@"desert-tile.png"];
                    _hexTile.x = 133 - (_hexTile.width - 10);
                    _hexTile.y = 20 + ((j  * (_hexTile.height + 4))) + _hexTile.height /2 ;
                    [_sheet addChild: _hexTile];
                }
                if (j == 5){
                    _hexTile = [[SPImage alloc]initWithContentsOfFile:@"plaines-tile.png"];
                    _hexTile.x = 133 - (_hexTile.width - 10);
                    _hexTile.y = 20 + ((j  * (_hexTile.height + 4))) + _hexTile.height /2 ;
                    [_sheet addChild: _hexTile];
                }
                
        }
            
            //Drawing hexagon for right side after first hexagon (6)
            for (int j = 0; j < 6; j ++) {
                
                if (j == 0){
                    _hexTile = [[SPImage alloc]initWithContentsOfFile:@"swamp-tile.png"];
                    _hexTile.x = 133 + (_hexTile.width - 10);
                    _hexTile.y = 20 + ((j  * (_hexTile.height + 4))) + _hexTile.height /2 ;
                    [_sheet addChild: _hexTile];
                }
                
                if (j == 1){
                    _hexTile = [[SPImage alloc]initWithContentsOfFile:@"mountain-tile.png"];
                    _hexTile.x = 133 + (_hexTile.width - 10);
                    _hexTile.y = 20 + ((j  * (_hexTile.height + 4))) + _hexTile.height /2 ;
                    [_sheet addChild: _hexTile];
                }
                if (j == 2){
                    _hexTile = [[SPImage alloc]initWithContentsOfFile:@"jungle-tile.png"];
                    _hexTile.x = 133 + (_hexTile.width - 10);
                    _hexTile.y = 20 + ((j  * (_hexTile.height + 4))) + _hexTile.height /2 ;
                    [_sheet addChild: _hexTile];
                }
                if (j == 3){
                    _hexTile = [[SPImage alloc]initWithContentsOfFile:@"plaines-tile.png"];
                    _hexTile.x = 133 + (_hexTile.width - 10);
                    _hexTile.y = 20 + ((j  * (_hexTile.height + 4))) + _hexTile.height /2 ;
                    [_sheet addChild: _hexTile];
                }
                if (j == 4){
                    _hexTile = [[SPImage alloc]initWithContentsOfFile:@"swamp-tile.png"];
                    _hexTile.x = 133 + (_hexTile.width - 10);
                    _hexTile.y = 20 + ((j  * (_hexTile.height + 4))) + _hexTile.height /2 ;
                    [_sheet addChild: _hexTile];
                }
                if (j == 5){
                    _hexTile = [[SPImage alloc]initWithContentsOfFile:@"mountain-tile.png"];
                    _hexTile.x = 133 + (_hexTile.width - 10);
                    _hexTile.y = 20 + ((j  * (_hexTile.height + 4))) + _hexTile.height /2 ;
                    [_sheet addChild: _hexTile];
                }

                
                
                
            }
            
            drawNext = false;
        }
        
        //Draw missing tile 2
        if (i == 2){
            drawNext = true;
            _hexTile = [[SPImage alloc]initWithContentsOfFile:@"forest-tile.png"];
            _hexTile.x = 133;
            _hexTile.y = 20 + ((i  * (_hexTile.height + 4)));
            [_sheet addChild: _hexTile];
            
            
            
        }
        
      //Draw thrid row
        
        if (drawNext) {
            //Drawing hexagon for left side after first hexagon (5)
            for (int j = 0; j < 5; j ++) {
   
                if (j == 0 ){
                    _hexTile = [[SPImage alloc]initWithContentsOfFile:@"swamp-tile.png"];
                    _hexTile.x = 133 - ((_hexTile.width * 2) - 20);
                    _hexTile.y = 20 + ((j  * (_hexTile.height + 4))) + (_hexTile.height) ;
                    [_sheet addChild: _hexTile];
                }
                if (j == 1 ){
                    _hexTile = [[SPImage alloc]initWithContentsOfFile:@"jungle-tile.png"];
                    _hexTile.x = 133 - ((_hexTile.width * 2) - 20);
                    _hexTile.y = 20 + ((j  * (_hexTile.height + 4))) + (_hexTile.height) ;
                    [_sheet addChild: _hexTile];
                }
                if (j == 2 ){
                    _hexTile = [[SPImage alloc]initWithContentsOfFile:@"mountain-tile.png"];
                    _hexTile.x = 133 - ((_hexTile.width * 2) - 20);
                    _hexTile.y = 20 + ((j  * (_hexTile.height + 4))) + (_hexTile.height) ;
                    [_sheet addChild: _hexTile];
                }
                if (j == 3 ){
                    _hexTile = [[SPImage alloc]initWithContentsOfFile:@"plaines-tile.png"];
                    _hexTile.x = 133 - ((_hexTile.width * 2) - 20);
                    _hexTile.y = 20 + ((j  * (_hexTile.height + 4))) + (_hexTile.height) ;
                    [_sheet addChild: _hexTile];
                }
                if (j == 4 ){
                    _hexTile = [[SPImage alloc]initWithContentsOfFile:@"jungle-tile.png"];
                    _hexTile.x = 133 - ((_hexTile.width * 2) - 20);
                    _hexTile.y = 20 + ((j  * (_hexTile.height + 4))) + (_hexTile.height) ;
                    [_sheet addChild: _hexTile];
                }
                
                
            }
            
            //Drawing hexagon for right side after first hexagon (5)
            for (int j = 0; j < 5; j ++) {
                
                if (j == 0) {
                    _hexTile = [[SPImage alloc]initWithContentsOfFile:@"desert-tile.png"];
                    _hexTile.x = 133 + ((_hexTile.width * 2) - 20);
                    _hexTile.y = 20 + ((j  * (_hexTile.height + 4))) + (_hexTile.height) ;
                    [_sheet addChild: _hexTile];
                }
                if (j == 1) {
                    _hexTile = [[SPImage alloc]initWithContentsOfFile:@"frozen-tile.png"];
                    _hexTile.x = 133 + ((_hexTile.width * 2) - 20);
                    _hexTile.y = 20 + ((j  * (_hexTile.height + 4))) + (_hexTile.height) ;
                    [_sheet addChild: _hexTile];
                }
                if (j == 2) {
                    _hexTile = [[SPImage alloc]initWithContentsOfFile:@"swamp-tile.png"];
                    _hexTile.x = 133 + ((_hexTile.width * 2) - 20);
                    _hexTile.y = 20 + ((j  * (_hexTile.height + 4))) + (_hexTile.height) ;
                    [_sheet addChild: _hexTile];
                }
                if (j == 3) {
                    _hexTile = [[SPImage alloc]initWithContentsOfFile:@"desert-tile.png"];
                    _hexTile.x = 133 + ((_hexTile.width * 2) - 20);
                    _hexTile.y = 20 + ((j  * (_hexTile.height + 4))) + (_hexTile.height) ;
                    [_sheet addChild: _hexTile];
                }
                if (j == 4) {
                    _hexTile = [[SPImage alloc]initWithContentsOfFile:@"jungle-tile.png"];
                    _hexTile.x = 133 + ((_hexTile.width * 2) - 20);
                    _hexTile.y = 20 + ((j  * (_hexTile.height + 4))) + (_hexTile.height) ;
                    [_sheet addChild: _hexTile];
                }
                
            }
            
            drawNext = false;
        }
        
        //Draw missing tile 3
        if (i == 3){
            drawNext = true;
            _hexTile = [[SPImage alloc]initWithContentsOfFile:@"frozen-tile.png"];
            _hexTile.x = 133;
            _hexTile.y = 20 + ((i  * (_hexTile.height + 4)));
            [_sheet addChild: _hexTile];
        }
            
        
        //Draw fourth row
        if (drawNext) {
            //Drawing hexagon for left side after first hexagon (4)
            for (int j = 0; j < 4; j ++) {
                
                if (j == 0){
                    _hexTile = [[SPImage alloc]initWithContentsOfFile:@"desert-tile.png"];
                    _hexTile.x = 133 - ((_hexTile.width * 3) - 30);
                    _hexTile.y = 45 + ((j  * (_hexTile.height + 4))) + (_hexTile.height) ;
                    [_sheet addChild: _hexTile];
                }
                if (j == 1){
                    _hexTile = [[SPImage alloc]initWithContentsOfFile:@"frozen-tile.png"];
                    _hexTile.x = 133 - ((_hexTile.width * 3) - 30);
                    _hexTile.y = 45 + ((j  * (_hexTile.height + 4))) + (_hexTile.height) ;
                    [_sheet addChild: _hexTile];
                }
                if (j == 2){
                    _hexTile = [[SPImage alloc]initWithContentsOfFile:@"forest-tile.png"];
                    _hexTile.x = 133 - ((_hexTile.width * 3) - 30);
                    _hexTile.y = 45 + ((j  * (_hexTile.height + 4))) + (_hexTile.height) ;
                    [_sheet addChild: _hexTile];
                }
                if (j == 3){
                    _hexTile = [[SPImage alloc]initWithContentsOfFile:@"mountain-tile.png"];
                    _hexTile.x = 133 - ((_hexTile.width * 3) - 30);
                    _hexTile.y = 45 + ((j  * (_hexTile.height + 4))) + (_hexTile.height) ;
                    [_sheet addChild: _hexTile];
                }
                
                
            }
            
            //Drawing hexagon for right side after first hexagon (4)
            for (int j = 0; j < 4; j ++) {
                
                if (j == 0) {
                    _hexTile = [[SPImage alloc]initWithContentsOfFile:@"forest-tile.png"];
                    _hexTile.x = 133 + ((_hexTile.width * 3) - 30);
                    _hexTile.y = 45 + ((j  * (_hexTile.height + 4))) + (_hexTile.height) ;
                    [_sheet addChild: _hexTile];
                }
                if (j == 1) {
                    _hexTile = [[SPImage alloc]initWithContentsOfFile:@"plaines-tile.png"];
                    _hexTile.x = 133 + ((_hexTile.width * 3) - 30);
                    _hexTile.y = 45 + ((j  * (_hexTile.height + 4))) + (_hexTile.height) ;
                    [_sheet addChild: _hexTile];
                }
                if (j == 2) {
                    _hexTile = [[SPImage alloc]initWithContentsOfFile:@"forest-tile.png"];
                    _hexTile.x = 133 + ((_hexTile.width * 3) - 30);
                    _hexTile.y = 45 + ((j  * (_hexTile.height + 4))) + (_hexTile.height) ;
                    [_sheet addChild: _hexTile];
                }
                if (j == 3) {
                    _hexTile = [[SPImage alloc]initWithContentsOfFile:@"frozen-tile.png"];
                    _hexTile.x = 133 + ((_hexTile.width * 3) - 30);
                    _hexTile.y = 45 + ((j  * (_hexTile.height + 4))) + (_hexTile.height) ;
                    [_sheet addChild: _hexTile];
                }
                
                
            }
            
            drawNext = false;
        }
        [_sheet addChild: _hexTile];
    }
}

-(void) showScene:(SPSprite *)scene
{
    [self addChild:scene];
    scene.visible = YES;

}

@end
