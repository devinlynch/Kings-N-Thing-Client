//
//  TwoThreePlayerGame.m
//  3004iPhone
//
//  Created by Richard Ison on 1/13/2014.
//
//

#import "TwoThreePlayerGame.h"
#import "TouchSheet.h"
#import "Scene.h"
#import "TileMenu.h"
#import "Game.h"
#import "ScaledGamePiece.h"


// --- private interface ---------------------------------------------------------------------------

@interface TwoThreePlayerGame ()

- (void)setup;
- (void)onResize:(SPResizeEvent *)event;
- (void)showScene:(SPSprite *)scene;

@end


// --- class implementation ------------------------------------------------------------------------

@implementation TwoThreePlayerGame
{
    NSMutableArray *gamePieces;
    
    SPSprite *_currentScene;
    SPSprite *_contents;
    
    
    int _gameWidth;
    int _gameHeight;
    
    //Tiles
    SPImage *_backTile;
    SPImage *_seaTile;
    SPImage *_desertTile;
    SPImage *_forestTile;
    SPImage *_mountainTile;
    SPImage *_swampTile;
    SPImage *_frozenTile;
    SPImage *_jungleTile;
    SPImage *_plainesTile;
    
    //Other images
    SPImage *_rack;
    SPImage *_bowl;
    SPImage *_dice;
    SPImage *_creatureDice;
    SPTextField *_bankText;
    
    //TouchSheet
    TouchSheet *_sheet;

    
    

}

- (id)init
{
    if ((self = [super init]))
    {
        [self setup];
    }
    return self;
}






- (void)dealloc
{
    // release any resources here
    [Media releaseAtlas];
    [Media releaseSound];
}

