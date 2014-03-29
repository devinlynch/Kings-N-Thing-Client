//
//  RecruitThings.m
//  3004iPhone
//
//  Created by Richard Ison on 2/3/2014.
//
//

#import "RecruitThings.h"
#import "ScaledGamePiece.h"
#import "TouchSheet.h"
#import "TileMenu.h"
#import "RecruitOptionMenu.h"
#import "Game.h"
#import "GameState.h"
#import "GameResource.h"
#import "InGameServerAccess.h"

@interface RecruitThings()
- (void)setup;
@end

@implementation RecruitThings{
    
    SPSprite *_contents;
    SPSprite *_currentScene;
    
    int _gameWidth;
    int _gameHeight;
    
    NSMutableArray *freeRecruits;
    NSMutableArray *paidRecruits;
    NSMutableArray *tradeRecruits;
}


-(id) init
{
    if ((self = [super init]))
    {
        [self setup];
        freeRecruits = [[NSMutableArray alloc] init];
        paidRecruits = [[NSMutableArray alloc] init];
        tradeRecruits = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void)initWithObjectsToRecruit: (NSArray*)objectsToRecruit{
    GameState *gs = [[Game currentGame] gameState];
    Player *me = [gs getPlayerById:[gs myPlayerId]];
    
    int maxPaid = me.gold / 5;
    int maxFree = 2;
    
    [freeRecruits removeAllObjects];
    [paidRecruits removeAllObjects];
    [tradeRecruits removeAllObjects];
    for(id o in objectsToRecruit) {
        NSString *gpId = (NSString*) o;
        GamePiece *gp = [[GameResource getInstance] getPieceForId:gpId];
        if(gp != nil) {
            if(maxFree > 0) {
                [freeRecruits addObject:gp];
                maxFree--;
            } else if(maxPaid > 0) {
                [paidRecruits addObject:gp];
                maxPaid--;
            } else {
                [tradeRecruits addObject:gp];
            }
            
        }
    }
    
}


static RecruitThings *instance;
+(RecruitThings*) getInstance{
    
    if (instance == nil) {
        instance = [[RecruitThings alloc] init];
        
    }
    return instance;
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
    background.y = 0;
    
    background.blendMode = SP_BLEND_MODE_NONE;
    [_contents addChild:background];
    
    //Username text
    SPTextField *welcomeTF = [SPTextField textFieldWithWidth:300 height:120
                                                        text:@"Recruit Things"];
    welcomeTF.x = welcomeTF.y = offset;
    welcomeTF.fontName = @"ArialMT";
    welcomeTF.fontSize = 25;
    welcomeTF.color = 0xffffff;
    [_contents addChild:welcomeTF];
    
    
    //Free button
    SPTexture *freeButtonTexture = [SPTexture textureWithContentsOfFile:@"free.png"];
    SPButton *freeButton = [SPButton buttonWithUpState:freeButtonTexture];
    freeButton.x = _gameWidth /2 - freeButton.width /2;
    freeButton.y = 55 + 90 - 30;
    [_contents addChild:freeButton];
    [freeButton addEventListener:@selector(didClickOnFreeRecruit:) atObject:self forType:SP_EVENT_TYPE_TRIGGERED];
    
    //Button
    
    SPTexture *buyButtonTexture = [SPTexture textureWithContentsOfFile:@"buy.png"];
    
    SPButton *buyButton = [SPButton buttonWithUpState:buyButtonTexture];
    
    buyButton.x = _gameWidth /2 - buyButton.width /2;
    buyButton.y = 135+ 90 - 30;
    
    [_contents addChild:buyButton];
    
    [buyButton addEventListener:@selector(didClickOnPaidRecruit:) atObject:self forType:SP_EVENT_TYPE_TRIGGERED];
    
    
    SPTexture *tradeButtonTexture = [SPTexture textureWithContentsOfFile:@"trade.png"];
    
    SPButton *tradeButton = [SPButton buttonWithUpState:tradeButtonTexture];
    
    tradeButton.x = _gameWidth /2 - tradeButton.width /2;
    tradeButton.y = 220 + 90 - 30;
    
    [_contents addChild:tradeButton];
    
    //[button3 addEventListener:@selector(onButtonTriggered:) atObject:self forType:SP_EVENT_TYPE_TRIGGERED];
    
    
    SPTexture *backButtonTexture = [SPTexture textureWithContentsOfFile:@"back.png"];
    SPButton *backButton = [SPButton buttonWithUpState:backButtonTexture];
    backButton.x = 320 / 2 - backButton.width /2;
    backButton.y = 385;
    [_contents addChild:backButton];
    
    [backButton addEventListener:@selector(onButtonTriggered:) atObject:self forType:SP_EVENT_TYPE_TRIGGERED];
    
    
}


- (void) didClickOnFreeRecruit:(SPEvent *) event{
    NSLog(@"Clicked free recruit");
    if([freeRecruits count] == 0) {
        NSLog(@"Clicked free recruit but there's no more free recruits left");
        return;
    }
    
    GamePiece *gp = [freeRecruits objectAtIndex:0];
    [freeRecruits removeObjectAtIndex:0];
    
    RecruitOptionMenu *recruitMenu = [[RecruitOptionMenu alloc] init];
    [recruitMenu setGamePiece:gp];
    [self showScene:recruitMenu];
}

- (void) didClickOnPaidRecruit:(SPEvent *) event{
    NSLog(@"Clicked paid recruit");
    if([paidRecruits count] == 0) {
        NSLog(@"Clicked paid recruit but there's no more paid recruits left");
        return;
    }
    
    GamePiece *gp = [paidRecruits objectAtIndex:0];
    [paidRecruits removeObjectAtIndex:0];
    
    RecruitOptionMenu *recruitMenu = [[RecruitOptionMenu alloc] init];
    [recruitMenu setGamePiece:gp];
    recruitMenu.isBuy = YES;
    [self showScene:recruitMenu];
}


- (void)showScene:(SPSprite *)scene {
    
    [self addChild:scene];
    scene.visible = YES;
}

-(void) onButtonTriggered: (SPEvent *) event
{
    [[InGameServerAccess instance] recruitThingsPhaseReadyForNextPhase];
    NSLog(@"Back");
    self.visible = NO;
}


@end
