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
#import "GameResource.h"
#import "GoldCollection.h"
#import "Player.h"
#import "HexLocation.h"
#import "HexTile.h"
#import "Terrain.h"
#import "Fort.h"
#import "HexTile.h"
#import "TileImage.h"
#import "Terrain.h"
#import "InGameServerAccess.h"



@interface FourPlayerGame ()
- (void) setup;
- (void) showScene:(SPSprite*)scene;
@end

@implementation FourPlayerGame{
    NSMutableArray *gamePieces;
    
    
    int markerCount;
    NSString *placeHex1, *placeHex2, *placeHex3;
    
    NSInteger _phase;
    NSInteger _placementStep;
    
    Player *_player1;
    Player *_player2;
    Player *_player3;
    Player *_player4;


    
    SPSprite *_currentScene;
    SPSprite *_contents;
    
    TouchSheet *_sheet;
    SPTextField *_bankText;
    SPTextField *_stateText;
    SPTextField *_Player2LabelText;
    SPTextField *_Player3LabelText;
    SPTextField *_Player4LabelText;
    SPTextField *_Player1LabelText;
    
    
    SPTextField *_Player2IncomeText;
    SPTextField *_Player3IncomeText;
    SPTextField *_Player4IncomeText;
    SPTextField *_Player1IncomeText;
    
    
    
    
    int _gameWidth;
    int _gameHeight;
    
    SPTextField *_selectedText;
    SPImage *_selectedPieceImage;
    
    GamePiece *_selectedPiece;
    
    SPImage *_bowl;
    GameState *_state;
    SPImage *_rackZone;
    
    
    ScaledGamePiece *_test1;
    ScaledGamePiece *_test2;
    ScaledGamePiece *_test3;
    
    //bool didPutTower;
    
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
    
    [GameResource getInstance];
    
   // _state = [[GameState alloc] initGame];

    _gameWidth = Sparrow.stage.width;
    _gameHeight = Sparrow.stage.height;
    
    markerCount = 2;
    
     placeHex1 = [[NSString alloc] init];
     placeHex2 = [[NSString alloc] init];
     placeHex3 = [[NSString alloc] init];



    
   // didPutTower = false;
    
    gamePieces = [[NSMutableArray alloc]init];
    
    _contents = [SPSprite sprite];
    [self addChild:_contents];
    
    SPImage *background = [[SPImage alloc] initWithContentsOfFile:@"FourPlayerBackground@2x.png"];
    
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
    
    
    _stateText = [SPTextField textFieldWithWidth:200 height:30 text:@"State:"];
    _stateText.x = 0;
    _stateText.y = 2;
    _stateText.color = SP_YELLOW;
    [_contents addChild:_stateText];
    

    
    //Income labels
    _Player1LabelText = [SPTextField textFieldWithWidth:90 height:30 text:@"Your Income:"];
    _Player1LabelText.x = _gameWidth - _Player1LabelText.width - (_Player1LabelText.width/2 - 15);
    _Player1LabelText.y = 335;
    _Player1LabelText.color = SP_YELLOW;
    [_contents addChild:_Player1LabelText];
    
    _Player2LabelText = [SPTextField textFieldWithWidth:110 height:30 text:@"Player2 Income:"];
    _Player2LabelText.x = _gameWidth - _Player2LabelText.width - (_Player2LabelText.width/2) + 25;
    _Player2LabelText.y = 335 + _Player1LabelText.height / 2;
    _Player2LabelText.color = SP_YELLOW;
    [_contents addChild:_Player2LabelText];
    
    _Player3LabelText = [SPTextField textFieldWithWidth:110 height:30 text:@"Player3 Income:"];
    _Player3LabelText.x = _gameWidth - _Player3LabelText.width - (_Player3LabelText.width/2)+ 25;
    _Player3LabelText.y = 335 + _Player3LabelText.height;
    _Player3LabelText.color = SP_YELLOW;
    [_contents addChild:_Player3LabelText];
    
    _Player4LabelText = [SPTextField textFieldWithWidth:110 height:30 text:@"Player4 Income:"];
    _Player4LabelText.x = _gameWidth - _Player4LabelText.width - (_Player4LabelText.width/2)+ 25;
    _Player4LabelText.y = 335 + _Player4LabelText.height*1.5;
    _Player4LabelText.color = SP_YELLOW;
    [_contents addChild:_Player4LabelText];
    
    
    //Income Text
    _Player1IncomeText = [SPTextField textFieldWithWidth:90 height:30 text:@"999"];
    _Player1IncomeText.x = _gameWidth - _Player1IncomeText.width + 25 ;
    _Player1IncomeText.y = 335;
    _Player1IncomeText.color = SP_YELLOW;
    [_contents addChild:_Player1IncomeText];
    
    _Player2IncomeText = [SPTextField textFieldWithWidth:90 height:30 text:@"999"];
    _Player2IncomeText.x = _gameWidth - _Player2IncomeText.width + 25 ;
    _Player2IncomeText.y = 335+ _Player1LabelText.height / 2;
    _Player2IncomeText.color = SP_YELLOW;
    [_contents addChild:_Player2IncomeText];
    
    _Player3IncomeText = [SPTextField textFieldWithWidth:90 height:30 text:@"999"];
    _Player3IncomeText.x = _gameWidth - _Player3IncomeText.width + 25 ;
    _Player3IncomeText.y = 335 + _Player3LabelText.height;
    _Player3IncomeText.color = SP_YELLOW;
    [_contents addChild:_Player3IncomeText];
    
    _Player4IncomeText = [SPTextField textFieldWithWidth:90 height:30 text:@"999"];
    _Player4IncomeText.x = _gameWidth - _Player4IncomeText.width + 25 ;
    _Player4IncomeText.y = 335+ _Player4LabelText.height*1.5;
    _Player4IncomeText.color = SP_YELLOW;
    [_contents addChild:_Player4IncomeText];
    
    
    _rackZone = [[SPImage alloc] initWithContentsOfFile:@"DarkZone2.png"];
    _rackZone.x = 15;
    _rackZone.y = _gameHeight - _rackZone.height - _rackZone.height/4 + 15;
    
    
    _selectedText = [SPTextField textFieldWithWidth:200 height:30 text:@"Selected:"];
    _selectedText.x = _rackZone.x - _rackZone.width/2 + 50;
    _selectedText.y = _rackZone.y - 30;
    _selectedText.color = SP_YELLOW;
    [_contents addChild:_selectedText];
    
    
    [_contents addChild:_rackZone];
    
    
//    _test1 = [[ScaledGamePiece alloc]initWithContentsOfFile:@"T_Desert_105.png"];
//    _test1.x = 20;
//    _test1.y = _gameHeight - _rackZone.height - _rackZone.height/6;
//    [_contents addChild:_test1];
//    
//    _test2 = [[ScaledGamePiece alloc]initWithContentsOfFile:@"T_Desert_106.png"];
//    _test2.x = _test1.width*1.4;
//    _test2.y = _gameHeight - _rackZone.height - _rackZone.height/6;
//    [_contents addChild:_test2];
//    
//    _test3 = [[ScaledGamePiece alloc]initWithContentsOfFile:@"T_Desert_107.png"];
//    _test3.x = (_test2.width*1.4) *1.7;
//    _test3.y = _gameHeight - _rackZone.height - _rackZone.height/6;
//
//    [_contents addChild:_test3];
    

    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(pieceSelected:)
                                                 name:@"pieceSelected"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(gameSetup:)
                                                 name:@"gameSetup"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(setupOver:)
                                                 name:@"setupOver"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(goldCollection:)
                                                 name:@"goldCollection"
                                               object:nil];


    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(placementOver:)
                                                 name:@"placementOver"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playerPlacedFort:)
                                                 name:@"playerPlacedFort"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playerPlacedCM:)
                                                 name:@"playerPlacedCM"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(timeToPlaceFort:)
                                                 name:@"timeToPlaceFort"
                                               object:nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(yourTurnCM:)
                                                 name:@"yourTurnCM"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(yourTurnFort:)
                                                 name:@"yourTurnFort"
                                               object:nil];
    
    
    [_contents addChild:[GoldCollection getInstance]];
    
    [[GoldCollection getInstance] setVisible:NO];
    
    _bowl = [[SPImage alloc] initWithContentsOfFile:@"Bowl.png"];
    _bowl.x = _gameWidth - _bowl.width;
    _bowl.y = _gameHeight - _rackZone.height - _rackZone.height/6;
    [_contents addChild:_bowl];
    [gamePieces addObject:_bowl];

}

