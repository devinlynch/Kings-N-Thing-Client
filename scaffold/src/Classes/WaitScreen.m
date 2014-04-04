//
//  WaitScreen.m
//  3004iPhone
//
//  Created by Richard Ison on 2014-03-27.
//
//

#import "WaitScreen.h"

@implementation WaitScreen{
    SPTextField *_logText;
    
    UIScrollView *_scrollView;
    UIView *view;
}

-(id) init
{
    if ((self = [super initFromCombatController:nil]))
    {
        [self setup];
    }
    
    return self;
}

-(id) initFromCombatController:(CombatPhaseScreenController *)controller {
    if ((self = [super initFromCombatController:controller]))
    {
        [self setup];
    }
    
    return self;
}


-(void) setup{
    //To add UIKit stuffs to sparrow
    view = Sparrow.currentController.view;
    
    SPImage *background = [[SPImage alloc] initWithContentsOfFile:@"WaitScreenBackground@2x.png"];
    
    //necessary or else it gets placed off screen
    background.x = 0;
    background.y = 0;
    
    [_contents addChild:background];
    
    //Add game log shiet
    
    SPTextField *gameLogText = [SPTextField textFieldWithWidth:190 height: 30 text:@"Battle Log"];
    gameLogText.x = _gameWidth / 2 - gameLogText.width / 2;
    gameLogText.y = _gameWidth / 2.20;
    gameLogText.fontSize = 23;
    gameLogText.color = SP_WHITE;
    [_contents addChild:gameLogText];
    
    SPImage *darkZone = [[SPImage alloc] initWithContentsOfFile:@"DarkZone2.png"];
    darkZone.x = _gameWidth / 2 - darkZone.width / 2;
    darkZone.y = _gameWidth / 2.2;
    darkZone.scaleY = 1.8;
    [_contents addChild:darkZone];
    
    
    //Array to hold the logs
    NSMutableArray *log = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 50; i++){
    [log addObject:@"test1"];
    }
    
    //TextView to add in scrollView
    
    UITextView *_textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 10, 200, 200)];
    _textView.backgroundColor= [UIColor clearColor];
    _textView.editable = NO;
    _textView.textColor = [UIColor whiteColor];
    
    //Seperate each line
    _textView.text = [log componentsJoinedByString:@"\n"];
    
    
    //Add scroll to scene
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(_gameWidth / 2 - darkZone.width / 2 + 15, _gameWidth / 2.2 + 25, 200, 200)];
    _scrollView.pagingEnabled = NO;
    _scrollView.showsVerticalScrollIndicator = YES;
    _scrollView.hidden = NO;
    
    
    [view addSubview:_scrollView];
    
    //Add textfield in scrollView
    [_scrollView addSubview:_textView];
    [_scrollView setContentSize:CGSizeMake(180, 480)];
    
    
    
    
    
    // Fun tings
    
    SPTextField *boredText = [SPTextField textFieldWithWidth:130 height: 30 text:@"Bored?"];
    boredText.x = _gameWidth / 2 - boredText.width / 2;
    boredText.y = _gameWidth + 100;
    boredText.fontSize = 23;
    boredText.color = SP_WHITE;
    [_contents addChild:boredText];
    
    
    SPImage *darkZone2 = [[SPImage alloc] initWithContentsOfFile:@"DarkZone2.png"];
    darkZone2.x = 50;
    darkZone2.y = 450;
    darkZone2.scaleY = 0.5;
    darkZone2.scaleX = 0.3;
    [_contents addChild:darkZone2];
    
    SPTextField *playBullsEyeText = [SPTextField textFieldWithWidth:130 height: 30 text:@"Play BullsEye"];
    playBullsEyeText.x = 20;
    playBullsEyeText.y = 480;
    playBullsEyeText.fontSize = 10;
    playBullsEyeText.color = SP_WHITE;
    [_contents addChild:playBullsEyeText];
    
    SPTexture *bullsEyeButtonTexture = [SPTexture textureWithContentsOfFile:@"BullseyeBtn@2x.png"];
    SPButton *bullsEyeButton = [SPButton buttonWithUpState:bullsEyeButtonTexture];
    bullsEyeButton.x = 67;
    bullsEyeButton.y = 455;
    [_contents addChild:bullsEyeButton];
    
    [bullsEyeButton addEventListener:@selector(playBullsEye:) atObject:self forType:SP_EVENT_TYPE_TOUCH];


}

-(void) playBullsEye:(SPTouchEvent*) event{
    NSArray *touches = [[event touchesWithTarget:self andPhase:SPTouchPhaseBegan] allObjects];
    
    
    if (touches.count == 1) {
        
        // Find card id, show pop up of description
        NSLog(@"PLAYYYYY");
        
        
    } else if (touches.count == 2){
        
        //Selects the card
        
        
    }
    
    
}

-(void) hide{
    [super hide];
    _scrollView.hidden = YES;
}

-(void) show{
    [super show];
    _scrollView.hidden = NO;
}

@end
