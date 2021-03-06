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
#import "Log.h"
#import "TileImage.h"
#import "Terrain.h"
#import "RecruitThings.h"
#import "InGameServerAccess.h"
#import "ServerAccess.h"
#import "SideMenu.h"
#import "Stack.h"
#import "RecruitCharacter.h"
#import "SpecialIncomeCounters.h"
#import "UIAlertView+Blocks.h"
#import "CombatPhaseScreenController.h"
#import "ServerResponseMessage.h"
#import "Game.h"
#import "Utils.h"
#import "RackPiecesMenu.h"
#import "ConstructionMenu.h"
#import "User.h"
#import "Rack.h"
#import "SpecialCharacter.h"
#import "GameBoardHelper.h"
#import "PlayingCup.h"
#import "RandomEvent.h"
#import "MagicItems.h"
#import "NonCityVill.h"
#import "CityVill.h"
#import "Treasure.h"
#import "WinningScreen.h"
#import "RandomEventsMenu.h"

@interface FourPlayerGame ()
- (void) setup;
- (void) showScene:(SPSprite*)scene;
@end

@implementation FourPlayerGame{
    NSMutableArray *gamePieces;
    
    
    int markerCount;
    NSString *placeHex1, *placeHex2, *placeHex3;
    
    NSInteger _placementStep;
    NSInteger _wasBought;
    
    Player *_player1;
    Player *_player2;
    Player *_player3;
    Player *_player4;


    SPSprite *_bottomLayerContents;
    SPSprite *_currentScene;
    SPSprite *_contents;
    SPSprite *_phasesScreensContents;
    SPSprite *_winningContents;
    
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
    
    int panWidth;
    
    
    SPTextField *_selectedText;
    SPTextField *_playerIdText;
    
    SPImage *_selectedPieceImage;
    
    GamePiece *_selectedPiece;
    Stack  *_selectedStack;
    
    SPImage *_doneBtn;
    GameState *_state;
    SPImage *_rackZone;
    
    UIAlertView *_movementAlert;
    
    //Background of current scene
    SPImage *_background;
    
    
    //Side menu
    BOOL isSideMenu;
    
    SPButton *menuButton;
    
    CombatPhaseScreenController *_combatPhaseController;
    
    SPButton * moveDoneButton;
    
    ConstructionMenu *cMenu;
    
    BOOL _canExplore;
    
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
    _canExplore = NO;
    
    [self addChild:[SideMenu getInstance]];
    [GameResource getInstance];
    
    [self.stage addChild:self];
    
    _gameWidth = Sparrow.stage.width;
    _gameHeight = Sparrow.stage.height;
    
    panWidth = 200;
    
    markerCount = 2;
    
    isSideMenu = YES;
    
     placeHex1 = [[NSString alloc] init];
     placeHex2 = [[NSString alloc] init];
     placeHex3 = [[NSString alloc] init];

    
    gamePieces = [[NSMutableArray alloc]init];
    
    _bottomLayerContents = [SPSprite sprite];
    [self addChild:_bottomLayerContents];
    
    _contents = [SPSprite sprite];
    [self addChild:_contents];
    
    _phasesScreensContents = [SPSprite sprite];
    [self addChild:_phasesScreensContents];
   
    _winningContents = [SPSprite sprite];
    [self addChild:_winningContents];
    
     _background = [[SPImage alloc] initWithContentsOfFile:@"FourPlayerBackground@2x.png"];
    
    //necessary or else it gets placed off screen
    _background.x = 0;
    _background.y = 0;
    
    _sheet = [[TouchSheet alloc] initWithQuad:_background];
    
    //Add the sheet to the contents so that it appears
    [_bottomLayerContents addChild:_sheet];
    
    
    _playerIdText = [SPTextField textFieldWithWidth:200 height:30 text:@""];
    _playerIdText.x = _gameWidth - _playerIdText.width;
    _playerIdText.y = 2;
    
    _stateText = [SPTextField textFieldWithWidth:200 height:30 text:@"State:"];
    _stateText.x = 0;
    _stateText.y = 2;
    _stateText.color = SP_YELLOW;
    [_contents addChild:_stateText];
    

    
    //Income labels
    _Player1LabelText = [SPTextField textFieldWithWidth:110 height:30 text:@"Player1 Gold:"];
    _Player1LabelText.x = _gameWidth - _Player1LabelText.width - (_Player1LabelText.width/2) + 25;
    _Player1LabelText.y = 335;
    _Player1LabelText.color = SP_RED;
    [_contents addChild:_Player1LabelText];
    
    _Player2LabelText = [SPTextField textFieldWithWidth:110 height:30 text:@"Player2 Gold:"];
    _Player2LabelText.x = _gameWidth - _Player2LabelText.width - (_Player2LabelText.width/2) + 25;
    _Player2LabelText.y = 335 + _Player1LabelText.height / 2;
    _Player2LabelText.color = SP_YELLOW;
    [_contents addChild:_Player2LabelText];
    
    _Player3LabelText = [SPTextField textFieldWithWidth:110 height:30 text:@"Player3 Gold:"];
    _Player3LabelText.x = _gameWidth - _Player3LabelText.width - (_Player3LabelText.width/2)+ 25;
    _Player3LabelText.y = 335 + _Player3LabelText.height;
    _Player3LabelText.color = SP_GREEN;
    [_contents addChild:_Player3LabelText];
    
    _Player4LabelText = [SPTextField textFieldWithWidth:110 height:30 text:@"Player4 Gold:"];
    _Player4LabelText.x = _gameWidth - _Player4LabelText.width - (_Player4LabelText.width/2)+ 25;
    _Player4LabelText.y = 335 + _Player4LabelText.height*1.5;
    _Player4LabelText.color = SP_BLUE;
    [_contents addChild:_Player4LabelText];
    
    
    //Income Text
    _Player1IncomeText = [SPTextField textFieldWithWidth:90 height:30 text:@"10"];
    _Player1IncomeText.x = _gameWidth - _Player1IncomeText.width + 25 ;
    _Player1IncomeText.y = 335;
    _Player1IncomeText.color = SP_RED;
    [_contents addChild:_Player1IncomeText];
    
    _Player2IncomeText = [SPTextField textFieldWithWidth:90 height:30 text:@"10"];
    _Player2IncomeText.x = _gameWidth - _Player2IncomeText.width + 25 ;
    _Player2IncomeText.y = 335+ _Player1LabelText.height / 2;
    _Player2IncomeText.color = SP_YELLOW;
    [_contents addChild:_Player2IncomeText];
    
    _Player3IncomeText = [SPTextField textFieldWithWidth:90 height:30 text:@"10"];
    _Player3IncomeText.x = _gameWidth - _Player3IncomeText.width + 25 ;
    _Player3IncomeText.y = 335 + _Player3LabelText.height;
    _Player3IncomeText.color = SP_GREEN;
    [_contents addChild:_Player3IncomeText];
    
    _Player4IncomeText = [SPTextField textFieldWithWidth:90 height:30 text:@"10"];
    _Player4IncomeText.x = _gameWidth - _Player4IncomeText.width + 25 ;
    _Player4IncomeText.y = 335+ _Player4LabelText.height*1.5;
    _Player4IncomeText.color = SP_BLUE;
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
    
    // Expand Rack Button
    SPTexture *expandtext = [SPTexture textureWithContentsOfFile:@"expand@2x.png"];
    SPButton* expandButton = [SPButton buttonWithUpState:expandtext];
    expandButton.x = _gameWidth - 65 * 2.3;
    expandButton.y = _gameHeight - _rackZone.height + 66;
    expandButton.scaleX = expandButton.scaleY = 0.71;
    [_contents addChild:expandButton];
    [expandButton addEventListener:@selector(expandRack:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    
    
    //Movement done button
    SPTexture *moveDoneButtonBackgroundTexture = [SPTexture textureWithContentsOfFile:@"done-button.png"];
    moveDoneButton = [SPButton buttonWithUpState:moveDoneButtonBackgroundTexture];
    moveDoneButton.x = _gameWidth - 32 * 2.3;
    moveDoneButton.y = _gameHeight - _rackZone.height;
    moveDoneButton.scaleX = moveDoneButton.scaleY = 0.41;
    [_contents addChild:moveDoneButton];
    [moveDoneButton addEventListener:@selector(moveDone:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    moveDoneButton.visible = NO;
    
    SPTexture *menuTexture = [SPTexture textureWithContentsOfFile:@"menu.png"];
    menuButton = [SPButton buttonWithUpState:menuTexture];
    menuButton.x = 10;
    menuButton.y = 7;
    
    //When the menuButton is clicked move the current scene some number
    //When the menuButton is clicked move the current scene some number
    //to the right to show the other scene. Clicking the button again will
    //reset the location back to the starting point.
    
    
    [menuButton addEventListener:@selector(moveRight:) atObject:self forType:SP_EVENT_TYPE_TOUCH];

    
    [self addChild:menuButton];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(pieceSelected:)
                                                 name:@"pieceSelected"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(gameOver:)
                                                 name:@"gameOver"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(clearSelectedPiece:)
                                                 name:@"clearSelectedPiece"
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
                                             selector:@selector(collectedGold:)
                                                 name:@"collectedGold"
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
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playerMovedPieceToNewLocation:)
                                                 name:@"playerMovedPieceToNewLocation"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(yourTurnToMoveInMovement:)
                                                 name:@"yourTurnToMoveInMovement"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(movementPhaseOver:)
                                                 name:@"movementPhaseOver"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(recruitToBoardBought:)
                                                 name:@"recruitToBoardBought"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(recruitToBoardFree:)
                                                 name:@"recruitToBoardFree"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(addToRack:)
                                                 name:@"addToRack"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(recruitThingsPhaseOver:)
                                                 name:@"recruitThingsPhaseOver"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didStartRecruitCharactersPhase:)
                                                 name:@"didStartRecruitCharactersPhase"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playerGoldChanged:)
                                                 name:@"playerGoldChanged"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(rackUpdated:)
                                                 name:@"rackUpdated"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(constructionStarted:)
                                                 name:@"constructionStarted"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playerWon:)
                                                 name:@"playerWon"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(randomEventsStarted:)
                                                 name:@"randomEventsStarted"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(movePieceImage:)
                                                 name:@"movePieceImage"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moveStackImage:)
                                                 name:@"moveStackImage"
                                               object:nil];
    

    
    
    _combatPhaseController = [[CombatPhaseScreenController alloc] initWithFourPlayerGame:self];
    
    [Utils showLoaderOnView:Sparrow.currentController.view animated:YES];
}


