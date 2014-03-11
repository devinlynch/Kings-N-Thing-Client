//
//  RecruitOptionMenu.m
//  3004iPhone
//
//  Created by Richard Ison on 2/3/2014.
//
//

#import "RecruitOptionMenu.h"
#import "RecruitThings.h"
#import "GameBoard.h"
#import "GamePiece.h"
#import "Game.h"
#import "GameState.h"
#import "InGameServerAccess.h"
#import "Rack.h"

@implementation RecruitOptionMenu{
    
    SPSprite *_contents;
    SPSprite *_currentScene;
    
    int _gameWidth;
    int _gameHeight;
    
    
}
@synthesize gamePiece, isBuy;

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
    
    _contents = [SPSprite sprite];
    [self addChild:_contents];
    
    int offset = 10;
    
    
    SPImage *background = [[SPImage alloc] initWithContentsOfFile:@"RecruitThingsBackground@2x.png"];
    
    //necessary or else it gets placed off screen
    background.x = 0;
    background.y = -60;
    
    background.blendMode = SP_BLEND_MODE_NONE;
    [_contents addChild:background];
    
    //Text
    SPTextField *welcomeTF = [SPTextField textFieldWithWidth:300 height:120
                                                        text:@"Username"];
    welcomeTF.x = welcomeTF.y = offset;
    welcomeTF.fontName = @"ArialMT";
    welcomeTF.fontSize = 25;
    welcomeTF.color = 0xffffff;
    [_contents addChild:welcomeTF];
    
    
    //Button
    SPTexture *buttonTexture = [SPTexture textureWithContentsOfFile:@"board.png"];
    SPButton * button = [SPButton buttonWithUpState:buttonTexture];
    
    button.x = 320 / 2 - button.width /2;
    button.y = 35 + 170;
    
    [_contents addChild:button];
    
    [button addEventListener:@selector(placeOnBoard:) atObject:self forType:SP_EVENT_TYPE_TRIGGERED];
    
    
    //Button
    
    SPTexture *buttonTexture2 = [SPTexture textureWithContentsOfFile:@"rackbtn.png"];
    SPButton * button2 = [SPButton buttonWithUpState:buttonTexture2];
    
    button2.x = 320 / 2 - button2.width /2;
    button2.y = 110 + 170;
    
    [_contents addChild:button2];
    
    [button2 addEventListener:@selector(placeOnRack:) atObject:self forType:SP_EVENT_TYPE_TRIGGERED];
    
    
    
    
    SPTexture *buttonTexture3 = [SPTexture textureWithContentsOfFile:@"back.png"];
    SPButton * button3 = [SPButton buttonWithUpState:buttonTexture3];
    
    button3.x = 320 / 2 - button2.width /2;
    button3.y = 410;
    
    [_contents addChild:button3];
    
    [button3 addEventListener:@selector(onButtonTriggered:) atObject:self forType:SP_EVENT_TYPE_TRIGGERED];
    
    
    
}


- (void)showScene:(SPSprite *)scene {
    
    [self addChild:scene];
    scene.visible = YES;
}

-(void) placeOnBoard: (SPEvent *) event
{
    NSLog(@"Go to board");
    
    if (isBuy) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"recruitToBoardBought" object:gamePiece];
    }else{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"recruitToBoardFree" object:gamePiece];
    }
    
    
    [[RecruitThings getInstance] setVisible:NO];
    _contents.visible = NO;
    
}

-(void) placeOnRack: (SPEvent *) event
{
    NSLog(@"Placed gamePieceId %@ in the rack", gamePiece.gamePieceId);
    GameState *gs = [[Game currentGame] gameState];
    Player *me = [gs getPlayerById:[gs myPlayerId]];
    [[me rack2] addGamePieceToLocation:gamePiece];
   // [gs addLogMessage: @"You added the game piece to your rack."];
    
    NSString *rackId = [[me rack2] locationId];
    
    [[InGameServerAccess instance] recruitThingsPhaseRecruited:gamePiece.gamePieceId palcedOnLocation:rackId wasBought:isBuy];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"addToRack" object:nil];
    
    _contents.visible = NO;
}

-(void) onButtonTriggered: (SPEvent *) event
{
    NSLog(@"Back to recruit things");
    //    GameMenu *gameMenu = [[GameMenu alloc] init];
    //    [self showScene:gameMenu];
    _contents.visible = NO;
    
}

@end
