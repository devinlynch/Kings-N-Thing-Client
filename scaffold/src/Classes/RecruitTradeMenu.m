//
//  RecruitTradeMenu.m
//  3004iPhone
//
//  Created by Devin Lynch on 2014-04-06.
//
//

#import "RecruitTradeMenu.h"
#import "Player.h"
#import "InGameServerAccess.h"
#import "GamePiece.h"
#import "Game.h"
#import "RecruitThings.h"
#import "PlayingCup.h"

@implementation RecruitTradeMenu
{
    NSMutableArray *_possibleRecruits;
    SPButton *tradeButton;
}

-(id) initWithPossibleTrades: (NSArray*) trades andPlayer: (Player*) player andParent: (RecruitThings*) parent{
    self = [super initFromParent:parent];
    if(self) {
        _player = player;
        _location = player.rack1;
        _possibleRecruits = [NSMutableArray arrayWithArray:trades];
        [self setup];
    }
    return self;
}

-(id) init{
    self = [super init];
    if(self) {
        [self setup];
    }
    return self;
}


-(void) setup{
    [super setup];
    
    
    //Done Button
    SPTexture *skipButtonTexture = [SPTexture textureWithContentsOfFile:@"trade.png"];
    tradeButton = [SPButton buttonWithUpState:skipButtonTexture];
    tradeButton.x = _gameWidth /2 - tradeButton.width/2 + 50;
    tradeButton.y = 440;
    tradeButton.scaleX = tradeButton.scaleY = 0.5;
    [_contents addChild:tradeButton];
    [tradeButton addEventListener:@selector(didClickOnTrade:) atObject:self forType:SP_EVENT_TYPE_TRIGGERED];
    tradeButton.enabled = NO;
    
}

-(void) didClickOnRecruit:(SPEvent *) event{
    [super didClickOnRecruit:event];
    tradeButton.enabled = YES;
}

-(void) didClickOnTrade:(SPEvent*) event {
    GamePiece *selectedPiece = _selectedPiece;
    
    if(selectedPiece == nil || _possibleRecruits.count == 0) {
        return;
    }
    
    GamePiece *newrecruit = [_possibleRecruits objectAtIndex:0];
    
    tradeButton.enabled = NO;
    [[InGameServerAccess instance] recruitThingsTradePiece:selectedPiece.gamePieceId forPiece:newrecruit.gamePieceId withSuccess:
     ^(ServerResponseMessage * message){
         dispatch_async(dispatch_get_main_queue(), ^{
             if(message.error != nil) {
                 return;
             }
             
             NSDictionary *newThingMap = [message.data.map objectForKey:@"newThing"];
             
             if(newThingMap == nil) {
                 return;
             }
             
             [_possibleRecruits removeObject:newrecruit];
             
             [newrecruit updateFromSerializedJson:newThingMap forGameState:[[Game currentGame] gameState]];
             [[[[Game currentGame] gameState] playingCup] addGamePieceToLocation:selectedPiece];
             
             [self setup];
         });
    }];
    
}

- (void) didClickOnSkip:(SPEvent *) event{
    [super didClickOnSkip:event];
    RecruitThings* parent = (RecruitThings*) _parent;
    [parent setPossibleTradeRecruits:_possibleRecruits];
}

@end