-(void) moveRight:(SPTouchEvent*) event{
    NSArray *touches = [[event touchesWithTarget:self andPhase:SPTouchPhaseBegan] allObjects];
    
    
    if (touches.count == 1) {
        
        if(isSideMenu){
            [self moveOverSpriteToRightForMenu:_contents withX:panWidth];
            [self moveOverSpriteToRightForMenu:menuButton withX:panWidth+10];
            [self moveOverSpriteToRightForMenu:_phasesScreensContents withX:panWidth];
            [self moveOverSpriteToRightForMenu:_bottomLayerContents withX:panWidth];
        
            [[NSNotificationCenter defaultCenter] postNotificationName:@"menuMovedRight" object:nil];
        } else {
            [self moveOverSpriteToRightForMenu:_contents withX:0];
            [self moveOverSpriteToRightForMenu:menuButton withX:10];
            [self moveOverSpriteToRightForMenu:_phasesScreensContents withX:0];
            [self moveOverSpriteToRightForMenu:_bottomLayerContents withX:0];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"menuMovedLeft" object:nil];
        }

        isSideMenu = !isSideMenu;
    }
}

-(void) moveOverSpriteToRightForMenu: (SPDisplayObjectContainer*) sprite withX: (int) x{
    SPTween *tween = [SPTween tweenWithTarget:sprite time:0.25f
                                   transition:SP_TRANSITION_LINEAR];
    [tween animateProperty:@"x" targetValue:x];
    [Sparrow.juggler addObject:tween];

}

