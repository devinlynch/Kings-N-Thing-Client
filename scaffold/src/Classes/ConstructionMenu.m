//
//  ConstructionMenu.m
//  3004iPhone
//
//  Created by Richard Ison on 2014-03-18.
//
//

#import "ConstructionMenu.h"
#import "Game.h"
#import "GameState.h"
#import "Player.h"
#import "InGameServerAccess.h"
#import "Fort.h"

@implementation ConstructionMenu
{
    SPButton *upgradeButton;
    SPButton *buildButton;
    SPButton *skipButton;
    SPTextField *actionText;
    ConstructionState state;
    Fort *selectedFort;
}

-(id) init
{
    if ((self = [super initFromParent:nil]))
    {
        [self setup];
    }
    
    return self;
}

-(id) initFromParent:(SPSprite *)parent
{
    if ((self = [super initFromParent:parent]))
    {
        [self setup];
    }
    
    return self;
}



-(void) setup{
    [super setup];
    
    state= CS_WAITING;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(tileClickedInConstruction:)
                                                 name:@"tileClickedInConstruction"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(pieceSelected:)
                                                 name:@"pieceSelected"
                                               object:nil];
    
    
    SPImage *background = [[SPImage alloc] initWithContentsOfFile:@"construc@2x.png"];
    
    //necessary or else it gets placed off screen
    background.x = 0;
    background.y = 420;
    background.height = _gameHeight - 420;
    
    [_contents addChild:background];
    
    
    //Upgrade Button
    SPTexture *upgradeButtonTexture = [SPTexture textureWithContentsOfFile:@"upgrade.png"];
    upgradeButton = [SPButton buttonWithUpState:upgradeButtonTexture];
    upgradeButton.x = 0;
    upgradeButton.y = 520;
    upgradeButton.scaleX = upgradeButton.scaleY = 0.5;
    [_contents addChild:upgradeButton];
    [upgradeButton addEventListener:@selector(didClickOnUpgrade:) atObject:self forType:SP_EVENT_TYPE_TRIGGERED];
    upgradeButton.enabled = NO;
    
    //Build button
    SPTexture *buildButtonTexture = [SPTexture textureWithContentsOfFile:@"build.png"];
    buildButton = [SPButton buttonWithUpState:buildButtonTexture];
    buildButton.x = _gameWidth - buildButton.width + 100;
    buildButton.y = 520;
    buildButton.scaleX = buildButton.scaleY = 0.5;
    [_contents addChild:buildButton];
    [buildButton addEventListener:@selector(didClickOnBuild:) atObject:self forType:SP_EVENT_TYPE_TRIGGERED];
    
    
    //Skip Button
    SPTexture *skipButtonTexture = [SPTexture textureWithContentsOfFile:@"skip.png"];
    skipButton = [SPButton buttonWithUpState:skipButtonTexture];
    skipButton.x = _gameWidth /2 - upgradeButton.width/2 + 50;
    skipButton.y = 520;
    skipButton.scaleX = skipButton.scaleY = 0.5;
    [_contents addChild:skipButton];
    [skipButton addEventListener:@selector(didClickOnSkip:) atObject:self forType:SP_EVENT_TYPE_TRIGGERED];
    
    
    SPTextField *welcomeText = [SPTextField textFieldWithWidth:300 height:50
                                                         text:[NSString stringWithFormat: @"Welcome to the construction phase.  You are able to either build or upgrade your forts."]];
    welcomeText.x = 10;
    welcomeText.y = 420;
    welcomeText.fontName = @"ArialMT";
    welcomeText.fontSize = 11;
    welcomeText.color = 0xffffff;
    welcomeText.touchable = NO;
    [_contents addChild:welcomeText];
    
    actionText = [SPTextField textFieldWithWidth:300 height:50
                                                         text:[NSString stringWithFormat: @"Please choose the location where you would like to build the fort."]];
    actionText.x = 10;
    actionText.y = 470;
    actionText.fontName = @"ArialMT";
    actionText.fontSize = 11;
    actionText.color = 0xffffff;
    actionText.touchable = NO;
    [_contents addChild:actionText];
}

- (void) didClickOnBuild:(SPEvent *) event{
    NSLog(@"Clicked build");
    Player *me = [[[Game currentGame] gameState] getMe];
    int myGold = me.gold;
    
    if(myGold < 5) {
        [Utils showAlertWithTitle:@"Whoops" message:@"You do not have enough gold to build a fort." delegate:nil cancelButtonTitle:@"Ok"];
        return;
    }
    
    selectedFort = nil;
    
    state = CS_BUYING;
    [actionText setText:@"Please select a location to place the fort"];
}

- (void) didClickOnSkip:(SPEvent *) event{
    NSLog(@"Clicked skip");
    [[InGameServerAccess instance] constructionReadyForNextPhaseWithSuccess:^(ServerResponseMessage* messge) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self hide];
        });
    }];
}

-(void) tileClickedInConstruction: (NSNotification*) notif{
    if(state == CS_BUYING) {
        Player *me = [[[Game currentGame] gameState] getMe];
        HexLocation *loc = notif.object;
        if(loc.owner == me) {
            [self buyFortOnLocation: loc];
        } else{
            [Utils showAlertWithTitle:@"Whoops" message:@"You cannot buy a fort on a location you do not own." delegate:nil cancelButtonTitle:@"Ok"];
        }
    }
}

-(void) buyFortOnLocation: (HexLocation*) loc{
    [[InGameServerAccess instance] constructionBuiltFortOnHex:loc.locationId withSuccess:^(ServerResponseMessage* messge) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"Successfully built fort");
            if(state == CS_BUYING) {
                state = CS_WAITING;
                [actionText setText:@""];
            }
            [[NSNotificationCenter defaultCenter] postNotificationName:@"clearSelectedPiece" object:nil];
        });
    } andError:^(ServerResponseMessage* messge) {
         NSLog(@"Error building fort");
        [Utils showAlertWithTitle:@"Whoops" message:@"You cannot move a fort there.  Please try again." delegate:nil cancelButtonTitle:@"Ok"];
    }];
}


-(void) pieceSelected: (NSNotification*) notif{
    GamePiece *piece = notif.object;
    if(piece == nil || ! [piece isKindOfClass:[Fort class]]) {
        selectedFort = nil;
        upgradeButton.enabled = NO;
        return;
    }
    
    [actionText setText:@""];
    state = CS_UPGRADING;
    selectedFort = (Fort*) piece;
    upgradeButton.enabled = YES;
}

- (void) didClickOnUpgrade:(SPEvent *) event{
    if(state==CS_UPGRADING && selectedFort != nil) {
        [[InGameServerAccess instance] constructionUpgradedFort:selectedFort.gamePieceId withSuccess:^(ServerResponseMessage* messge) {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"Successfully upgraded fort");
                if(state == CS_UPGRADING) {
                    state = CS_WAITING;
                    [actionText setText:@""];
                }
                [[NSNotificationCenter defaultCenter] postNotificationName:@"clearSelectedPiece" object:nil];
            });
        } andError:^(ServerResponseMessage* messge) {
            NSLog(@"Error upgrading fort");
            [Utils showAlertWithTitle:@"Whoops" message:@"You cannot upgrade this fort." delegate:nil cancelButtonTitle:@"Ok"];
        }];
    }
}

-(void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
