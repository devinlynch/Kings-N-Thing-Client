//
//  GameReference.m
//  3004iPhone
//
//  Created by Richard Ison on 2014-03-17.
//
//

#import "GameReference.h"
#import <UIKit/UIKit.h>

@implementation GameReference{
    SPSprite *_contents;
    //SPSprite *_currentScene;
    
    int _gameWidth;
    int _gameHeight;
    
    
    SPTextField *_logText;
    
    
    //Scrollingzzszsszsz
    UIScrollView *_scrollView;
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


-(void) setup
{
    _gameWidth = Sparrow.stage.width;
    _gameHeight = Sparrow.stage.height;
    _contents = [SPSprite sprite];
    
    //To add UIKit stuffs to sparrow
    view = Sparrow.currentController.view;
    
    [self addChild:_contents];
    
    
    SPImage *background = [[SPImage alloc]
                           initWithContentsOfFile:@"referencesBackground@2x.png"];
    background.scaleX = 0.8;
    background.scaleY = 0.8;
    background.x = 30;
    background.y = 50;
    
    [_contents addChild:background];
    
    
    SPTexture *buttonTexture3 = [SPTexture textureWithContentsOfFile:@"close-button-log.png"];
    SPButton * button3 = [SPButton buttonWithUpState:buttonTexture3];
    
    button3.scaleY = 0.3;
    button3.scaleX = 0.3;
    button3.x = _gameWidth - button3.width /1.5;
    button3.y = 55;
    
    [_contents addChild:button3];
    
    [button3 addEventListener:@selector(onButtonTriggered:) atObject:self forType:SP_EVENT_TYPE_TRIGGERED];
    
    
    
    NSMutableArray *log = [[NSMutableArray alloc]init];
    
    log = [NSMutableArray arrayWithObjects:@"game reference stuffs", nil];

    
    
    
    //Make text field to add in scrollView
    UITextView *_textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 10, 230, 380)];
    _textView.backgroundColor= [UIColor clearColor];
    _textView.editable = NO;
    _textView.textColor = [UIColor whiteColor];
    
    //Seperate each line
    _textView.text = [log componentsJoinedByString:@"\n"];
    
    
    //Add scroll to scene
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(30, 80, 300, 480)];
    _scrollView.pagingEnabled = NO;
    _scrollView.showsVerticalScrollIndicator = YES;
    _scrollView.hidden = NO;
    
    
    [view addSubview:_scrollView];
    
    //Add textfield in scrollView
    [_scrollView addSubview:_textView];
    [_scrollView setContentSize:CGSizeMake(300, 480)];
}


-(void) onButtonTriggered: (SPEvent *) event
{
    NSLog(@"Back to board things");
    _contents.visible = NO;
    
    //Hide scrollView
    _scrollView.hidden = YES; //[view removeFromSuperview];
    
}


@end
