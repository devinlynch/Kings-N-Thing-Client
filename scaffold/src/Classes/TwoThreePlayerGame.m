//
//  TwoThreePlayerGame.m
//  3004iPhone
//
//  Created by Richard Ison on 1/13/2014.
//
//

#import "TwoThreePlayerGame.h"


// --- private interface ---------------------------------------------------------------------------

@interface TwoThreePlayerGame ()

- (void)setup;
- (void)onResize:(SPResizeEvent *)event;

@end


// --- class implementation ------------------------------------------------------------------------

@implementation TwoThreePlayerGame
{
    NSMutableArray *gamePieces;
    
    SPSprite *_contents;
    
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
    
    
    gamePieces = [[NSMutableArray alloc] init];
    
    _contents = [SPSprite sprite];
    [self addChild:_contents];
    
    SPImage *background = [[SPImage alloc] initWithContentsOfFile:@"TwoThreeBoard.png"];
    [_contents addChild:background];
    [background addEventListener:@selector(onMoveBoard:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    
    
    
    //Tiles
    _seaTile = [[SPImage alloc] initWithContentsOfFile:@"sea-tile.png"];
    _seaTile.x = 10;
    _seaTile.y = 250;
    [_contents addChild:_seaTile];
    [gamePieces addObject:_seaTile];
    
    _jungleTile = [[SPImage alloc] initWithContentsOfFile:@"jungle-tile.png"];
    _jungleTile.x = 60;
    _jungleTile.y = 250;
    [_contents addChild:_jungleTile];
    [gamePieces addObject:_jungleTile];
    
    
//    _desertTile = [[SPImage alloc] initWithContentsOfFile:@"desert-tile.png"];
//    _desertTile.x = 110;
//    _desertTile.y = 250;
//    [_contents addChild:_desertTile];
//    [gamePieces addObject:_desertTile];
    
    
    _forestTile = [[SPImage alloc] initWithContentsOfFile:@"forest-tile.png"];
    _forestTile.x = 160;
    _forestTile.y = 250;
    [_contents addChild:_forestTile];
    [gamePieces addObject:_forestTile];
    
    
    
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
    
    
    _bankText = [SPTextField textFieldWithWidth:75 height:30 text:@"Bank: 0"];
    _bankText.x = 225;
    _bankText.y = 445;
    _bankText.color = SP_YELLOW;
    [_contents addChild:_bankText];
    [gamePieces addObject:_bankText];
    
    
    _dice = [[SPImage alloc] initWithContentsOfFile:@"dice6.png"];
    _dice.x = 5;
    _dice.y = 10;
    [_contents addChild:_dice];
    [gamePieces addObject:_dice];
    
    
    _creatureDice = [[SPImage alloc] initWithContentsOfFile:@"creature5.png"];
    _creatureDice.x = 5;
    _creatureDice.y = 45;
    [_contents addChild:_creatureDice];
    [gamePieces addObject:_creatureDice];
    
    
    
    
    
    //Event listeners for each image (to do: make a loop)
    
    [_seaTile addEventListener:@selector(onMoveTile:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    [_jungleTile addEventListener:@selector(onMoveTile:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
//    [_desertTile addEventListener:@selector(onMoveTile:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
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

- (void) onTouch: (SPTouchEvent*) event
{
    // NSLog(@"IM TOUCHED!");
    NSArray *touches = [[event touchesWithTarget:self andPhase:SPTouchPhaseMoved] allObjects];
    
    if (touches.count == 1)
    {
        // one finger touching -> move
        //        SPTouch *touch = touches[0];
        //        SPPoint *movement = [touch movementInSpace:self.parent];
        //
        //
        //
        //            self.x += movement.x;
        //            self.y += movement.y;
        //
        //        NSLog(@"x: %f y: %f", movement.x, movement.y);
        
        
        //   NSLog(@"One finga");
    }
    else if (touches.count >= 2)
    {
        //NSLog(@"Two finga");
        
        SPTouch *touch1 = [touches objectAtIndex:0];
        SPTouch *touch2 = [touches objectAtIndex:1];
        
        SPPoint *touch1PrevPos = [touch1 previousLocationInSpace:self.parent];
        SPPoint *touch1Pos = [touch1 locationInSpace:self.parent];
        
        SPPoint *touch2PrevPos = [touch2 previousLocationInSpace:self.parent];
        SPPoint *touch2Pos = [touch2 locationInSpace:self.parent];
        
        SPPoint *prevVector = [touch1PrevPos subtractPoint:touch2PrevPos];
        SPPoint *currentVector = [touch1Pos subtractPoint:touch2Pos];
        
        float sizeDiff = currentVector.length / prevVector.length;
        float xavg = (touch1Pos.x + touch2Pos.x ) / 2;
        float yavg = (touch2Pos.y + touch1Pos.y) / 2;
        
        SPMatrix *mat = [self transformationMatrix];
        [mat translateXBy:-xavg yBy:-yavg];
        if (self.scaleX * sizeDiff > 0.5f) [mat scaleBy:sizeDiff];
        [mat translateXBy:xavg yBy:yavg];
        [self setTransformationMatrix:mat];
    }
}

- (void)setTransformationMatrix:(SPMatrix *)matrix {
    self.scaleX = matrix.a;
	self.scaleY = matrix.d;
	self.x = matrix.tx;
	self.y = matrix.ty;
}

- (void)onMoveBoard:(SPTouchEvent*)event {
    
    SPImage *img = (SPImage*)event.target;
    
	
    NSArray *touchesMoved = [[event touchesWithTarget:self andPhase:SPTouchPhaseMoved] allObjects];
    
    // Movement of self (x,y)
    if (touchesMoved.count == 1) {
//        SPPoint *currentPos = [[touchesMoved objectAtIndex:0] locationInSpace:[self parent]];
//        SPPoint *previousPos = [[touchesMoved objectAtIndex:0] previousLocationInSpace:[self parent]];
//        
//        float diffX = [self x] + (currentPos.x - previousPos.x);
//        float diffY = [self y] + (currentPos.y - previousPos.y);
//        
//        img.x += diffX;
//        img.y += diffY;
//        
//        for(SPDisplayObjectContainer *piece in gamePieces){
//            piece.x += diffX;
//            piece.y += diffY;
//        }
        
        // Pinch zoom in /out
    } else if (touchesMoved.count == 2) {
        
        
        SPPoint *previousPos1 = [[touchesMoved objectAtIndex:0] previousLocationInSpace:[self parent]];
        SPPoint *previousPos2 = [[touchesMoved objectAtIndex:1] previousLocationInSpace:[self parent]];
        
        SPPoint *currentPos1 = [[touchesMoved objectAtIndex:0] locationInSpace:[self parent]];
        SPPoint *currentPos2 = [[touchesMoved objectAtIndex:1] locationInSpace:[self parent]];
        
        float distance1 = [SPPoint distanceFromPoint:currentPos1 toPoint:currentPos2];
        float distance2 = [SPPoint distanceFromPoint:previousPos1 toPoint:previousPos2];
        
        float scaleX = (([self scaleX] / distance2) * distance1);
        float scaleY = (([self scaleY] / distance2) * distance1);
        
        if (scaleX > 0.50 && scaleX <= 1.00) {
            img.scaleX = scaleX;
            img.scaleY = scaleY;
        }
        
        for(SPDisplayObjectContainer *piece in gamePieces){
            piece.scaleX = scaleX;
            piece.scaleY = scaleY;
        }
        
    }
    
    if ([self x] < 0 && [self width] + [self x] < 480) {
        [self setX:[self x] + (480 - ([self width] + [self x]))];
    }
    
    if ([self y] < 0 && [self height] + [self y] < 320) {
        [self setY:[self y] + (320 - ([self height] + [self y]))];
    }
	
}

- (void)onMoveTile:(SPTouchEvent*)event {
    
    SPImage *img = (SPImage*)event.target;
	
    NSArray *touchesMoved = [[event touchesWithTarget:self andPhase:SPTouchPhaseMoved] allObjects];
    
    // Movement of self (x,y)
    if (touchesMoved.count == 1) {
        SPPoint *currentPos = [[touchesMoved objectAtIndex:0] locationInSpace:[self parent]];
        SPPoint *previousPos = [[touchesMoved objectAtIndex:0] previousLocationInSpace:[self parent]];
        
        float diffX = [self x] + (currentPos.x - previousPos.x);
        float diffY = [self y] + (currentPos.y - previousPos.y);
        
        img.x += diffX;
        img.y += diffY;
    }
    
    if ([self x] < 0 && [self width] + [self x] < 480) {
        [self setX:[self x] + (480 - ([self width] + [self x]))];
    }
    
    if ([self y] < 0 && [self height] + [self y] < 320) {
        [self setY:[self y] + (320 - ([self height] + [self y]))];
    }
	
}

- (void)updateLocations
{
    int gameWidth  = Sparrow.stage.width;
    int gameHeight = Sparrow.stage.height;
    
    _contents.x = (int) (gameWidth  - _contents.width)  / 2;
    _contents.y = (int) (gameHeight - _contents.height) / 2;
}


- (void)onResize:(SPResizeEvent *)event
{
    NSLog(@"new size: %.0fx%.0f (%@)", event.width, event.height,
          event.isPortrait ? @"portrait" : @"landscape");
    
    [self updateLocations];
}

@end
