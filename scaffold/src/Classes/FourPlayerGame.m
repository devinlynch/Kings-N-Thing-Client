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
#import "GameState.h"
#import "Creature.h"

@interface FourPlayerGame ()
- (void) setup;
- (void) showScene:(SPSprite*)scene;
@end

@implementation FourPlayerGame{
    NSMutableArray *gamePieces;
    
    SPSprite *_currentScene;
    SPSprite *_contents;
    
    TouchSheet *_sheet;
    SPTextField *_bankText;
    
    
    int _gameWidth;
    int _gameHeight;
    
    SPImage *_hexTile;
    
    SPImage *_selectedPiece;
    
    GameState *_state;
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
    
   // _state = [[GameState alloc] initGame];

    _gameWidth = Sparrow.stage.width;
    _gameHeight = Sparrow.stage.height;
    
    gamePieces = [[NSMutableArray alloc]init];
    
    _contents = [SPSprite sprite];
    [self addChild:_contents];
    
    SPImage *background = [[SPImage alloc] initWithContentsOfFile:@"FourPlayerBackground@2x.png"];
    
    //necessary or else it gets placed off screen
    background.x = 0;
    background.y = -45;
    
    // used to handle movement and zooming of board
   // TouchSheet *sheet = [[TouchSheet alloc] initWithQuad:background];
    //TouchSheet *sheet = [[TouchSheet alloc] initWithQuad:background];
    _sheet = [[TouchSheet alloc] initWithQuad:background];
    
    //Add the sheet to the contents so that it appears
  //  [_contents addChild:sheet];
    //Add the sheet to the contents so that it appears
    [_contents addChild:_sheet];
    
    _bankText = [SPTextField textFieldWithWidth:75 height:30 text:@"Selected:"];
    _bankText.x = 150;
    _bankText.y = 445;
    _bankText.color = SP_YELLOW;
    [_contents addChild:_bankText];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(pieceSelected:)
                                                 name:@"pieceSelected"
                                               object:nil];
    
    //Draw tiles
    [self drawTiles];
    [self drawCreatures];
    
    
    
//    _rack = [[SPImage alloc] initWithContentsOfFile:@"Rack.png"];
//    _rack.x = _gameWidth /2 - _rack.width/2;
//    _rack.y = _gameHeight - _rack.height * 1.4;
//    [_contents addChild:_rack];
//    [gamePieces addObject:_rack];
//    
//    
//    _bowl = [[SPImage alloc] initWithContentsOfFile:@"Bowl.png"];
//    _bowl.x = 10;
//    _bowl.y = 310;
//    [_contents addChild:_bowl];
//    [gamePieces addObject:_bowl];

}


-(void) pieceSelected: (NSNotification*) notif{
    Creature *selected = notif.object;
    
    _selectedPiece = [[SPImage alloc] initWithContentsOfFile:[selected fileName]];
    _selectedPiece.x = 250;
    _selectedPiece.y = 400;
    [_contents addChild:_selectedPiece];
}


-(void) drawCreatures{
    for (NSString *creature in [_state gamePieceResource]) {
        [_sheet addChild:[[[_state gamePieceResource] objectForKey:creature] pieceImage]];
    }
}