-(void) placementOver: (NSNotification*) notif{
    [_stateText setText:@"State: Collect Gold"];

}

-(void) playerPlacedFort: (NSNotification*) notif{
    NSMutableDictionary *dic = notif.object;
    
    HexLocation *hex = [_state.hexLocations objectForKey:[dic objectForKey:@"hexLocationId"]];
    NSString *playerId = [dic objectForKey:@"playerId"];
    Fort *fort = [[GameResource getInstance] getFortForId:[dic objectForKey:@"fortId"]];
    Player *player;
                        
    for(Player *p in _state.players){
        if ([p.playerId isEqualToString:playerId]) {
            player = p;
        }
    }
    
    fort.owner = player;
    [hex addGamePieceToLocation:fort];
    
    NSLog(@"Moved fort to location %@", fort.location.locationId);
    
}

-(void) playerPlacedCM: (NSNotification*) notif{
    NSMutableDictionary *dic = notif.object;
    
    NSArray *hexes = [dic objectForKey:@"playerHexes"];
    
    Player *player;
    
    for(Player *p in _state.players){
        if ([p.playerId isEqualToString:[dic objectForKey:@"playerId"]]) {
            player = p;
        }
    }
    
    if(hexes != nil){
        for(NSString *hex in hexes) {
            HexLocation *location = [_state.hexLocations objectForKey:hex];
            [location changeOwnerToPlayer:player];
            NSLog(@"Changed %@ owner to %@", location.locationId, location.owner.playerId);
        }
    }
    
}