-(void) recruitToBoardBought: (NSNotification*) notif{
    
    _wasBought = WAS_BOUGHT;
    
    GamePiece *piece = (GamePiece*) notif.object;
    
    _selectedPiece = piece;
    
    [_selectedPieceImage removeFromParent];
    
    _selectedPieceImage = [[SPImage alloc] initWithContentsOfFile:[_selectedPiece fileName]];
    _selectedPieceImage.x = 90;
    _selectedPieceImage.y = _rackZone.y - _selectedPieceImage.height;
    [_contents addChild:_selectedPieceImage];
    
    
}


-(void) recruitToBoardFree: (NSNotification*) notif{
    
    _wasBought = WAS_NOT_BOUGHT;
    
    GamePiece *piece = (GamePiece*) notif.object;
    
    if(piece == nil){
        NSLog(@"GOD DAMNNIT");
    }
    
    _selectedPiece = piece;
    
    [_selectedPieceImage removeFromParent];
    
    _selectedPieceImage = [[SPImage alloc] initWithContentsOfFile:[_selectedPiece fileName]];
    _selectedPieceImage.x = 90;
    _selectedPieceImage.y = _rackZone.y - _selectedPieceImage.height;
    [_contents addChild:_selectedPieceImage];
    
    
}

-(void) recruitThingsPhaseOver: (NSNotification*) notif{
    [self setPhase: MOVEMENT];
    [_stateText setText:@"Wait for your movement turn"];
}


-(void) yourTurnInMovement:(NSNotification*) notif{
    [self setPhase: MOVEMENT];
    [_stateText setText:@"Your turn to move"];
}


-(void) movementPhaseOver: (NSNotification*) notif{
    _canExplore = YES;
    [_stateText setText:@"State: Movement Phase Over"];
}

-(void) placementOver: (NSNotification*) notif{
    [_stateText setText:@"State: Wait to Place Creatures"];
    [self setPhase: MOVEMENT];
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
    [self setPhase: PLACEMENT];
    _placementStep = PLACE_FORT;
    [_stateText setText:@"State: Place fort"];
}

-(void) yourTurnCM: (NSNotification*) notif{
    [self setPhase:PLACEMENT];
    _placementStep = PLACE_CM_1;
    [_stateText setText:@"State: Place control marker"];

}

-(void) timeToPlaceFort: (NSNotification*) notif{
    [_stateText setText:@"State: wait to place fort"];

}

-(void) goldCollection: (NSNotification*) notif{
    PhaseType previousPhase = _phase;
    [self setPhase: GOLD];
    
    [_stateText setText:@"State: Gold Collection"];
    
    NSLog(@"Gold should appear");
    
    NSMutableDictionary *dic = notif.object;
    
    NSMutableDictionary *myGoldDic = [dic objectForKey:_state.myPlayerId];
    
    NSString *total = [[NSString alloc] initWithString:[NSString stringWithFormat:@"%@",[myGoldDic objectForKey:@"totalGold"]]];
    NSString *income = [[NSString alloc] initWithString:[NSString stringWithFormat:@"%@",[myGoldDic objectForKey:@"income"]]];
    
    
    NSString *username = [[[_state getMe] user] username];
    
    
    [[GoldCollection getInstance] setIncome:[NSString stringWithFormat:@"Income: %@", income]];
    [[GoldCollection getInstance] setTotal:[NSString stringWithFormat:@"Total Gold: %@", total]];
    [[GoldCollection getInstance] setUsername:username];
    
    [self refreshUserGold];
    
    if(previousPhase != COMBAT){
        [self showGoldCollection];
    }
}

-(void) collectedGold: (NSNotification*) notif{
    [[GoldCollection getInstance] removeFromParent];
    [_stateText setText:@"State: Collected Gold"];
    [[InGameServerAccess instance] goldCollectionPhaseDidCollectGold];
}

-(void) gameSetup: (NSNotification*) notif{
    
    [self setPhase: SETUP];
    
    [_stateText setText:@"State: Setup"];

    _state = (GameState*) notif.object;
    
    _canExplore = _state.isDemo;
    
    NSLog(@"%@", _state);
    
    NSString *myId = [_state myPlayerId];
    
    
    if ([myId isEqualToString:@"player1"]) {
        [_playerIdText setColor:SP_RED];
    } else if ([myId isEqualToString:@"player2"]) {
        [_playerIdText setColor:SP_YELLOW];
    } else if ([myId isEqualToString:@"player3"]) {
        [_playerIdText setColor:SP_GREEN];
    } else if ([myId isEqualToString:@"player4"]) {
        [_playerIdText setColor:SP_BLUE];
    }
    
    for(Player *p in _state.players){
        if ([p.playerId isEqualToString:@"player1"]) {
            _player1 = p;
        } else if ([p.playerId isEqualToString:@"player2"]) {
            _player2 = p;
        } else if ([p.playerId isEqualToString:@"player3"]) {
            _player3 = p;
        } else if ([p.playerId isEqualToString:@"player4"]) {
            _player4 = p;
        }

    }
    
    [self refreshUserGold];
    
    [_playerIdText setText:_state.myPlayerId];
    
    [_contents addChild:_playerIdText];

    
    [self drawTiles];
    
    [self drawRack];
    
    [[InGameServerAccess instance] setupPhaseReadyForPlacement];
    
    [Utils removeLoaderOnView:Sparrow.currentController.view animated:YES];
}

-(void) setupOver: (NSNotification*) notif{
    
    [self setPhase: PLACEMENT];
    
    [_stateText setText:@"State: Placement"];
    
}



