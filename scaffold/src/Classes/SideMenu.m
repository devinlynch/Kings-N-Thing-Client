//
//  SideMenu.m
//  3004iPhone
//
//  Created by Richard Ison on 2014-03-10.
//
//

#import "SideMenu.h"
#import "Log.h"
#import "SuchTeam.h"
#import "GameReference.h"
#import "ChatScene.h"
#import "ServerAccess.h"

@implementation SideMenu{
    SPSprite *_contents;
    
    int _gameWidth;
    int _gameHeight;
    
    int _offset;
    
    UIView *view;
}


-(id) init
{
    if ((self = [super init]))
    {
        [self setup];
    }
    return self;
}

static SideMenu *instance = nil;

+(SideMenu*) getInstance{
    
    if (instance == nil) {
        instance = [[SideMenu alloc] init];
        
    }
    return instance;
}


-(void) setup {
    
    _gameWidth = Sparrow.stage.width;
    _gameHeight = Sparrow.stage.height;
    _offset = 5;
    _contents = [SPSprite sprite];
    
        
    [self addChild:_contents];
    
    
    SPImage *background = [[SPImage alloc]
                           initWithContentsOfFile:@"sideMenuBackground@2x.png"];

    
    [_contents addChild:background];
    
    
    //Side Menu Title
    
    SPTexture *titleTexture = [SPTexture textureWithContentsOfFile:@"title@2x.png"];
    SPButton *titleButton = [SPButton buttonWithUpState:titleTexture];
    

    titleButton.x = 0;
    titleButton.y = 0;
    
    [_contents addChild:titleButton];
    
    
    //Chat cell
    SPTexture *chatCellTexture = [SPTexture textureWithContentsOfFile:@"chat@2x.png"];
    SPButton *chatButton = [SPButton buttonWithUpState:chatCellTexture];
    

    chatButton.y = titleButton.height + _offset;
    
    [_contents addChild:chatButton];
    
    [chatButton addEventListener:@selector(onChatButtonTriggered:) atObject:self forType:SP_EVENT_TYPE_TRIGGERED];
    
    
    //Game log cell
    SPTexture *gameLogTexture = [SPTexture textureWithContentsOfFile:@"gamelog@2x.png"];
    SPButton *gameLogButton = [SPButton buttonWithUpState:gameLogTexture];
    
    
    gameLogButton.y = (titleButton.height * 2) + (_offset * 2);
    
    [_contents addChild:gameLogButton];
    
    [gameLogButton addEventListener:@selector(onGameLogButtonTriggered:) atObject:self forType:SP_EVENT_TYPE_TRIGGERED];
    
    
    //Random Events Reference cell
    SPTexture *referenceTexture = [SPTexture textureWithContentsOfFile:@"reference@2x.png"];
    SPButton *referenceButton = [SPButton buttonWithUpState:referenceTexture];
    
    
    referenceButton.y = (titleButton.height * 3) + (_offset * 3);
    
    [_contents addChild:referenceButton];
    
    [referenceButton addEventListener:@selector(onGameReferenceButtonTriggered:) atObject:self forType:SP_EVENT_TYPE_TRIGGERED];

    
    //Such team cell
    SPTexture *suchTeamTexture = [SPTexture textureWithContentsOfFile:@"team@2x.png"];
    SPButton *suchTeamButton = [SPButton buttonWithUpState:suchTeamTexture];
    
    
    suchTeamButton.y = (titleButton.height * 4) + (_offset * 4);
    
    [_contents addChild:suchTeamButton];
    
    [suchTeamButton addEventListener:@selector(onTeamInfoButtonTriggered:) atObject:self forType:SP_EVENT_TYPE_TRIGGERED];
    
    
    //Leave game
    SPTexture *leaveGameTexture = [SPTexture textureWithContentsOfFile:@"leavegame@2x.png"];
    SPButton *leaveGameButton = [SPButton buttonWithUpState:leaveGameTexture];
    
    
    leaveGameButton.y = (suchTeamButton.height * 5) + (_offset * 5);
    
    [_contents addChild:leaveGameButton];
    
    [leaveGameButton addEventListener:@selector(onLeaveGameButtonTriggered:) atObject:self forType:SP_EVENT_TYPE_TRIGGERED];
    

}

-(void) onChatButtonTriggered: (SPEvent *) event
{
    NSLog(@"User clicked chat cell");
    [self showChat];
   
    
}

-(void) onGameLogButtonTriggered: (SPEvent *) event
{
    NSLog(@"User clicked game log cell");
    [self showLogMenu];
    
    
    
}

-(void) onTeamInfoButtonTriggered: (SPEvent *) event
{
    NSLog(@"User clicked team info cell");
    [self showSuchTeamMenu];
    
    
}

-(void) onGameReferenceButtonTriggered: (SPEvent *) event
{
    NSLog(@"User clicked game reference cell");
    [self showGameReferencesMenu];
    
    
}

-(void) onLeaveGameButtonTriggered: (SPEvent *) event
{
    NSLog(@"User clicked leave game");
    [[ServerAccess instance] leaveGame];
}


-(void)showLogMenu{
    Log *log = [Log getInstanceFromParent:self.parent];
    [log show];
}


- (void)showChat{
    ChatScene *chat = [ChatScene getInstanceFromParent:self.parent];
    [chat show];
}

- (void)showSuchTeamMenu{
    SuchTeam *suchTeam = [[SuchTeam alloc]init];
    [self showScene:suchTeam];
}

- (void)showGameReferencesMenu{
    GameReference *gameReference = [[GameReference alloc]init];
    [self showScene:gameReference];
}
-(void) showScene:(SPSprite *)scene
{
    [self.parent addChild:scene];
    scene.visible = YES;
    
}
@end