-(void) yourTurnFort: (NSNotification*) notif{
    _placementStep = PLACE_FORT;
    [_stateText setText:@"State: Place fort"];
}

-(void) yourTurnCM: (NSNotification*) notif{
    _placementStep = PLACE_CM;
    [_stateText setText:@"State: Place control marker"];

}

-(void) timeToPlaceFort: (NSNotification*) notif{
    
}

-(void) goldCollection: (NSNotification*) notif{
    
    _phase = GOLD;
    
    [_stateText setText:@"State: Gold Collection"];
    
    NSLog(@"Gold should appear");
    
    NSMutableDictionary *dic = notif.object;
    
    NSMutableDictionary *goldDic = [dic objectForKey:_state.myPlayerId];
    
    NSLog(@"%@", goldDic);
    
    NSString *total = [[NSString alloc] initWithString:[NSString stringWithFormat:@"%@",[goldDic objectForKey:@"totalGold"]]];
    NSString *income = [[NSString alloc] initWithString:[NSString stringWithFormat:@"%@",[goldDic objectForKey:@"income"]]];
    
    
    NSString *username;
    
    for(Player *p in _state.players){
        if ([p.playerId isEqualToString:_state.myPlayerId]) {
            username = [[NSString alloc] initWithString:p.username];
        }
        [p addGold:[[[dic objectForKey:p.playerId] objectForKey:@"income"] integerValue]];
    }
    
    [[GoldCollection getInstance] setIncome:[NSString stringWithFormat:@"Income: %@", income]];
    [[GoldCollection getInstance] setTotal:[NSString stringWithFormat:@"Total Gold: %@", total]];
    [[GoldCollection getInstance] setUsername:username];
    
    [[GoldCollection getInstance] setVisible:YES];
    
}


-(void) gameSetup: (NSNotification*) notif{
    
    _phase = SETUP;
    
    [_stateText setText:@"State: Setup"];

    _state = (GameState*) notif.object;
    
    NSLog(@"%@", _state);
    
    
    for(Player *p in _state.players){
        if ([p.playerId isEqualToString:@"player1"]) {
            _player1 = p;
        } else         if ([p.playerId isEqualToString:@"player2"]) {
            _player2 = p;
        } else         if ([p.playerId isEqualToString:@"player3"]) {
            _player3 = p;
        } else         if ([p.playerId isEqualToString:@"player4"]) {
            _player4 = p;
        }
    }
    
    
    [self drawTiles];
    
    [self drawRack];
    
    [[InGameServerAccess instance] setupPhaseReadyForPlacement];
    
}

-(void) setupOver: (NSNotification*) notif{
    
    _phase = PLACEMENT;
    
    [_stateText setText:@"State: Placement"];
    
    
}



-(void) pieceSelected: (NSNotification*) notif{
    
    _selectedPiece = (GamePiece*) notif.object;
    
    NSLog(@"Selected Piece");
    
    _selectedPieceImage = [[SPImage alloc] initWithContentsOfFile:[_selectedPiece fileName]];
    _selectedPieceImage.x = 90;
    _selectedPieceImage.y = _rackZone.y - _selectedPieceImage.height;
    [_contents addChild:_selectedPieceImage];
    
    
}

-(void) drawRack{
    Player *player;
    
    for(Player *p in _state.players){
        if ([p.playerId isEqualToString:[_state myPlayerId]]) {
            player = p;
        }
    }
    
    Rack *rack1 = [player rack1];
    Rack *rack2 = [player rack2];
    
    float rackX = _rackZone.x;
    float rackY = _rackZone.y;
    
    float prevX = 0;
    
    for (NSString *key in rack1.pieces) {
        ScaledGamePiece *img = [[rack1.pieces objectForKey:key] pieceImage];
        img.x = rackX + prevX;
        img.y = rackY;
        prevX += img.width + 5;
        [_contents addChild:img];
    }
    
    rackY = _rackZone.y + 50;
    prevX = 0;
    
    for (NSString *key in rack2.pieces) {
        ScaledGamePiece *img = [[rack2.pieces objectForKey:key] pieceImage];
        img.x = rackX + prevX;
        img.y = rackY;
        prevX += img.width + 5;
        [_contents addChild:img];
    }
    
    
}