-(void) pieceSelected: (NSNotification*) notif{
    
    Player *player;
    
    for(Player *p in _state.players){
        if ([p.playerId isEqualToString:_state.myPlayerId]) {
            player = p;
        }
    }
    
    
    if([notif.object isKindOfClass: [GamePiece class]]){
        GamePiece *piece = (GamePiece*) notif.object;
        if (piece != nil && [[piece owner] isEqual:player]) {
            _selectedPiece = piece;
            _selectedStack = nil;
            if(_selectedPieceImage != nil){
                [_selectedPieceImage removeFromParent];
            }
            _selectedPieceImage = [[SPImage alloc] initWithContentsOfFile:[_selectedPiece fileName]];
            _selectedPieceImage.x = 90;
            _selectedPieceImage.y = _rackZone.y - _selectedPieceImage.height;
            [_contents addChild:_selectedPieceImage];
            
            if ([piece.location isKindOfClass:[HexLocation class]] && ![piece isKindOfClass:[Fort class]]) {
                HexLocation *location = (HexLocation*) piece.location;
                [location hilightPossibleMoves];
            }
        }
        
    }else{
        Stack *stack = (Stack*)notif.object;
        if (stack != nil && [[stack owner] isEqual:player]) {
            _selectedPiece = nil;
            _selectedStack = stack;
            if(_selectedPieceImage != nil){
                [_selectedPieceImage removeFromParent];
            }
            if ([player.playerId isEqualToString:@"player1"]) {
                _selectedPieceImage = [[SPImage alloc] initWithContentsOfFile:@"red-stack.png"];
            } else if ([player.playerId isEqualToString:@"player2"]) {
                _selectedPieceImage = [[SPImage alloc] initWithContentsOfFile:@"yellow-stack.png"];
            } else if ([player.playerId isEqualToString:@"player3"]) {
                _selectedPieceImage = [[SPImage alloc] initWithContentsOfFile:@"green-stack.png"];
            } else if ([player.playerId isEqualToString:@"player4"]) {
                _selectedPieceImage = [[SPImage alloc] initWithContentsOfFile:@"blue-stack.png"];
            }
            _selectedPieceImage.x = 90;
            _selectedPieceImage.y = _rackZone.y - _selectedPieceImage.height;
            [_contents addChild:_selectedPieceImage];
            
            if ([stack.location isKindOfClass:[HexLocation class]]) {
                HexLocation *location = (HexLocation*) stack.location;
                [location hilightPossibleMoves];
            }
        }
    }
    
    [_selectedPieceImage addEventListener:@selector(clckedSelectedPiece:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    
        
    NSLog(@"Selected Piece");
    
   
}



-(void) startedRecruitThingsPhase: (NSNotification*) notif{
    [[RecruitCharacter getInstance] setVisible:NO];
    [[RecruitCharacter getInstance] removeAllChildren];
    [[RecruitCharacter getInstance] removeFromParent];
    
    [self setPhase: RECRUITMENT];
    
    NSArray *objectsToRecruit = notif.object;
    
    RecruitThings *rt = [RecruitThings getInstance];
    
    [rt removeFromParent];
    
    [rt initWithObjectsToRecruit: objectsToRecruit];
    
    [_phasesScreensContents addChild:rt];

    rt.visible = YES;
}

-(void) drawRack{
    Player *player = [_state getMe];
    
    Rack *rack1 = [player rack1];
    
    float rackX = _rackZone.x;
    float rackY = _rackZone.y;
    float prevX = 0;
    
    
    int i = 1;
    for (NSString *key in rack1.pieces) {
        if (i % 6 == 0) {
            rackY = rackY + 40;
            prevX = 0;
        }
        ScaledGamePiece *img = [[[GameResource getInstance] getPieceForId:key] pieceImage];
        img.scaleX = .5f;
        img.scaleY = .5f;
        img.x = rackX + prevX;
        img.y = rackY;
        prevX += img.width + 5;
        if(img != nil)
            [_contents addChild:img];
        i++;
        
        if(i > 10) {
            break;
        }
    }
    
    
}




-(void) drawTiles
{
    [GameBoardHelper populateHexLocationsFromFourPlayerGame:self is2Player:true fromGameState:_state withTouchSheet:_bottomLayerContents];
}


-(void) onTileClick: (SPTouchEvent*) event
{
   
    NSArray *touches = [[event touchesWithTarget:self andPhase:SPTouchPhaseBegan] allObjects];
    
    TileImage *img = (TileImage*) event.target;
    HexTile  *tile = (HexTile*) img.owner;
    HexLocation *location = (HexLocation*) tile.location;
    
    Player *player;
    
    for(Player *p in _state.players){
        if ([p.playerId isEqualToString:[_state myPlayerId]]) {
            player = p;
        }
    }
    
    switch (_phase) {
        case SETUP:
            break;
        case PLACEMENT:
            switch (_placementStep) {
                case PLACE_CM_1:
                    if (touches.count == 1)
                    {
                        if (![tile.terrain.terrainName isEqualToString:@"Sea"] && location.owner == nil && location.isStartingPoint) {
                            
                            SPTouch *clicks = [touches objectAtIndex:0];
                            
                            if (clicks.tapCount == 2){
                                NSLog(@"le double click");
                                [NSObject cancelPreviousPerformRequestsWithTarget:self];
                                [location changeOwnerToPlayer:player];
                                
                                placeHex1 = location.locationId;
                                
                                _placementStep = PLACE_CM_2;
                            }
                        }
                    }
                break;
                case PLACE_CM_2:
                    if (touches.count == 1)
                    {
                        if (![tile.terrain.terrainName isEqualToString:@"Sea"] && location.owner == nil && [location hasNeighbourOwnedByPlayer:player] ) {
                            
                            SPTouch *clicks = [touches objectAtIndex:0];

                            if (clicks.tapCount == 2){
                                NSLog(@"le double click");
                                [NSObject cancelPreviousPerformRequestsWithTarget:self];
                                [location changeOwnerToPlayer:player];

                                placeHex2 = location.locationId;
                                
                                _placementStep = PLACE_CM_3;
                            }
                        }
                    }
                    
                    break;
                case PLACE_CM_3:
                    if (touches.count == 1)
                    {
                        if (![tile.terrain.terrainName isEqualToString:@"Sea"] && location.owner == nil && [location hasNeighbourOwnedByPlayer:player] ) {
                            
                            SPTouch *clicks = [touches objectAtIndex:0];
                            
                            if (clicks.tapCount == 2){
                                NSLog(@"le double click");
                                [NSObject cancelPreviousPerformRequestsWithTarget:self];
                                
                                placeHex3 = location.locationId;
                                
                                [[InGameServerAccess instance] placementPhasePlaceControlMarkersFirst:placeHex1 second:placeHex2 third:placeHex3 withSuccess:^(ServerResponseMessage *message){
                                    dispatch_async(dispatch_get_main_queue(), ^{
                                        [location changeOwnerToPlayer:player];
                                    });
                                }];
                        
                            }
                        }
                    }
                    
                    break;
                case PLACE_FORT:
                    if (touches.count == 1)
                    {
                        if (![tile.terrain.terrainName isEqualToString:@"Sea"] && [tile.owner.playerId isEqualToString:[_state myPlayerId]]) {
                            
                            SPTouch *clicks = [touches objectAtIndex:0];
                            
                            if (clicks.tapCount == 1){
                                [self performSelector:@selector(tileSingleTapFort:) withObject:location afterDelay:0.15f];
                            } else if(clicks.tapCount == 2){
                                [NSObject cancelPreviousPerformRequestsWithTarget:self];
                                [self tileDoubleTap:location];
                            }
                            
                        }
                        
                    }
                    break;
            }
            break;
        case MOVEMENT:
            if (touches.count == 1)
            {
                    SPTouch *clicks = [touches objectAtIndex:0];
                    
                    //Make a UIAlert asking user if they want to move a stack or an individual creature
                    if (clicks.tapCount == 1){
                        if (![tile.terrain.terrainName isEqualToString:@"Sea"] && (tile.isHilighted || [tile.owner.playerId isEqualToString:[_state myPlayerId]]) && ![_selectedPiece isKindOfClass:[Fort class]] && ![_selectedPiece isKindOfClass:[SpecialIncomeCounters class]]) {
                            [self performSelector:@selector(tileSingleTap:) withObject:location afterDelay:0.15f];
                        }
                    } else if(clicks.tapCount == 2){
                        [NSObject cancelPreviousPerformRequestsWithTarget:self];
                        [self tileDoubleTap:location];
                    }
            }

            break;
        case RECRUITMENT:
            if (touches.count == 1)
            {
                if (![tile.terrain.terrainName isEqualToString:@"Sea"] && [tile.owner.playerId isEqualToString:[_state myPlayerId]]) {
                    //Make a UIAlert asking user if they want to move a stack or an individual creature
                    SPTouch *clicks = [touches objectAtIndex:0];
                    
                    if (clicks.tapCount == 1){
                        switch (_wasBought) {
                            case WAS_BOUGHT:
                                [self recruitWasBought:location];
                                break;
                            case WAS_NOT_BOUGHT:
                                [self recruitWasFree:location];
                            break;

                        }
                    }
                }
                
            }
            break;
        case CONSTRUCTION:
            if(touches.count == 1) {
                SPTouch *clicks = [touches objectAtIndex:0];
                if (clicks.tapCount == 1){
                    [self performSelector:@selector(tileSingleClickedInConstruction:) withObject:location afterDelay:0.15f];
                } else if(clicks.tapCount == 2){
                    [NSObject cancelPreviousPerformRequestsWithTarget:self];
                    [self tileDoubleTap:location];
                }
            }
            
            break;
        default:
            break;
    }
}

-(void) tileSingleClickedInConstruction: (HexLocation*) location{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"tileClickedInConstruction" object:location];
}

-(void) recruitWasFree:(HexLocation*) location{
    GamePiece *p = _selectedPiece;
    
    if(p==nil)
        return;
    
    if([location getPieceCountForPlayer:[_state getMe]] < 10){
        
        
        if ([[_state getMe] canSupportCreature:_selectedPiece atLocation:location]) {
            [UIAlertView displayAlertWithTitle:@"Bluff?"
                                       message:@"Place this piece as a bluff?"
                               leftButtonTitle:@"Bluff"
                              leftButtonAction:^{
                                  [[InGameServerAccess instance] recruitThingsPhaseRecruited:p.gamePieceId palcedOnLocation:location.locationId wasBought:NO withSuccess:^(ServerResponseMessage *message){
                                      dispatch_async(dispatch_get_main_queue(), ^{
                                          [location addGamePieceToLocation:p];
                                          [_state.getMe assignPiece:p];
                                          [self clearSelectedPiece:nil];
                                          [_selectedPieceImage removeFromParent];
                                          [[RecruitThings getInstance] setVisible:YES];
                                      });
                                  }];
                              }
                              rightButtonTitle:@"Not Bluff"
                             rightButtonAction:^{       [[InGameServerAccess instance] recruitThingsPhaseRecruited:p.gamePieceId palcedOnLocation:location.locationId wasBought:NO withSuccess:^(ServerResponseMessage *message){
                dispatch_async(dispatch_get_main_queue(), ^{
                    [location addGamePieceToLocation:p];
                    [_state.getMe assignPiece:p];
                    [self clearSelectedPiece:nil];
                    [_selectedPieceImage removeFromParent];
                    [[RecruitThings getInstance] setVisible:YES];
                });
            }];}];
        } else{
            [UIAlertView displayAlertWithTitle:@"Piece not supported"
                                       message:@"This piece may only be placed as a bluff."
                               leftButtonTitle:@"Place on rack"
                              leftButtonAction:^{
                                  [[[_state getMe] rack1] addGamePieceToLocation:p];
                                  [_state.getMe assignPiece:p];
                                  [self clearSelectedPiece:nil];
                                  [_selectedPieceImage removeFromParent];
                                  [[RecruitThings getInstance] setVisible:YES];
                              }
                              rightButtonTitle:@"Place as bluff"
                             rightButtonAction:^{  [[InGameServerAccess instance] recruitThingsPhaseRecruited:p.gamePieceId palcedOnLocation:location.locationId wasBought:NO withSuccess:^(ServerResponseMessage *message){
                dispatch_async(dispatch_get_main_queue(), ^{
                    [location addGamePieceToLocation:p];
                    [_state.getMe assignPiece:p];
                    [self clearSelectedPiece:nil];
                    [_selectedPieceImage removeFromParent];
                    [[RecruitThings getInstance] setVisible:YES];
                });
            }];}];
        }

        
        
        
        
  
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Too Many Pieces"
                                                        message:@"You may not exceed 10 of your own pieces on a hex."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    
    
}

-(void) recruitWasBought:(HexLocation*) location{
    GamePiece *p = _selectedPiece;
    
    if(p == nil)
        return;
    
    if([location getPieceCountForPlayer:[_state getMe]] < 10){
        if ([[_state getMe] canSupportCreature:_selectedPiece atLocation:location]) {
            [UIAlertView displayAlertWithTitle:@"Bluff?"
                                       message:@"Place this piece as a bluff?"
                               leftButtonTitle:@"Bluff"
                              leftButtonAction:^{
                                  [[InGameServerAccess instance] recruitThingsPhaseRecruited:p.gamePieceId palcedOnLocation:location.locationId wasBought:YES withSuccess:^(ServerResponseMessage *message){
                                      dispatch_async(dispatch_get_main_queue(), ^{
                                          [location addGamePieceToLocation:p];
                                          [_state.getMe assignPiece:p];
                                          [self clearSelectedPiece:nil];
                                          [_selectedPieceImage removeFromParent];
                                          [[RecruitThings getInstance] setVisible:YES];
                                      });
                                  }];
                              }
                              rightButtonTitle:@"Not Bluff"
                             rightButtonAction:^{       [[InGameServerAccess instance] recruitThingsPhaseRecruited:p.gamePieceId palcedOnLocation:location.locationId wasBought:YES withSuccess:^(ServerResponseMessage *message){
                dispatch_async(dispatch_get_main_queue(), ^{
                    [location addGamePieceToLocation:p];
                    [_state.getMe assignPiece:p];
                    [self clearSelectedPiece:nil];
                    [_selectedPieceImage removeFromParent];
                    [[RecruitThings getInstance] setVisible:YES];
                });
            }];}];
        } else{
            [UIAlertView displayAlertWithTitle:@"Piece not supported"
                                       message:@"This piece may only be placed as a bluff."
                               leftButtonTitle:@"place on rack"
                              leftButtonAction:^{
                                  [[[_state getMe] rack1] addGamePieceToLocation:p];
                                  [_state.getMe assignPiece:p];
                                  [self clearSelectedPiece:nil];
                                  [_selectedPieceImage removeFromParent];
                                  [[RecruitThings getInstance] setVisible:YES];
                              }
                              rightButtonTitle:@"Place as bluff"
                             rightButtonAction:^{  [[InGameServerAccess instance] recruitThingsPhaseRecruited:p.gamePieceId palcedOnLocation:location.locationId wasBought:YES withSuccess:^(ServerResponseMessage *message){
                dispatch_async(dispatch_get_main_queue(), ^{
                    [location addGamePieceToLocation:p];
                    [_state.getMe assignPiece:p];
                    [self clearSelectedPiece:nil];
                    [_selectedPieceImage removeFromParent];
                    [[RecruitThings getInstance] setVisible:YES];
                });
            }];}];
        }
        

    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Too Many Pieces"
                                                        message:@"You may not exceed 10 of your own pieces on a hex."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    
}

-(void) tileSingleTap: (HexLocation*) location{
    if (_selectedPiece != nil && ![_selectedPiece isKindOfClass:[RandomEvent class]] && ![_selectedPiece isKindOfClass:[NonCityVill class]]
        && ![_selectedPiece isKindOfClass:[MagicItems class]] && ![_selectedPiece isKindOfClass:[Treasure class]]) {
        if(([[_selectedPiece location] isKindOfClass:[Rack class]] || [[_selectedPiece location] isKindOfClass:[PlayingCup class]] ) && ![_selectedPiece isKindOfClass:[SpecialCharacter class]]){
            
            if ([[_state getMe] canSupportCreature:_selectedPiece atLocation:location]) {
                [UIAlertView displayAlertWithTitle:@"Bluff?"
                                           message:@"Place this piece as a bluff?"
                                   leftButtonTitle:@"Bluff"
                                  leftButtonAction:^{
                                      [[InGameServerAccess instance] movementPhaseMoveGamePiece:_selectedPiece.gamePieceId toLocation:location.locationId withSuccess:^(ServerResponseMessage *message){
                                          dispatch_async(dispatch_get_main_queue(), ^{
                                              [location addGamePieceToLocation:_selectedPiece];
                                              
                                              [self clearSelectedPiece:nil];
                                              [self unHilightAllTiles];
                                          });
                                      }];
                                  }
                                  rightButtonTitle:@"Not Bluff"
                                 rightButtonAction:^{  [[InGameServerAccess instance] movementPhaseMoveGamePiece:_selectedPiece.gamePieceId toLocation:location.locationId withSuccess:^(ServerResponseMessage *message){
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [location addGamePieceToLocation:_selectedPiece];
                        [self clearSelectedPiece:nil];
                        [self unHilightAllTiles];
                    });
                }];}];
            } else{
                [UIAlertView displayAlertWithTitle:@"Piece not supported"
                                           message:@"This piece may only be placed as a bluff."
                                   leftButtonTitle:@"Do not place"
                                  leftButtonAction:^{
                                  }
                                  rightButtonTitle:@"Place as bluff"
                                 rightButtonAction:^{  [[InGameServerAccess instance] movementPhaseMoveGamePiece:_selectedPiece.gamePieceId toLocation:location.locationId withSuccess:^(ServerResponseMessage *message){
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [location addGamePieceToLocation:_selectedPiece];
                        [self clearSelectedPiece:nil];
                        [self unHilightAllTiles];
                    });
                }];}];
            }
            
        }else{
            [self movePiece:_selectedPiece orStack:nil toHexLocation:location];
        }
    } else if (_selectedStack != nil) {
        [self movePiece:nil orStack:_selectedStack toHexLocation:location];
    }
}