- (void)setup
{
    // This is where the code of your game will start.
    // In this sample, we add just a few simple elements to get a feeling about how it's done.
    
    [SPAudioEngine start];  // starts up the sound engine
    
    
    // The Application contains a very handy "Media" class which loads your texture atlas
    // and all available sound files automatically. Extend this class as you need it --
    // that way, you will be able to access your textures and sounds throughout your
    // application, without duplicating any resources.
    
    [Media initAtlas];      // loads your texture atlas -> see Media.h/Media.m
    [Media initSound];      // loads all your sounds    -> see Media.h/Media.m
    
    
    // Create some placeholder content: a background image, the Sparrow logo, and a text field.
    // The positions are updated when the device is rotated. To make that easy, we put all objects
    // in one sprite (_contents): it will simply be rotated to be upright when the device rotates.
    
    _gameWidth  = Sparrow.stage.width;
    _gameHeight = Sparrow.stage.height;
    
    
    gamePieces = [[NSMutableArray alloc] init];
    
    _contents = [SPSprite sprite];
    [self addChild:_contents];
   
    SPImage *background = [[SPImage alloc] initWithContentsOfFile:@"TwoThreeBoard.png"];
    //[_contents addChild:background];
    
    //necessary or else it gets placed off screen
    background.x = 0;
    background.y = 0;
    
    
    // used to handle movement and zooming of board
    TouchSheet *sheet = [[TouchSheet alloc] initWithQuad:background];
    //TouchSheet *sheet = [[TouchSheet alloc] initWithQuad:background];
    _sheet = [[TouchSheet alloc] initWithQuad:background];
    
    //[background addEventListener:@selector(onMoveBoard:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    
    
    
    [self drawStart];
    
    
    //Tiles
    _seaTile = [[SPImage alloc] initWithContentsOfFile:@"sea-tile.png"];
    _seaTile.x = 10;
    _seaTile.y = 250;
    //[sheet addChild:_seaTile];
    [gamePieces addObject:_seaTile ];
    
    _jungleTile = [[SPImage alloc] initWithContentsOfFile:@"jungle-tile.png"];
    _jungleTile.x = 60;
    _jungleTile.y = 250;
    //[sheet addChild:_jungleTile];
    [gamePieces addObject:_jungleTile];
    
    
    _desertTile = [[SPImage alloc] initWithContentsOfFile:@"desert-tile.png"];
    _desertTile.x = 110;
    _desertTile.y = 250;
   // [sheet addChild:_desertTile];
    [gamePieces addObject:_desertTile];
    
    
    _forestTile = [[SPImage alloc] initWithContentsOfFile:@"forest-tile.png"];
    _forestTile.x = 160;
    _forestTile.y = 250;
   // [sheet addChild:_forestTile];
    [gamePieces addObject:_forestTile];
    
    //Adding the sheet to contents so that it appears
    [_contents addChild: sheet];

    
    //Adding the sheet to contents so that it appears
    [_contents addChild: _sheet];
    
    
    //Other images
    _rack = [[SPImage alloc] initWithContentsOfFile:@"Rack.png"];
    _rack.x = 5;
    _rack.y = 350;
    [_contents addChild:_rack];
    [gamePieces addObject:_rack];
    
    
    _bowl = [[SPImage alloc] initWithContentsOfFile:@"Bowl.png"];
    _bowl.x = 235;
    _bowl.y = 325;
    [_contents addChild:_bowl];
    [gamePieces addObject:_bowl];
    
    
    /* Adding to _contents will ensure that these pieces do not move with the board*/
    
    _bankText = [SPTextField textFieldWithWidth:75 height:30 text:@"Bank: 0"];
    _bankText.x = 225;
    _bankText.y = 445;
    _bankText.color = SP_YELLOW;
    [_contents addChild:_bankText];

    
    
    _dice = [[SPImage alloc] initWithContentsOfFile:@"dice6.png"];
    _dice.x = 5;
    _dice.y = 10;
    [_contents addChild:_dice];

    
    
    _creatureDice = [[SPImage alloc] initWithContentsOfFile:@"creature5.png"];
    _creatureDice.x = 5;
    _creatureDice.y = 45;
    [_contents addChild:_creatureDice];

    
    //Event listeners for each image (to do: make a loop)
   
    [_seaTile addEventListener:@selector(onMoveTile:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    [_jungleTile addEventListener:@selector(onMoveTile:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    [_desertTile addEventListener:@selector(onMoveTile:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    [_forestTile addEventListener:@selector(onMoveTile:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    
    // The controller autorotates the game to all supported device orientations.
    // Choose the orienations you want to support in the Xcode Target Settings ("Summary"-tab).
    // To update the game content accordingly, listen to the "RESIZE" event; it is dispatched
    // to all game elements (just like an ENTER_FRAME event).
    //
    // To force the game to start up in landscape, add the key "Initial Interface Orientation"
    // to the "App-Info.plist" file and choose any landscape orientation.
    
    [self addEventListener:@selector(onResize:) atObject:self forType:SP_EVENT_TYPE_RESIZE];
    
    // Per default, this project compiles as a universal application. To change that, enter the
    // project info screen, and in the "Build"-tab, find the setting "Targeted device family".
    //
    // Now choose:
    //   * iPhone      -> iPhone only App
    //   * iPad        -> iPad only App
    //   * iPhone/iPad -> Universal App
    //
    // Sparrow's minimum deployment target is iOS 5.
}

- (void)onMoveTile:(SPTouchEvent*)event {
    
    SPImage *img = (SPImage*)event.target;
    
    NSArray *touches = [[event touchesWithTarget:self andPhase:SPTouchPhaseMoved] allObjects];
    
    if (touches.count == 1)
    {
        // one finger touching -> move
        SPTouch *touch = touches[0];
        SPPoint *movement = [touch movementInSpace:self.parent];
        
        img.x += movement.x;
        img.y += movement.y;
        
        
        
    }
    
}


-(void)onClickTile:(SPTouchEvent*) event
{
    SPImage * img = (SPImage*) event.target;
    SPImage *newimg;
    
    NSArray *touches = [[event touchesWithTarget:self andPhase:SPTouchPhaseBegan] allObjects];
    
     if (touches.count == 1)
    {
        NSLog(@"le tile click");
       
        //Randomize based on game logic
        [img removeFromParent];
        newimg = [[SPImage alloc] initWithContentsOfFile:@"swamp-tile.png"];
        newimg.x = img.x;
        newimg.y = img.y;
        
        [_sheet addChild:newimg];
        [newimg addEventListener:@selector(tileDoubleClick:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
        
    }
}


-(void) tileDoubleClick: (SPTouchEvent*) event
{
    NSArray *touches = [[event touchesWithTarget:self andPhase:SPTouchPhaseBegan] allObjects];
    if (touches.count == 1)
    {
        
    //Double Click
    SPTouch * clickTileMenu = [touches objectAtIndex:0];
        if (clickTileMenu.tapCount == 2){
            NSLog(@"le double click");
            
            [NSObject cancelPreviousPerformRequestsWithTarget:self];

            [self showTileMenu];
            
           
        }

    }

}

- (void)showScene:(SPSprite *)scene {
  
    [self addChild:scene];
    scene.visible = YES;
}

- (void)showTileMenu {
    TileMenu *tileScene = [[TileMenu alloc] init];
    [self showScene:tileScene];
}

-(void) drawStart
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

- (void)updateLocations
{
    _gameWidth  = Sparrow.stage.width;
    _gameHeight = Sparrow.stage.height;
    
    _contents.x = (int) (_gameWidth  - _contents.width)  / 2;
    _contents.y = (int) (_gameHeight - _contents.height) / 2;
}


- (void)onResize:(SPResizeEvent *)event
{
    NSLog(@"new size: %.0fx%.0f (%@)", event.width, event.height,
          event.isPortrait ? @"portrait" : @"landscape");
    
    [self updateLocations];
}

@end
