//
//  Log.m
//  3004iPhone
//
//  Created by Richard Ison on 2/10/2014.
//
//

#import "Log.h"
#import "Game.h"
#import "LogMessage.h"
//#import "Transparency.h"
//#import "SPScrollSprite.h"
//#import "Sparrow.h"

@implementation Log
{
    SPTextField *_logText;
    
    
    //Scrollingzzszsszsz
    UIScrollView *_scrollView;
    UIView *view;
    
    NSMutableArray *log;
    
    UITextView *_textView;
    
}

-(id) initFromParent:(SPSprite *)parent
{
    if ((self = [super initFromParent:parent]))
    {
        [self setup];
    }
    return self;
}

static Log *instance;
+(Log*) getInstanceFromParent: (SPSprite *)parent{
    if(instance == nil) {
        instance = [[Log alloc] initFromParent:parent];
    }
    return instance;
}


-(void) setup
{
    [super setup];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didGetNewState:)
                                                 name:@"newLogMessage"
                                               object:nil];
    
    

    //To add UIKit stuffs to sparrow
    view = Sparrow.currentController.view;
    
    SPImage *background = [[SPImage alloc]
                           initWithContentsOfFile:@"infoBackground@2x.png"];
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
    
  
   
    log = [[NSMutableArray alloc]init];
    
    log = [[NSMutableArray alloc] init];
    [self updateLogs];
    
    //Make text field to add in scrollView
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 10, 230, 380)];
    _textView.backgroundColor= [UIColor clearColor];
    _textView.editable = NO;
    _textView.textColor = [UIColor whiteColor];
    
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
    
    _scrollView.hidden = YES;
}

-(void) updateLogs {
    [log removeAllObjects];
    if([Game currentGame] != nil) {
        NSArray *logs  =[[Game currentGame] logMessages];
        for(LogMessage *msg in logs) {
            NSDateFormatter *format = [[NSDateFormatter alloc] init];
            [format setDateFormat:@"hh:mm:ss"];
            NSString *formattedDate = [format stringFromDate:msg.date];
            [log addObject:[NSString stringWithFormat:@"[%@]: %@", formattedDate, msg.message]];
        }
    }
    
    _textView.text = [log componentsJoinedByString:@"\n"];
}

-(void) didGetNewState: (NSNotification*) notif{
    [self updateLogs];
}


-(void) onButtonTriggered: (SPEvent *) event
{
    NSLog(@"Back to board things");
    [self hide];
}

-(void) show{
    [super show];
    _scrollView.hidden = NO;
}

-(void) hide{
    [super hide];
    _scrollView.hidden = YES;
}

-(void) dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