-(void) drawTiles
{
    int yOffset = -15;
    int yOffset2 = -5;
    //Drawing hexagons for middle (7)
    for (int i = 0; i < 7; i++){
        
        bool drawNext = false;
        
        if (i == 0) {
            drawNext = true;
            
            
            HexLocation *location = [_state.hexLocations objectForKey:@"hexLocation_21"];
            HexTile   *tile = location.tile;
            tile.image.x = 133;
            tile.image.y = 10 + ((i  * (tile.image.height + 1))) - yOffset;
           
            
            [_sheet addChild: tile.image];
            
            [tile.image addEventListener:@selector(onTileClick:) atObject:self forType:SP_EVENT_TYPE_TOUCH];

            
        }
        
        if (i == 4) {
           // drawNext = true;
            
            HexLocation *location = [_state.hexLocations objectForKey:@"hexLocation_4"];
            HexTile   *tile = location.tile;
            tile.image.x = 133;
            tile.image.y = 10 + ((i  * (tile.image.height + 1))) - yOffset;
            [tile.image addEventListener:@selector(onTileClick:) atObject:self forType:SP_EVENT_TYPE_TOUCH];

            [_sheet addChild: tile.image];;
        }
        if (i == 5) {
           // drawNext = true;
            HexLocation *location = [_state.hexLocations objectForKey:@"hexLocation_14"];
            HexTile   *tile = location.tile;
            tile.image.x = 133;
            tile.image.y = 10 + ((i  * (tile.image.height + 1))) - yOffset;
            [tile.image addEventListener:@selector(onTileClick:) atObject:self forType:SP_EVENT_TYPE_TOUCH];

            [_sheet addChild: tile.image];;
        }
        if (i == 6) {
          //  drawNext = true;
            HexLocation *location = [_state.hexLocations objectForKey:@"hexLocation_30"];
            HexTile   *tile = location.tile;
            tile.image.x = 133;
            tile.image.y = 10 + ((i  * (tile.image.height + 1))) - yOffset;
            [tile.image addEventListener:@selector(onTileClick:) atObject:self forType:SP_EVENT_TYPE_TOUCH];

            [_sheet addChild: tile.image];;
        }
        
        //Draw missing tile
        if (i == 1){
          //  drawNext = true;
            HexLocation *location = [_state.hexLocations objectForKey:@"hexLocation_8"];
            HexTile   *tile = location.tile;
            tile.image.x = 133;
            tile.image.y = 10 + ((i  * (tile.image.height + 1))) - yOffset;
            [tile.image addEventListener:@selector(onTileClick:) atObject:self forType:SP_EVENT_TYPE_TOUCH];

            [_sheet addChild: tile.image];
        }
        
        
        if (drawNext) {
            //Drawing hexagon for left side after first hexagon (6)
            for (int j = 0; j < 6; j ++) {
                
                
                if (j == 0){
                    
                    HexLocation *location = [_state.hexLocations objectForKey:@"hexLocation_20"];
                    HexTile   *tile = location.tile;
                    tile.image.x = 133- (tile.image.width - 10);
                    tile.image.y = 10 + ((j  * (tile.image.height + 1))) + tile.image.height /2 - yOffset;

                    [tile.image addEventListener:@selector(onTileClick:) atObject:self forType:SP_EVENT_TYPE_TOUCH];

                    [_sheet addChild: tile.image];
                   
                  
                }
                
                if (j == 1){
                    HexLocation *location = [_state.hexLocations objectForKey:@"hexLocation_7"];
                    HexTile   *tile = location.tile;
                    tile.image.x = 133  - (tile.image.width - 10);
                    tile.image.y = 10 + ((j  * (tile.image.height + 1))) + tile.image.height /2 - yOffset;
                    [tile.image addEventListener:@selector(onTileClick:) atObject:self forType:SP_EVENT_TYPE_TOUCH];

                    [_sheet addChild: tile.image];
                }
                if (j == 2){
                    HexLocation *location = [_state.hexLocations objectForKey:@"hexLocation_6"];
                    HexTile   *tile = location.tile;
                    tile.image.x = 133  - (tile.image.width - 10);
                    tile.image.y = 10 + ((j  * (tile.image.height + 1))) + tile.image.height /2 - yOffset;

                    [tile.image addEventListener:@selector(onTileClick:) atObject:self forType:SP_EVENT_TYPE_TOUCH];

                    
                    [_sheet addChild: tile.image];
                }
                if (j == 3){
                    
                    HexLocation *location = [_state.hexLocations objectForKey:@"hexLocation_5"];
                    HexTile   *tile = location.tile;
                    tile.image.x = 133  - (tile.image.width - 10);
                    tile.image.y = 10 + ((j  * (tile.image.height + 1))) + tile.image.height /2 - yOffset;
                    [tile.image addEventListener:@selector(onTileClick:) atObject:self forType:SP_EVENT_TYPE_TOUCH];

                    [_sheet addChild: tile.image];
                }
                if (j == 4){
                    HexLocation *location = [_state.hexLocations objectForKey:@"hexLocation_15"];
                    HexTile   *tile = location.tile;
                    tile.image.x = 133  - (tile.image.width - 10);
                    tile.image.y = 10 + ((j  * (tile.image.height + 1))) + tile.image.height /2 - yOffset;
                    [tile.image addEventListener:@selector(onTileClick:) atObject:self forType:SP_EVENT_TYPE_TOUCH];

                    
                    [_sheet addChild: tile.image];
                }
                if (j == 5){
                    HexLocation *location = [_state.hexLocations objectForKey:@"hexLocation_31"];
                    HexTile   *tile = location.tile;
                    tile.image.x = 133  - (tile.image.width - 10);
                    tile.image.y = 10 + ((j  * (tile.image.height + 1))) + tile.image.height /2 - yOffset;
                    [tile.image addEventListener:@selector(onTileClick:) atObject:self forType:SP_EVENT_TYPE_TOUCH];

                    
                    [_sheet addChild: tile.image];
                }
                
        }
            
            //Drawing hexagon for right side after first hexagon (6)
            for (int j = 0; j < 6; j ++) {
                
                if (j == 0){
                    
                    HexLocation *location = [_state.hexLocations objectForKey:@"hexLocation_22"];
                    HexTile   *tile = location.tile;
                    tile.image.x = 133  + (tile.image.width - 10);
                    tile.image.y = 10 + ((j  * (tile.image.height + 1))) + tile.image.height /2 - yOffset;

                    [tile.image addEventListener:@selector(onTileClick:) atObject:self forType:SP_EVENT_TYPE_TOUCH];

                    [_sheet addChild: tile.image];
                }
                
                if (j == 1){
                    
                    HexLocation *location = [_state.hexLocations objectForKey:@"hexLocation_9"];
                    HexTile   *tile = location.tile;
                    tile.image.x = 133  + (tile.image.width - 10);
                    tile.image.y = 10 + ((j  * (tile.image.height + 1))) + tile.image.height /2 - yOffset;
                    [tile.image addEventListener:@selector(onTileClick:) atObject:self forType:SP_EVENT_TYPE_TOUCH];

                    [_sheet addChild: tile.image];
                }
                if (j == 2){
                    HexLocation *location = [_state.hexLocations objectForKey:@"hexLocation_2"];
                    HexTile   *tile = location.tile;
                    tile.image.x = 133  + (tile.image.width - 10);
                    tile.image.y = 10 + ((j  * (tile.image.height + 1))) + tile.image.height /2 - yOffset;
                    [tile.image addEventListener:@selector(onTileClick:) atObject:self forType:SP_EVENT_TYPE_TOUCH];

                    [_sheet addChild: tile.image];
                }
                if (j == 3){
                    HexLocation *location = [_state.hexLocations objectForKey:@"hexLocation_3"];
                    HexTile   *tile = location.tile;
                    tile.image.x = 133  + (tile.image.width - 10);
                    tile.image.y = 10 + ((j  * (tile.image.height + 1))) + tile.image.height /2 - yOffset;
                    [tile.image addEventListener:@selector(onTileClick:) atObject:self forType:SP_EVENT_TYPE_TOUCH];

                    [_sheet addChild: tile.image];
                }
                if (j == 4){
                    HexLocation *location = [_state.hexLocations objectForKey:@"hexLocation_13"];
                    HexTile   *tile = location.tile;
                    tile.image.x = 133  + (tile.image.width - 10);
                    tile.image.y = 10 + ((j  * (tile.image.height + 1))) + tile.image.height /2 - yOffset;
                    [tile.image addEventListener:@selector(onTileClick:) atObject:self forType:SP_EVENT_TYPE_TOUCH];

                    [_sheet addChild: tile.image];
                }
                if (j == 5){
                    HexLocation *location = [_state.hexLocations objectForKey:@"hexLocation_29"];
                    HexTile   *tile = location.tile;
                    tile.image.x = 133  + (tile.image.width - 10);
                    tile.image.y = 10 + ((j  * (tile.image.height + 1))) + tile.image.height /2 - yOffset;
                    [tile.image addEventListener:@selector(onTileClick:) atObject:self forType:SP_EVENT_TYPE_TOUCH];

                    [_sheet addChild: tile.image];
                }
            }
            
            drawNext = false;
        }
        
        //Draw missing tile 2
        if (i == 2){
            drawNext = true;
            HexLocation *location = [_state.hexLocations objectForKey:@"hexLocation_1"];
            HexTile   *tile = location.tile;
            tile.image.x = 133;
            tile.image.y = 10 + ((i  * (tile.image.height + 1))) - yOffset;
            [tile.image addEventListener:@selector(onTileClick:) atObject:self forType:SP_EVENT_TYPE_TOUCH];

            [_sheet addChild: tile.image];
            
            
            
        }
        
      //Draw thrid row
        
        if (drawNext) {
            //Drawing hexagon for left side after first hexagon (5)
            for (int j = 0; j < 5; j ++) {
   
                if (j == 0 ){
                    HexLocation *location = [_state.hexLocations objectForKey:@"hexLocation_19"];
                    HexTile   *tile = location.tile;
                    tile.image.x = 133  - ((tile.image.width * 2) - 20);
                    tile.image.y = 10 + ((j  * (tile.image.height + 1))) + (tile.image.height) - yOffset;
                    [tile.image addEventListener:@selector(onTileClick:) atObject:self forType:SP_EVENT_TYPE_TOUCH];

                    
                   [_sheet addChild: tile.image];
                    
                   [location changeOwnerToPlayer:_player4];
                    if ([_state.myPlayerId isEqualToString:@"player4"]) {
                        placeHex1 = location.locationId;
                    }
                }
                if (j == 1 ){
                    HexLocation *location = [_state.hexLocations objectForKey:@"hexLocation_18"];
                    HexTile   *tile = location.tile;
                    tile.image.x = 133  - ((tile.image.width * 2) - 20);
                    tile.image.y = 10 + ((j  * (tile.image.height + 1))) + (tile.image.height) - yOffset;
                    [tile.image addEventListener:@selector(onTileClick:) atObject:self forType:SP_EVENT_TYPE_TOUCH];

                    [_sheet addChild: tile.image];
                }
                if (j == 2 ){
                    HexLocation *location = [_state.hexLocations objectForKey:@"hexLocation_17"];
                    HexTile   *tile = location.tile;
                    tile.image.x = 133  - ((tile.image.width * 2) - 20);
                    tile.image.y = 10 + ((j  * (tile.image.height + 1))) + (tile.image.height) - yOffset;
                    [tile.image addEventListener:@selector(onTileClick:) atObject:self forType:SP_EVENT_TYPE_TOUCH];

                    [_sheet addChild: tile.image];
                }
                if (j == 3 ){
                    HexLocation *location = [_state.hexLocations objectForKey:@"hexLocation_16"];
                    HexTile   *tile = location.tile;
                    tile.image.x = 133  - ((tile.image.width * 2) - 20);
                    tile.image.y = 10 + ((j  * (tile.image.height + 1))) + (tile.image.height) - yOffset;
                    [tile.image addEventListener:@selector(onTileClick:) atObject:self forType:SP_EVENT_TYPE_TOUCH];

                    [_sheet addChild: tile.image];
                }
                if (j == 4 ){
                    HexLocation *location = [_state.hexLocations objectForKey:@"hexLocation_32"];
                    HexTile   *tile = location.tile;
                    tile.image.x = 133  - ((tile.image.width * 2) - 20);
                    tile.image.y = 10 + ((j  * (tile.image.height + 1))) + (tile.image.height) - yOffset;
                    [tile.image addEventListener:@selector(onTileClick:) atObject:self forType:SP_EVENT_TYPE_TOUCH];

                   [_sheet addChild: tile.image];
                    [location changeOwnerToPlayer:_player3];
                    if ([_state.myPlayerId isEqualToString:@"player3"]) {
                        placeHex1 = location.locationId;
                    }
                }
                
                
            }
            
            //Drawing hexagon for right side after first hexagon (5)
            for (int j = 0; j < 5; j ++) {
                
                if (j == 0) {
                    HexLocation *location = [_state.hexLocations objectForKey:@"hexLocation_23"];
                    HexTile   *tile = location.tile;
                    tile.image.x = 133  + ((tile.image.width * 2) - 20);
                    tile.image.y = 10 + ((j  * (tile.image.height + 1))) + (tile.image.height) - yOffset;
                    [tile.image addEventListener:@selector(onTileClick:) atObject:self forType:SP_EVENT_TYPE_TOUCH];

                    
                    [_sheet addChild: tile.image];
                    
                    [location changeOwnerToPlayer:_player1];
                    if ([_state.myPlayerId isEqualToString:@"player1"]) {
                        placeHex1 = location.locationId;
                    }
                }
                if (j == 1) {
                    HexLocation *location = [_state.hexLocations objectForKey:@"hexLocation_10"];
                    HexTile   *tile = location.tile;
                    tile.image.x = 133  + ((tile.image.width * 2) - 20);
                    tile.image.y = 10 + ((j  * (tile.image.height + 1))) + (tile.image.height) - yOffset;
                    [tile.image addEventListener:@selector(onTileClick:) atObject:self forType:SP_EVENT_TYPE_TOUCH];

                    
                    [_sheet addChild: tile.image];
                }
                if (j == 2) {
                    HexLocation *location = [_state.hexLocations objectForKey:@"hexLocation_11"];
                    HexTile   *tile = location.tile;
                    tile.image.x = 133  + ((tile.image.width * 2) - 20);
                    tile.image.y = 10 + ((j  * (tile.image.height + 1))) + (tile.image.height) - yOffset;
                    [tile.image addEventListener:@selector(onTileClick:) atObject:self forType:SP_EVENT_TYPE_TOUCH];


                    [_sheet addChild: tile.image];                }
                if (j == 3) {
                    HexLocation *location = [_state.hexLocations objectForKey:@"hexLocation_12"];
                    HexTile   *tile = location.tile;
                    tile.image.x = 133  + ((tile.image.width * 2) - 20);
                    tile.image.y = 10 + ((j  * (tile.image.height + 1))) + (tile.image.height) - yOffset;

                    [tile.image addEventListener:@selector(onTileClick:) atObject:self forType:SP_EVENT_TYPE_TOUCH];

                   
                    [_sheet addChild: tile.image];
                }
                if (j == 4) {
                    HexLocation *location = [_state.hexLocations objectForKey:@"hexLocation_28"];
                    HexTile   *tile = location.tile;
                    tile.image.x = 133  + ((tile.image.width * 2) - 20);
                    tile.image.y = 10 + ((j  * (tile.image.height + 1))) + (tile.image.height) - yOffset;
                    [tile.image addEventListener:@selector(onTileClick:) atObject:self forType:SP_EVENT_TYPE_TOUCH];


                    [_sheet addChild: tile.image];
                    
                    [location changeOwnerToPlayer:_player2];
                    if ([_state.myPlayerId isEqualToString:@"player2"]) {
                        placeHex1 = location.locationId;
                    }
                }
                
            }
            
            drawNext = false;
        }
        
        //Draw missing tile 3
        if (i == 3){
            drawNext = true;
            HexLocation *location = [_state.hexLocations objectForKey:@"hexLocation_0"];
            HexTile   *tile = location.tile;
            tile.image.x = 133;
            tile.image.y = 10 + ((i  * (tile.image.height + 1))) - yOffset;
            [tile.image addEventListener:@selector(onTileClick:) atObject:self forType:SP_EVENT_TYPE_TOUCH];

            [_sheet addChild: tile.image];
        }
            
        
        //Draw fourth row
        if (drawNext) {
            //Drawing hexagon for left side after first hexagon (4)
            for (int j = 0; j < 4; j ++) {
                
                if (j == 0){
                    HexLocation *location = [_state.hexLocations objectForKey:@"hexLocation_36"];
                    HexTile   *tile = location.tile;
                    tile.image.x = 134  - ((tile.image.width * 3) - 30);
                    tile.image.y = 43 + ((j  * (tile.image.height + 1))) + (tile.image.height) - yOffset2 * 1.3;

                    [tile.image addEventListener:@selector(onTileClick:) atObject:self forType:SP_EVENT_TYPE_TOUCH];

                    [_sheet addChild: tile.image];                }
                if (j == 1){
                    HexLocation *location = [_state.hexLocations objectForKey:@"hexLocation_35"];
                    HexTile   *tile = location.tile;
                    tile.image.x = 134  - ((tile.image.width * 3) - 30);
                    tile.image.y = 43 + ((j  * (tile.image.height + 1))) + (tile.image.height) - yOffset2 * 1.3;
                    
                    [tile.image addEventListener:@selector(onTileClick:) atObject:self forType:SP_EVENT_TYPE_TOUCH];

                    [_sheet addChild: tile.image];
                }
                if (j == 2){
                    HexLocation *location = [_state.hexLocations objectForKey:@"hexLocation_34"];
                    HexTile   *tile = location.tile;
                    tile.image.x = 134  - ((tile.image.width * 3) - 30);
                    tile.image.y = 43 + ((j  * (tile.image.height + 1))) + (tile.image.height) - yOffset2 * 1.3;
                    [tile.image addEventListener:@selector(onTileClick:) atObject:self forType:SP_EVENT_TYPE_TOUCH];

                    [_sheet addChild: tile.image];
                }
                if (j == 3){
                    HexLocation *location = [_state.hexLocations objectForKey:@"hexLocation_33"];
                    HexTile   *tile = location.tile;
                    tile.image.x = 134  - ((tile.image.width * 3) - 30);
                    tile.image.y = 43 + ((j  * (tile.image.height + 1))) + (tile.image.height) - yOffset2 * 1.3;
                    [tile.image addEventListener:@selector(onTileClick:) atObject:self forType:SP_EVENT_TYPE_TOUCH];

                    [_sheet addChild: tile.image];
                }
                
                
            }
            
            //Drawing hexagon for right side after first hexagon (4)
            for (int j = 0; j < 4; j ++) {
                
                if (j == 0) {
                    HexLocation *location = [_state.hexLocations objectForKey:@"hexLocation_24"];
                    HexTile   *tile = location.tile;
                    tile.image.x = 134  + ((tile.image.width * 3) - 30);
                    tile.image.y = 43 + ((j  * (tile.image.height + 1))) + (tile.image.height) - yOffset2 * 1.3;
                    
                    [tile.image addEventListener:@selector(onTileClick:) atObject:self forType:SP_EVENT_TYPE_TOUCH];

                   [_sheet addChild: tile.image];
                }
                if (j == 1) {
                    
                    HexLocation *location = [_state.hexLocations objectForKey:@"hexLocation_25"];
                    HexTile   *tile = location.tile;
                    tile.image.x = 134  + ((tile.image.width * 3) - 30);
                    tile.image.y = 43 + ((j  * (tile.image.height + 1))) + (tile.image.height) - yOffset2 * 1.3;
                    [tile.image addEventListener:@selector(onTileClick:) atObject:self forType:SP_EVENT_TYPE_TOUCH];

                    
                    [_sheet addChild: tile.image];
                }
                if (j == 2) {
                    HexLocation *location = [_state.hexLocations objectForKey:@"hexLocation_26"];
                    HexTile   *tile = location.tile;
                    tile.image.x = 134  + ((tile.image.width * 3) - 30);
                    tile.image.y = 43 + ((j  * (tile.image.height + 1))) + (tile.image.height) - yOffset2 * 1.3;
                    [tile.image addEventListener:@selector(onTileClick:) atObject:self forType:SP_EVENT_TYPE_TOUCH];

                    [_sheet addChild: tile.image];
                }
                if (j == 3) {
                    HexLocation *location = [_state.hexLocations objectForKey:@"hexLocation_27"];
                    HexTile   *tile = location.tile;
                    tile.image.x = 134  + ((tile.image.width * 3) - 30);
                    tile.image.y = 43 + ((j  * (tile.image.height + 1))) + (tile.image.height) - yOffset2 * 1.3;
                    [tile.image addEventListener:@selector(onTileClick:) atObject:self forType:SP_EVENT_TYPE_TOUCH];

                    [_sheet addChild: tile.image];
                }
                
                
            }
            
            drawNext = false;
        }
    }
}