/**
 This does the actual moving of a piece or a stack.  You can give it either a stack or a piece to move, or both.  I seperated
 the code into blocks so that as we add logic we don't have to duplicate
 */
-(void) movePiece: (GamePiece*) piece orStack: (Stack*) stack toHexLocation: (HexLocation*) location {
    BOOL isExploring = NO;
    
    if(location.owner == nil) {
        isExploring = YES;
    }
    
    if (!_canExplore && isExploring) {
        NSLog(@"YOU CANT DO THAT");
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Not Allowed" message:@"You can't explore in the placement phase" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        
        [alert show];
        return;
        
    }
    
    void (^performAfterExploring)(ServerResponseMessage * message) = ^(ServerResponseMessage *message){
        [self didGetResponseForServerForExploring: message forLocation:location];
    };
    
    void (^performAlwaysOnSuccess)(ServerResponseMessage * message) = ^(ServerResponseMessage *message){
        [self clearSelectedPiece:nil];
        [self unHilightAllTiles];
        
        if(isExploring) {
            performAfterExploring(message);
        }
    };
    
    void (^performForGamePieceAfterSuccess)(ServerResponseMessage * message) = ^(ServerResponseMessage *message){
        dispatch_async(dispatch_get_main_queue(), ^{
            [location addGamePieceToLocation:piece];
            performAlwaysOnSuccess(message);
        });
    };
    
    void (^performForStackAfterSuccess)(ServerResponseMessage * message) = ^(ServerResponseMessage *message){
        dispatch_async(dispatch_get_main_queue(), ^{
            [location addStack:stack];
            performAlwaysOnSuccess(message);
        });
    };
    

    
    
    if(piece != nil) {
        if( ! isExploring ) {
            if([location getPieceCountForPlayer:[_state getMe]] < 10){
                [[InGameServerAccess instance] movementPhaseMoveGamePiece:piece.gamePieceId toLocation:location.locationId withSuccess:performForGamePieceAfterSuccess];
            }else{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Too Many Pieces"
                                                                message:@"You may not exceed 10 of your own pieces on a hex."
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
                [alert show];
            }
        } else{
            [[InGameServerAccess instance] movementPhaseExploreHex:location.locationId withStack:nil andPiece:piece.gamePieceId withSuccess:performForGamePieceAfterSuccess];
            
        }
    }
    
    if(stack != nil) {
        if( ! isExploring ) {
            if([location getPieceCountForPlayer:[_state getMe]] + stack.pieces.count <= 10){
                [[InGameServerAccess instance] movementPhaseMoveStack:stack.locationId toHex:location.locationId withSuccess: performForStackAfterSuccess];
            }else{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Too Many Pieces"
                                                                message:@"You may not exceed 10 of your own pieces on a hex."
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
                [alert show];
            }
        } else {
       
            [[InGameServerAccess instance] movementPhaseExploreHex:location.locationId withStack:stack.locationId andPiece:nil withSuccess:performForStackAfterSuccess];
            
        }
    }
}

