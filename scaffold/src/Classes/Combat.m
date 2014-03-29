//
//  Combat.m
//  3004iPhone
//
//  Created by Richard Ison on 2/3/2014.
//
//

#import "Combat.h"
#import "ScaledGamePiece.h"
//#import "GameMenu.h"

@implementation Combat{
    SPSprite *_contents;
    SPSprite *_currentScene;
    SPSprite *_tileMenu;
    
    ScaledGamePiece *_swamp_065;
    ScaledGamePiece *_swamp_066;
    ScaledGamePiece *_swamp_067;
    ScaledGamePiece *_swamp_068;
    ScaledGamePiece *_swamp_069;
    ScaledGamePiece *_swamp_070;
    ScaledGamePiece *_swamp_071;
    ScaledGamePiece *_swamp_072;
    ScaledGamePiece *_swamp_073;
    ScaledGamePiece *_swamp_074;
    
    SPTextField *_player1;
    SPTextField *_player2;
    
    SPTextField *_hitValuePlayer1;
    SPTextField *_hitValuePlayer2;
    
    NSString *changeBackground;
    
}

@synthesize typeOfBackground;

- (id)init
{
    if ((self = [super init]))
    {
        [self setup];
    }
    return self;
}


- (void) setup {
    
    int _yOffset = 15;
    _contents = [SPSprite sprite];
    [self addChild:_contents];
    
    //Change depending on what tile was clicked before combat phase
    
    typeOfBackground = @"swamp";
    
    
    if ([typeOfBackground isEqualToString:@"swamp"]){
        
        changeBackground = @"swamp-tile-menu@2x.png";
        
    } else if ([typeOfBackground isEqualToString:@"jungle"]){
        
        changeBackground = @"jungle-tile-menu@2x.png";
    
    } else if ([typeOfBackground isEqualToString:@"desert"]){
        
        changeBackground = @"desert-tile-menu@2x.png";

    } else if ([typeOfBackground isEqualToString:@"frozen"]){
        
        changeBackground = @"frozen-tile-menu@2x.png";
        
    } else if ([typeOfBackground isEqualToString:@"mountain"]){
        
        changeBackground = @"mountain-tile-menu@2x.png";

    } else if ([typeOfBackground isEqualToString:@"plain"]){
        
        changeBackground = @"plain-tile-menu@2x.png";
        
    } else if ([typeOfBackground isEqualToString:@"forest"]){
        
        changeBackground = @"forest-tile-menu@2x.png";
    }
        
    
    
    SPImage *background = [[SPImage alloc] initWithContentsOfFile:changeBackground];
    
    [_contents addChild:background];
    
    //Test: adding swamp cards
    
    //Player 1
    [self scaleImage:_swamp_065 fileName:@"T_Swamp_065.png" addParent:_contents setX:5 setY:50 + _yOffset];
    [self scaleImage:_swamp_066 fileName:@"T_Swamp_066.png" addParent:_contents setX:5 setY:95+ _yOffset];
    [self scaleImage:_swamp_067 fileName:@"T_Swamp_067.png" addParent:_contents setX:5 setY:140+ _yOffset];
    [self scaleImage:_swamp_068 fileName:@"T_Swamp_068.png" addParent:_contents setX:5 setY:185+ _yOffset];
    [self scaleImage:_swamp_069 fileName:@"T_Swamp_069.png" addParent:_contents setX:5 setY:230+ _yOffset];
    [self scaleImage:_swamp_069 fileName:@"T_Swamp_070.png" addParent:_contents setX:5 setY:275+ _yOffset];
    [self scaleImage:_swamp_070 fileName:@"T_Swamp_071.png" addParent:_contents setX:5 setY:320+ _yOffset];
    [self scaleImage:_swamp_071 fileName:@"T_Swamp_072.png" addParent:_contents setX:5 setY:365+ _yOffset];
    [self scaleImage:_swamp_072 fileName:@"T_Swamp_073.png" addParent:_contents setX:5 setY:410+ _yOffset];
    [self scaleImage:_swamp_073 fileName:@"T_Swamp_074.png" addParent:_contents setX:5 setY:455+ _yOffset];
    
    
    
    //Player 2
    [self scaleImage:_swamp_065 fileName:@"T_Swamp_065.png" addParent:_contents setX:270 setY:50+ _yOffset];
    [self scaleImage:_swamp_066 fileName:@"T_Swamp_066.png" addParent:_contents setX:270 setY:95+ _yOffset];
    [self scaleImage:_swamp_067 fileName:@"T_Swamp_067.png" addParent:_contents setX:270 setY:140+ _yOffset];
    [self scaleImage:_swamp_068 fileName:@"T_Swamp_068.png" addParent:_contents setX:270 setY:185+ _yOffset];
    [self scaleImage:_swamp_069 fileName:@"T_Swamp_069.png" addParent:_contents setX:270 setY:230+ _yOffset];
    [self scaleImage:_swamp_069 fileName:@"T_Swamp_070.png" addParent:_contents setX:270 setY:275+ _yOffset];
    [self scaleImage:_swamp_070 fileName:@"T_Swamp_071.png" addParent:_contents setX:270 setY:320+ _yOffset];
    [self scaleImage:_swamp_071 fileName:@"T_Swamp_072.png" addParent:_contents setX:270 setY:365+ _yOffset];
    [self scaleImage:_swamp_072 fileName:@"T_Swamp_073.png" addParent:_contents setX:270 setY:410+ _yOffset];
    [self scaleImage:_swamp_073 fileName:@"T_Swamp_074.png" addParent:_contents setX:270 setY:455+ _yOffset];

   
    
    //Rolllll
    SPTexture *buttonTexture = [SPTexture textureWithContentsOfFile:@"rolldice.png"];
    SPButton * button = [SPButton buttonWithUpState:buttonTexture];
    button.x = 320 / 2 - button.width /2;
    button.y = 320;
    [_contents addChild:button];
    [button addEventListener:@selector(onRollDice:) atObject:self forType:SP_EVENT_TYPE_TRIGGERED];
    
    
    //Retread
    SPTexture *retreatTexture = [SPTexture textureWithContentsOfFile:@"retreat.png"];
    SPButton * retreatButton = [SPButton buttonWithUpState:retreatTexture];
    retreatButton.x = 320 / 2 - retreatButton.width /2;
    retreatButton.y = 410;
    [_contents addChild:retreatButton];
    [retreatButton addEventListener:@selector(onRetreat:) atObject:self forType:SP_EVENT_TYPE_TRIGGERED];
    
    
    //Player1 text
    _player1 = [SPTextField textFieldWithWidth:90 height:30 text:@"Hits: 0"];
    _player1.x = -10;
    _player1.y = 30;
    _player1.fontSize = 20;
    _player1.color = SP_RED;
    [_contents addChild:_player1];
    
    //Player2 text
    _player2 = [SPTextField textFieldWithWidth:90 height:30 text:@"Hits: 0"];
    _player2.x = 240;
    _player2.y = 30;
    _player2.fontSize = 20;
    _player2.color = SP_YELLOW;
    [_contents addChild:_player2];
    
    
    //Player1 hit text
    _hitValuePlayer1 = [SPTextField textFieldWithWidth:90 height:30 text:@"Player1"];
    _hitValuePlayer1.x = -10;
    _hitValuePlayer1.y = 10;
    _hitValuePlayer1.fontSize = 20;
    _hitValuePlayer1.color = SP_RED;
    [_contents addChild:_hitValuePlayer1];
    
    //Player2 hit text
    _hitValuePlayer2 = [SPTextField textFieldWithWidth:90 height:30 text:@"Player2"];
    _hitValuePlayer2.x = 240;
    _hitValuePlayer2.y = 10;
     _hitValuePlayer2.fontSize = 20;
    _hitValuePlayer2.color = SP_YELLOW;
    [_contents addChild:_hitValuePlayer2];
    
    
    
    
    
}

- (void) scaleImage:(ScaledGamePiece*)image fileName:(NSString*) file addParent:(SPSprite*) add setX:(float)posX setY:(float)posY{
    
    image = [[ScaledGamePiece alloc]initWithContentsOfFile:file];
    image.scaleX = 0.7f;
    image.scaleY = 0.7f;
    image.x = posX;
    image.y = posY;
    [add addChild:image];
}



- (void)onRollDice:(SPEvent *)event
{
    //Roll dice
   
}



- (void)onRetreat:(SPEvent *)event
{
    //Retreat
    
}


- (void)showScene:(SPSprite *)scene {
    
    
    _currentScene.visible = NO;
    _currentScene = scene;
    scene.visible = YES;
}

@end