//
//-(void) putTower:(SPTouchEvent*) event
//{
//    SPImage *img = (SPImage*)event.target;
//    SPImage *newimg;
//    bool didPutTower = true;
//    
//     NSArray *touches = [[event touchesWithTarget:self andPhase:SPTouchPhaseBegan] allObjects];
//    
//    if (touches.count == 1 && didPutTower)
//    {
//        NSLog(@"le tile click");
//        
//        newimg = [[SPImage alloc] initWithContentsOfFile:@"C_Fort_375.png"];
//        newimg.scaleX = 0.3;
//        newimg.scaleY = 0.3;
//        
//        
//        //Place tower on a random spot
//        newimg.x = fmod(arc4random(), (img.x - (img.x + 10))) + (img.x + 10);
//        newimg.y = fmod(arc4random(), (img.y - (img.y + 15))) + (img.y + 15);
//        NSLog(@"placed dat tower bb");
//        
//        [_sheet addChild:newimg];
//        
//        didPutTower = !didPutTower;
//    }
//}

-(void) onTileClick: (SPTouchEvent*) event
{
    NSArray *touches = [[event touchesWithTarget:self andPhase:SPTouchPhaseBegan] allObjects];
    
    TileImage *img = (TileImage*) event.target;
    HexTile  *tile = (HexTile*) img.owner;
    HexLocation *location = (HexLocation*) tile.location;
    
    switch (_phase) {
        case SETUP:
            
            break;
        case PLACEMENT:
            switch (_placementStep) {
                case PLACE_CM:
                    if (touches.count == 1)
                    {
                        if (![tile.terrain.terrainName isEqualToString:@"Sea"]) {
                            
                            SPTouch *clicks = [touches objectAtIndex:0];

                            if (clicks.tapCount == 2){
                                NSLog(@"le double click");
                                [NSObject cancelPreviousPerformRequestsWithTarget:self];
                                [tile changeOwnerTo:_state.myPlayerId];
                                switch (markerCount) {
                                    case 2:
                                        placeHex2 = location.locationId;
                                        markerCount--;
                                        break;
                                    case 1:
                                        placeHex3 = location.locationId;
                                        [[InGameServerAccess instance] placementPhasePlaceControlMarkersFirst:placeHex1 second:placeHex2 third:placeHex3];
                                        markerCount--;
                                        break;
                                    default:
                                        break;
                                }
                            }
                        }
                        
                    }
                    break;
                case PLACE_FORT:
                    if (touches.count == 1)
                    {
                        if (![tile.terrain.terrainName isEqualToString:@"Sea"] && [tile.owner.playerId isEqualToString:[_state myPlayerId]]) {
                            
                            SPTouch *clicks = [touches objectAtIndex:0];
                            
                            if (clicks.tapCount == 2){
                                NSLog(@"le double click");
                                [NSObject cancelPreviousPerformRequestsWithTarget:self];
                                [location addGamePieceToLocation:_selectedPiece];
                                [[InGameServerAccess instance] placementPhasePlaceFort:location.locationId];
                            }
                        }
                        
                    }
                    break;
                    
                default:
                    break;
            }
            break;
        case GOLD:
            
            break;
        case MOVEMENT:
            
            break;
            
        default:
            break;
    }
    
    

    
}


- (void)showTileMenu {
    TileMenu *tileScene = [[TileMenu alloc] init];
    [self showScene:tileScene];
}

-(void) showScene:(SPSprite *)scene
{
    [self addChild:scene];
    scene.visible = YES;

}

@end