-(void) didGetResponseForServerForExploring: (ServerResponseMessage*) message forLocation: (HexLocation*) location {
    NSLog(@"Got response from server when exploring");
    
    NSDictionary *map = message.data.map;
    BOOL didCapture = [[map objectForKey:@"didCapture"] boolValue];
    NSArray *defendingPieceIds = [map objectForKey:@"defendingPieceIds"];
    
    if(didCapture) {
        [_state.game addLogMessage:[NSString stringWithFormat:@"There were no creatures found on %@.  You captured it!", location.locationName]];
    } else{
        [_state.game addLogMessage:[NSString stringWithFormat:@"%ld wild creatures were found on %@.  You will need to battle them during the combat phase!", (unsigned long)defendingPieceIds.count, location.locationName]];
    }
}

-(void) tileSingleTapFort: (HexLocation*) location{
    if(_selectedPiece != nil && [_selectedPiece isKindOfClass:[Fort class]]){
        [[InGameServerAccess instance] placementPhasePlaceFort:location.locationId withSuccess:^(ServerResponseMessage *message){
            dispatch_async(dispatch_get_main_queue(), ^{
                [location addGamePieceToLocation:_selectedPiece];
                [self clearSelectedPiece:nil];
            });
        }];
    }
}

-(void) tileDoubleTap: (HexLocation*) location{
    if([location.tile.terrain.terrainName isEqualToString:@"Sea"])
        return;
    
    TileMenu *tileMenu = [[TileMenu alloc] initWithHexLocation:location];
    [self showScene:tileMenu];
    tileMenu.visible = YES;
}



