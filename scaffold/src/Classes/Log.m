//
//  Log.m
//  3004iPhone
//
//  Created by Richard Ison on 2/10/2014.
//
//

#import "Log.h"
//#import "Transparency.h"
//#import "SPScrollSprite.h"
//#import "Sparrow.h"

@implementation Log
{
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
                           initWithContentsOfFile:@"infoBackground-trans@2x.png"];
    background.scaleX = 0.8;
    background.scaleY = 0.8;
    background.x = 30;
    background.y = 50;
    
    [_contents addChild:background];
    
    
    SPTexture *buttonTexture3 = [SPTexture textureWithContentsOfFile:@"back.png"];
    SPButton * button3 = [SPButton buttonWithUpState:buttonTexture3];
    
    button3.scaleY = 0.8;
    button3.scaleX = 0.8;
    button3.x = 320 / 2 - button3.width /2.5;
    button3.y = 410;
    
    [_contents addChild:button3];
    
    [button3 addEventListener:@selector(onButtonTriggered:) atObject:self forType:SP_EVENT_TYPE_TRIGGERED];
    
  
   
    NSMutableArray *log = [[NSMutableArray alloc]init];
    
    log = [NSMutableArray arrayWithObjects:@"test1: Dis is naht Java.",
                                           @"test2: Java java java java java java.",
                                           @"test3: 3d 3d 3d 3d 3d 3d 3d 3d 3d 3d", nil];
    
    //Adding to the log
    [log addObject:@"dis is objectiv-c"];
    [log addObject:@"dis is objectiv-c"];
    [log addObject:@"dis is objectiv-c"];
    [log addObject:@"dis is objectiv-c"];
    [log addObject:@"dis is objectiv-c"];
    [log addObject:@"dis is objectiv-c"];
    [log addObject:@"dis is objectiv-c"];
    [log addObject:@"dis is objectiv-c"];
    [log addObject:@"dis is objectiv-c"];
    [log addObject:@"dis is objectiv-c"];
    [log addObject:@"dis is objectiv-c"];
    [log addObject:@"dis is objectiv-c"];
    [log addObject:@"dis is objectiv-c"];
    [log addObject:@"dis is objectiv-c"];
    [log addObject:@"dis is objectiv-c"];
    [log addObject:@"dis is objectiv-c"];
    [log addObject:@"dis is objectiv-c"];
    [log addObject:@"dis is objectiv-c"];
    [log addObject:@"dis is objectiv-c"];
    [log addObject:@"dis is objectiv-c"];
    [log addObject:@"dis is objectiv-c"];
    [log addObject:@"dis is objectiv-c"];
    [log addObject:@"dis is objectiv-c"];
    [log addObject:@"dis is objectiv-c"];
    [log addObject:@"dis is objectiv-c"];
    [log addObject:@"dis is objectiv-c"];
    [log addObject:@"dis is objectiv-c"];
    [log addObject:@"dis is objectiv-c"];
    [log addObject:@"dis is objectiv-c"];
    [log addObject:@"dis is objectiv-c"];
    [log addObject:@"dis is objectiv-c"];
    [log addObject:@"dis is objectiv-c"];
    [log addObject:@"dis is objectiv-c"];
    [log addObject:@"dis is objectiv-c"];
    [log addObject:@"dis is objectiv-c"];
    [log addObject:@"dis is objectiv-c"];
    [log addObject:@"dis is objectiv-c"];
    [log addObject:@"dis is objectiv-c"];
    [log addObject:@"dis is objectiv-c"];
    [log addObject:@"dis is objectiv-c"];
    [log addObject:@"dis is objectiv-c"];
    [log addObject:@"dis is objectiv-c"];
    
    
    
    //Make text field to add in scrollView
    UITextView *_textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 15, 230, 250)];
    _textView.backgroundColor= [UIColor clearColor];
    _textView.editable = NO;
    _textView.textColor = [UIColor blackColor];
    
    //Seperate each line
    _textView.text = [log componentsJoinedByString:@"\n"];
   
    
    //Add scroll to scene
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(60, 100, 300, 250)];
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
