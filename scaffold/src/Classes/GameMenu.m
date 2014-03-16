#import "TwoThreePlayerGame.h"
#import "GameMenu.h"
#import "GoldCollection.h"
#import "Scene.h"
#import "FourPlayerGame.h"
#import "RecruitThings.h"
#import "Combat.h"
#import "Movement.h"

@implementation GameMenu
{
    Scene *_currentScene;
    SPSprite * _mainMenu;
    float _offsetY;
}

- (instancetype)init
{
    if ((self = [super init]))
    {
        // make simple adjustments for iPhone 5+ screens:
        _offsetY = (Sparrow.stage.height - 480) / 4;
        
        // add background image
        SPImage *background = [SPImage imageWithContentsOfFile:@"gameMenu@2x.png"];
       // background.y = _offsetY > 0.0f ? 0.0 : -44;
        background.blendMode = SP_BLEND_MODE_NONE;
        [self addChild:background];
        
        // this sprite will contain objects that are only visible in the main menu
        _mainMenu = [[SPSprite alloc] init];
        _mainMenu.y = _offsetY;
        [self addChild:_mainMenu];
        
        // choose which scenes will be accessible
        NSArray *scenesToCreate = @[@"Start",[FourPlayerGame class],
                                    @"Instructions",[GoldCollection class],
                                    @"Team", [RecruitThings class]];
        
        SPTexture *buttonTexture = [SPTexture textureWithContentsOfFile:@"btn@2x.png"];
        int count = 0;
        int index = 0;
        
        // create buttons for each scene
        while (index < scenesToCreate.count)
        {
            NSString *sceneTitle = scenesToCreate[index++];
            Class sceneClass = scenesToCreate[index++];
            
            SPButton *button = [SPButton buttonWithUpState:buttonTexture text:sceneTitle];
           // button.x = count % 2 == 0 ? 28 : 167;
            button.x = (Sparrow.stage.width / 2) - button.width /2;
            button.y = _offsetY + 170 + (count * 2) * 25;
            button.name = NSStringFromClass(sceneClass);
            
           // if (scenesToCreate.count % 2 != 0 && count % 2 == 1)
            //    button.y += 100;
            
            [button addEventListener:@selector(onButtonTriggered:) atObject:self
                             forType:SP_EVENT_TYPE_TRIGGERED];
            [_mainMenu addChild:button];
            ++count;
        }
        
//        [self addEventListener:@selector(onSceneClosing:) atObject:self
//                       forType:EventTypeSceneClosing];
        
    }
    return self;
}

- (void)onButtonTriggered:(SPEvent *)event
{
    if (_currentScene) return;
    
    // the class name of the scene is saved in the "name" property of the button.
    SPButton *button = (SPButton *)event.target;
    Class sceneClass = NSClassFromString(button.name);
    
    // create an instance of that class and add it to the display tree.
    _currentScene = [[sceneClass alloc] init];
    _currentScene.y = _offsetY;
  //  _mainMenu.visible = NO;
    [self addChild:_currentScene];
}

- (void)onSceneClosing:(SPEvent *)event
{
    [_currentScene removeFromParent];
    _currentScene = nil;
    _mainMenu.visible = YES;
}


@end