-(void) showScene:(SPSprite *)scene
{
    [self addChild:scene];
    scene.visible = YES;
    [_stateText setText:@"State:  Wait..."];
}

-(void) playerMovedPieceToNewLocation: (NSNotification*) notif{
    GamePiece* piece = (GamePiece*) notif.object;
    NSLog(@"Got notif for gamepiece moved with id %@", piece.gamePieceId);
}

-(void) moveDone:(SPTouchEvent*)event {
    [[InGameServerAccess instance] movementPhaseDoneMakingMoves];
    moveDoneButton.visible = NO;
}

-(void) yourTurnToMoveInMovement : (NSNotification*) notif{
    moveDoneButton.visible = YES;
    [_stateText setText:@"State:  Your turn"];
}

-(void) clearSelectedPiece:(NSNotification*) notif{
    [self unHilightAllTiles];
    [_selectedPieceImage setVisible:NO];
    [_contents removeChild:_selectedPieceImage];
    _selectedPiece = nil;
    _selectedStack = nil;
}

-(void) dealloc{
    //Unsubscribe from notifications, ARC doesn't do this for us
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void) didStartRecruitCharactersPhase: (NSNotification*) notif{
    
    [self setPhase: SC_RECRUITMENT];
    
    RecruitCharacter *rt = [RecruitCharacter getInstance];
    [rt setFourPlayerGame:self];
    [rt setup];
    
    [_phasesScreensContents addChild:rt];
    
    [rt setVisible:YES];
    
    
}

