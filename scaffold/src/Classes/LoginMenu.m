//
//  LoginMenu.m
//  3004iPhone
//
//  Created by John Marsh on 1/16/2014.
//
//

#import "LoginMenu.h"

#import "GameMenu.h"
#import "Scene.h"


@implementation LoginMenu
{
    Scene *_currentScene;
    SPSprite * _loginMenu;
    UITextField *_usernameTextField, *_passwordTextField;
    float _offsetY;
    SPViewController *viewController;
    UIView *view;
}

- (instancetype)init
{
    viewController = Sparrow.currentController;
    view = viewController.view;
    
    
    _usernameTextField = [[UITextField alloc] initWithFrame:CGRectMake(50, 50, 200, 30)];
    _usernameTextField.borderStyle = UITextBorderStyleRoundedRect;
    _usernameTextField.textColor = [UIColor blackColor];
    _usernameTextField.font = [UIFont systemFontOfSize:17.0];
    _usernameTextField.placeholder = @"Username";
    _usernameTextField.autocorrectionType = UITextAutocorrectionTypeYes;
    _usernameTextField.keyboardType = UIKeyboardTypeDefault;
    _usernameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _usernameTextField.delegate = self;
    [view addSubview:_usernameTextField];
    
    _passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(50, 100, 200, 30)];
    _passwordTextField.borderStyle = UITextBorderStyleRoundedRect;
    _passwordTextField.textColor = [UIColor blackColor];
    _passwordTextField.font = [UIFont systemFontOfSize:17.0];
    _passwordTextField.placeholder = @"Password";
    _passwordTextField.autocorrectionType = UITextAutocorrectionTypeYes;
    _passwordTextField.keyboardType = UIKeyboardTypeDefault;
    _passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _passwordTextField.delegate = self;
    [view addSubview:_passwordTextField];
    
    if ((self = [super init]))
    {
        // make simple adjustments for iPhone 5+ screens:
        _offsetY = (Sparrow.stage.height - 480) / 2;
        
        // add background image
        SPImage *background = [SPImage imageWithContentsOfFile:@"mainMenuBackground.png"];
        // background.y = _offsetY > 0.0f ? 0.0 : -44;
        background.blendMode = SP_BLEND_MODE_NONE;
        [self addChild:background];
        
        // this sprite will contain objects that are only visible in the main menu
        _loginMenu = [[SPSprite alloc] init];
        _loginMenu.y = _offsetY;
        [self addChild:_loginMenu];
        
        // choose which scenes will be accessible
        NSArray *scenesToCreate = @[@"Login",[GameMenu class]];
        
        SPTexture *buttonTexture = [SPTexture textureWithContentsOfFile:@"Button-Normal@2x.png"];
        int count = 0;
        int index = 0;
        
        // create buttons for each scene
        while (index < scenesToCreate.count)
        {
            NSString *sceneTitle = scenesToCreate[index++];
            Class sceneClass = scenesToCreate[index++];
            
            SPButton *button = [SPButton buttonWithUpState:buttonTexture text:sceneTitle];
            // button.x = count % 2 == 0 ? 28 : 167;
            button.x = 50;
            button.y = _offsetY + 170 + (count / 2) * 52;
            button.name = NSStringFromClass(sceneClass);
            
            if (scenesToCreate.count % 2 != 0 && count % 2 == 1)
                button.y += 26;
            
            [button addEventListener:@selector(onButtonTriggered:) atObject:self
                             forType:SP_EVENT_TYPE_TRIGGERED];
            [_loginMenu addChild:button];
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
    _loginMenu.visible = NO;
    
    _usernameTextField.hidden = YES;
    _passwordTextField.hidden = YES;
    [self addChild:_currentScene];
}

- (void)onSceneClosing:(SPEvent *)event
{
    [_currentScene removeFromParent];
    _currentScene = nil;
    _loginMenu.visible = YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (([[_usernameTextField text] length] > 1) && ([[_passwordTextField text] length] > 1))
    {
        
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"Invalid Email"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];

    }
    
    
    [textField resignFirstResponder];
    
    return YES;
}


@end