-(void) drawTiles
{
    int yOffset = 30;
    //Drawing hexagons for middle (7)
    for (int i = 0; i < 7; i++){
        
        bool drawNext = false;
        
        if (i == 0) {
            drawNext = true;
            _hexTile = [[SPImage alloc]initWithContentsOfFile:@"jungle-tile.png"];
            _hexTile.x = 133;
            _hexTile.y = 10 + ((i  * (_hexTile.height + 4))) - yOffset;
            [_sheet addChild: _hexTile];;
        }
        
        if (i == 4) {
            drawNext = true;
            _hexTile = [[SPImage alloc]initWithContentsOfFile:@"sea-tile.png"];
            _hexTile.x = 133;
            _hexTile.y = 10 + ((i  * (_hexTile.height + 4)))- yOffset;
            [_sheet addChild: _hexTile];;
        }
        if (i == 5) {
            drawNext = true;
            _hexTile = [[SPImage alloc]initWithContentsOfFile:@"forest-tile.png"];
            _hexTile.x = 133;
            _hexTile.y = 10 + ((i  * (_hexTile.height + 4)))- yOffset;
            [_sheet addChild: _hexTile];;
        }
        if (i == 6) {
            drawNext = true;
            _hexTile = [[SPImage alloc]initWithContentsOfFile:@"desert-tile.png"];
            _hexTile.x = 133;
            _hexTile.y = 10 + ((i  * (_hexTile.height + 4)))- yOffset;
            [_sheet addChild: _hexTile];;
        }
        
        //Draw missing tile
        if (i == 1){
            drawNext = true;
            _hexTile = [[SPImage alloc]initWithContentsOfFile:@"frozen-tile.png"];
            _hexTile.x = 133;
            _hexTile.y = 10 + ((i  * (_hexTile.height + 4)))- yOffset;
            [_sheet addChild: _hexTile];
        }
        
        
        if (drawNext) {
            //Drawing hexagon for left side after first hexagon (6)
            for (int j = 0; j < 6; j ++) {
                
                
                if (j == 0){
                    _hexTile = [[SPImage alloc]initWithContentsOfFile:@"mountain-tile.png"];
                    SPImage *_hilight = [[SPImage alloc]initWithContentsOfFile:@"red-hilight.png"];
                    _hilight.x = _hexTile.x = 133 - (_hexTile.width - 10);
                    _hilight.y = _hexTile.y = 10 + ((j  * (_hexTile.height + 4))) + _hexTile.height /2 - yOffset ;
                    [_sheet addChild: _hexTile];
                    [_sheet addChild: _hilight];
                }
                
                if (j == 1){
                    _hexTile = [[SPImage alloc]initWithContentsOfFile:@"plaines-tile.png"];
                    _hexTile.x = 133 - (_hexTile.width - 10);
                    _hexTile.y = 10 + ((j  * (_hexTile.height + 4))) + _hexTile.height /2 - yOffset;
                    [_sheet addChild: _hexTile];
                }
                if (j == 2){
                    _hexTile = [[SPImage alloc]initWithContentsOfFile:@"swamp-tile.png"];
                    _hexTile.x = 133 - (_hexTile.width - 10);
                    _hexTile.y = 10 + ((j  * (_hexTile.height + 4))) + _hexTile.height /2 - yOffset;
                    [_sheet addChild: _hexTile];
                }
                if (j == 3){
                    _hexTile = [[SPImage alloc]initWithContentsOfFile:@"forest-tile.png"];
                    _hexTile.x = 133 - (_hexTile.width - 10);
                    _hexTile.y = 10 + ((j  * (_hexTile.height + 4))) + _hexTile.height /2 - yOffset;
                    [_sheet addChild: _hexTile];
                }
                if (j == 4){
                    _hexTile = [[SPImage alloc]initWithContentsOfFile:@"desert-tile.png"];
                    _hexTile.x = 133 - (_hexTile.width - 10);
                    _hexTile.y = 10 + ((j  * (_hexTile.height + 4))) + _hexTile.height /2 - yOffset;
                    [_sheet addChild: _hexTile];
                }
                if (j == 5){
                    _hexTile = [[SPImage alloc]initWithContentsOfFile:@"plaines-tile.png"];
                    _hexTile.x = 133 - (_hexTile.width - 10);
                    _hexTile.y = 10 + ((j  * (_hexTile.height + 4))) + _hexTile.height /2 - yOffset;
                    [_sheet addChild: _hexTile];
                }
                
        }
            
            //Drawing hexagon for right side after first hexagon (6)
            for (int j = 0; j < 6; j ++) {
                
                if (j == 0){
                    _hexTile = [[SPImage alloc]initWithContentsOfFile:@"swamp-tile.png"];
                    _hexTile.x = 133 + (_hexTile.width - 10);
                    _hexTile.y = 10 + ((j  * (_hexTile.height + 4))) + _hexTile.height /2 - yOffset;
                    [_sheet addChild: _hexTile];
                }
                
                if (j == 1){
                    _hexTile = [[SPImage alloc]initWithContentsOfFile:@"mountain-tile.png"];
                    _hexTile.x = 133 + (_hexTile.width - 10);
                    _hexTile.y = 10 + ((j  * (_hexTile.height + 4))) + _hexTile.height /2 - yOffset;
                    [_sheet addChild: _hexTile];
                }
                if (j == 2){
                    _hexTile = [[SPImage alloc]initWithContentsOfFile:@"jungle-tile.png"];
                    _hexTile.x = 133 + (_hexTile.width - 10);
                    _hexTile.y = 10 + ((j  * (_hexTile.height + 4))) + _hexTile.height /2 - yOffset;
                    [_sheet addChild: _hexTile];
                }
                if (j == 3){
                    _hexTile = [[SPImage alloc]initWithContentsOfFile:@"plaines-tile.png"];
                    _hexTile.x = 133 + (_hexTile.width - 10);
                    _hexTile.y = 10 + ((j  * (_hexTile.height + 4))) + _hexTile.height /2 - yOffset;
                    [_sheet addChild: _hexTile];
                }
                if (j == 4){
                    _hexTile = [[SPImage alloc]initWithContentsOfFile:@"swamp-tile.png"];
                    _hexTile.x = 133 + (_hexTile.width - 10);
                    _hexTile.y = 10 + ((j  * (_hexTile.height + 4))) + _hexTile.height /2 - yOffset;
                    [_sheet addChild: _hexTile];
                }
                if (j == 5){
                    _hexTile = [[SPImage alloc]initWithContentsOfFile:@"mountain-tile.png"];
                    _hexTile.x = 133 + (_hexTile.width - 10);
                    _hexTile.y = 10 + ((j  * (_hexTile.height + 4))) + _hexTile.height /2 - yOffset;
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
            _hexTile.y = 10 + ((i  * (_hexTile.height + 4)))- yOffset;
            [_sheet addChild: _hexTile];
            
            
            
        }
        
      //Draw thrid row
        
        if (drawNext) {
            //Drawing hexagon for left side after first hexagon (5)
            for (int j = 0; j < 5; j ++) {
   
                if (j == 0 ){
                    _hexTile = [[SPImage alloc]initWithContentsOfFile:@"swamp-tile.png"];
                    _hexTile.x = 133 - ((_hexTile.width * 2) - 20);
                    _hexTile.y = 10 + ((j  * (_hexTile.height + 4))) + (_hexTile.height) - yOffset;
                    [_sheet addChild: _hexTile];
                }
                if (j == 1 ){
                    _hexTile = [[SPImage alloc]initWithContentsOfFile:@"jungle-tile.png"];
                    _hexTile.x = 133 - ((_hexTile.width * 2) - 20);
                    _hexTile.y = 10 + ((j  * (_hexTile.height + 4))) + (_hexTile.height) - yOffset;
                    [_sheet addChild: _hexTile];
                }
                if (j == 2 ){
                    _hexTile = [[SPImage alloc]initWithContentsOfFile:@"mountain-tile.png"];
                    _hexTile.x = 133 - ((_hexTile.width * 2) - 20);
                    _hexTile.y = 10 + ((j  * (_hexTile.height + 4))) + (_hexTile.height) - yOffset;
                    [_sheet addChild: _hexTile];
                }
                if (j == 3 ){
                    _hexTile = [[SPImage alloc]initWithContentsOfFile:@"plaines-tile.png"];
                    _hexTile.x = 133 - ((_hexTile.width * 2) - 20);
                    _hexTile.y = 10 + ((j  * (_hexTile.height + 4))) + (_hexTile.height) - yOffset;
                    [_sheet addChild: _hexTile];
                }
                if (j == 4 ){
                    _hexTile = [[SPImage alloc]initWithContentsOfFile:@"jungle-tile.png"];
                    _hexTile.x = 133 - ((_hexTile.width * 2) - 20);
                    _hexTile.y = 10 + ((j  * (_hexTile.height + 4))) + (_hexTile.height) - yOffset;
                    [_sheet addChild: _hexTile];
                }
                
                
            }
            
            //Drawing hexagon for right side after first hexagon (5)
            for (int j = 0; j < 5; j ++) {
                
                if (j == 0) {
                    _hexTile = [[SPImage alloc]initWithContentsOfFile:@"desert-tile.png"];
                    _hexTile.x = 133 + ((_hexTile.width * 2) - 20);
                    _hexTile.y = 10 + ((j  * (_hexTile.height + 4))) + (_hexTile.height) - yOffset;
                    [_sheet addChild: _hexTile];
                }
                if (j == 1) {
                    _hexTile = [[SPImage alloc]initWithContentsOfFile:@"frozen-tile.png"];
                    _hexTile.x = 133 + ((_hexTile.width * 2) - 20);
                    _hexTile.y = 10 + ((j  * (_hexTile.height + 4))) + (_hexTile.height) - yOffset;
                    [_sheet addChild: _hexTile];
                }
                if (j == 2) {
                    _hexTile = [[SPImage alloc]initWithContentsOfFile:@"swamp-tile.png"];
                    _hexTile.x = 133 + ((_hexTile.width * 2) - 20);
                    _hexTile.y = 10 + ((j  * (_hexTile.height + 4))) + (_hexTile.height) - yOffset;
                    [_sheet addChild: _hexTile];
                }
                if (j == 3) {
                    _hexTile = [[SPImage alloc]initWithContentsOfFile:@"desert-tile.png"];
                    _hexTile.x = 133 + ((_hexTile.width * 2) - 20);
                    _hexTile.y = 10 + ((j  * (_hexTile.height + 4))) + (_hexTile.height) - yOffset;
                    [_sheet addChild: _hexTile];
                }
                if (j == 4) {
                    _hexTile = [[SPImage alloc]initWithContentsOfFile:@"jungle-tile.png"];
                    _hexTile.x = 133 + ((_hexTile.width * 2) - 20);
                    _hexTile.y = 10 + ((j  * (_hexTile.height + 4))) + (_hexTile.height) - yOffset;
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
            _hexTile.y = 10 + ((i  * (_hexTile.height + 4)))- yOffset;
            [_sheet addChild: _hexTile];
        }
            
        
        //Draw fourth row
        if (drawNext) {
            //Drawing hexagon for left side after first hexagon (4)
            for (int j = 0; j < 4; j ++) {
                
                if (j == 0){
                    _hexTile = [[SPImage alloc]initWithContentsOfFile:@"desert-tile.png"];
                    _hexTile.x = 133 - ((_hexTile.width * 3) - 30);
                    _hexTile.y = 45 + ((j  * (_hexTile.height + 4))) + (_hexTile.height) - yOffset * 1.3;
                    [_sheet addChild: _hexTile];
                }
                if (j == 1){
                    _hexTile = [[SPImage alloc]initWithContentsOfFile:@"frozen-tile.png"];
                    _hexTile.x = 133 - ((_hexTile.width * 3) - 30);
                    _hexTile.y = 45 + ((j  * (_hexTile.height + 4))) + (_hexTile.height) - yOffset* 1.3;
                    [_sheet addChild: _hexTile];
                }
                if (j == 2){
                    _hexTile = [[SPImage alloc]initWithContentsOfFile:@"forest-tile.png"];
                    _hexTile.x = 133 - ((_hexTile.width * 3) - 30);
                    _hexTile.y = 45 + ((j  * (_hexTile.height + 4))) + (_hexTile.height) - yOffset* 1.3;
                    [_sheet addChild: _hexTile];
                }
                if (j == 3){
                    _hexTile = [[SPImage alloc]initWithContentsOfFile:@"mountain-tile.png"];
                    _hexTile.x = 133 - ((_hexTile.width * 3) - 30);
                    _hexTile.y = 45 + ((j  * (_hexTile.height + 4))) + (_hexTile.height) - yOffset* 1.3;
                    [_sheet addChild: _hexTile];
                }
                
                
            }
            
            //Drawing hexagon for right side after first hexagon (4)
            for (int j = 0; j < 4; j ++) {
                
                if (j == 0) {
                    _hexTile = [[SPImage alloc]initWithContentsOfFile:@"forest-tile.png"];
                    _hexTile.x = 133 + ((_hexTile.width * 3) - 30);
                    _hexTile.y = 45 + ((j  * (_hexTile.height + 4))) + (_hexTile.height) - yOffset* 1.3;
                    [_sheet addChild: _hexTile];
                }
                if (j == 1) {
                    _hexTile = [[SPImage alloc]initWithContentsOfFile:@"plaines-tile.png"];
                    _hexTile.x = 133 + ((_hexTile.width * 3) - 30);
                    _hexTile.y = 45 + ((j  * (_hexTile.height + 4))) + (_hexTile.height) - yOffset* 1.3;
                    [_sheet addChild: _hexTile];
                }
                if (j == 2) {
                    _hexTile = [[SPImage alloc]initWithContentsOfFile:@"forest-tile.png"];
                    _hexTile.x = 133 + ((_hexTile.width * 3) - 30);
                    _hexTile.y = 45 + ((j  * (_hexTile.height + 4))) + (_hexTile.height) - yOffset* 1.3;
                    [_sheet addChild: _hexTile];
                }
                if (j == 3) {
                    _hexTile = [[SPImage alloc]initWithContentsOfFile:@"frozen-tile.png"];
                    _hexTile.x = 133 + ((_hexTile.width * 3) - 30);
                    _hexTile.y = 45 + ((j  * (_hexTile.height + 4))) + (_hexTile.height) - yOffset* 1.3;
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