-(void) unHilightAllTiles{
    for (NSString *location in _state.hexLocations) {
        [[[_state.hexLocations objectForKey:location] tile] unhilight];
    }
}

-(void) addChildToContents: (SPDisplayObject*) sprite{
    [_contents addChild:sprite];
}

-(void) addChildToPhasesContent: (SPDisplayObject*) sprite{
    [_phasesScreensContents addChild:sprite];
}

-(void) setPhase: (PhaseType) phase{
    _phase = phase;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"newPhaseStarted" object:self];
}
-(PhaseType) getPhase{
    return _phase;
}

-(void) reinitializeCombatScreenAndShowGold{
    [_combatPhaseController reinitializeForFourPlayerGame: self];
    [self startConstruction];
}

-(void) showGoldCollection{
    [[GoldCollection getInstance]  removeFromParent];
    [self addChild:[GoldCollection getInstance]];
    [[GoldCollection getInstance] setVisible:YES];
}


-(void) refreshUserGold{
    for(Player *p in _state.players){
        if ([p.playerId isEqualToString:@"player1"]) {
            [ _Player1IncomeText setText:[NSString stringWithFormat:@"%d", p.gold]];
            
        } else  if ([p.playerId isEqualToString:@"player2"]) {
            [ _Player2IncomeText setText:[NSString stringWithFormat:@"%d", p.gold]];
            
        } else  if ([p.playerId isEqualToString:@"player3"]) {
            [ _Player3IncomeText setText:[NSString stringWithFormat:@"%d", p.gold]];
            
        } else  if ([p.playerId isEqualToString:@"player4"]) {
            [ _Player4IncomeText setText:[NSString stringWithFormat:@"%d", p.gold]];
        }
    }
    
    int size  = (int)_state.players.count;
    if(size < 4) {
        [_Player4IncomeText removeFromParent];
        [_Player4LabelText removeFromParent];
    } else{
        [_contents addChild:_Player4IncomeText];
        [_contents addChild:_Player4LabelText];
    }
    if(size <3) {
        [_Player3IncomeText removeFromParent];
        [_Player3LabelText removeFromParent];
    } else{
        [_contents addChild:_Player3IncomeText];
        [_contents addChild:_Player3LabelText];
    }
    if(size <2) {
        [_Player2IncomeText removeFromParent];
        [_Player2LabelText removeFromParent];
    } else{
        [_contents addChild:_Player2IncomeText];
        [_contents addChild:_Player2LabelText];
    }
}


-(void) playerGoldChanged: (NSNotification*) notif{
    [self refreshUserGold];
}

static RackPiecesMenu *rackMenu;
-(void) expandRack: (SPEvent*) e{
    Player* me  = [_state getMe];
    BoardLocation *bl = me.rack1;
    
    
    if(rackMenu == nil)
        rackMenu = [[RackPiecesMenu alloc] initForPlayer:me onLocation:bl withParent:self andIsOpposingPlayer:NO];
    else{
        [rackMenu hide];
        [rackMenu setup];
    }
    
    
    [rackMenu show];
}

-(void) rackUpdated: (NSNotification*) notif{
    [self drawRack];
}

-(void) constructionStarted: (NSNotification*) notif{
    cMenu = [[ConstructionMenu alloc] initFromParent:self];
    [self setPhase:CONSTRUCTION];
}

-(void) startConstruction{
    [_stateText setText:@"Construction"];
    NSLog(@"Started construction");
    [cMenu show];
}

-(void) clckedSelectedPiece: (SPTouchEvent*) event{
    NSArray *touches = [[event touchesWithTarget:self andPhase:SPTouchPhaseBegan] allObjects];
    if(touches.count == 1) {
        [self clearSelectedPiece:nil];
    }
}

-(void) playerWon:(NSNotification*) notif{
    Player *winner = (Player*) notif.object;
    [_contents removeFromParent];
    [_phasesScreensContents removeFromParent];
    
    WinningScreen* winningScreen = [[WinningScreen alloc] initFromParent:_winningContents withWinner:winner];
    [winningScreen show];
}

-(void) gameOver: (NSNotification*) notif {
    [_contents removeAllChildren];
    [_phasesScreensContents removeAllChildren];
    [_winningContents removeAllChildren];
}

-(void) randomEventsStarted: (NSNotification*) notif{
    RandomEventsMenu *menu = [[RandomEventsMenu alloc] initFromParent:_phasesScreensContents];
    [menu show];
}

-(void) movePieceImage: (NSNotification*) notif{
    GamePiece *piece = (GamePiece*) notif.object;
    
    SPTween *tween = [SPTween tweenWithTarget:piece.pieceImage time:0.25f
                                   transition:SP_TRANSITION_LINEAR];
    
    
    int x = [GameBoardHelper getXValueForHexLocation:(HexLocation*)piece.location];
    int y = [GameBoardHelper getYValueForHexLocation:(HexLocation*)piece.location];
    
    [tween animateProperty:@"x" targetValue:x + 10];
    [tween animateProperty:@"y" targetValue:y + 10];
    [tween animateProperty:@"scaleX" targetValue:0.3f];
    [tween animateProperty:@"scaleY" targetValue:0.3f];
    
    [Sparrow.juggler addObject:tween];
    
    [_contents addChild:piece.pieceImage];
}

-(void) moveStackImage:(NSNotification*) notif{
    Stack* stack = (Stack*) notif.object;
    
    SPTween *tween = [SPTween tweenWithTarget:stack.stackImage time:0.25f
                                   transition:SP_TRANSITION_LINEAR];
    
    int x = [GameBoardHelper getXValueForHexLocation:(HexLocation*)stack.location];
    int y = [GameBoardHelper getYValueForHexLocation:(HexLocation*)stack.location];
    
    [tween animateProperty:@"x" targetValue:x +10];
    [tween animateProperty:@"y" targetValue:y +10];
    [tween animateProperty:@"scaleX" targetValue:0.3f];
    [tween animateProperty:@"scaleY" targetValue:0.3f];
    
    [Sparrow.juggler addObject:tween];
    
    [_contents addChild:stack.stackImage];
    
}

@end
