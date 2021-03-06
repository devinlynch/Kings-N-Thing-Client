//
//  ChatScene.m
//  3004iPhone
//
//  Created by Richard Ison on 2014-03-20.
//
//

#import "ChatScene.h"
#import "Game.h"
#import "InGameServerAccess.h"
#import "GameChatMessage.h"
#import "User.h"

@implementation ChatScene
{
    
    SPTextField *_logText;
    
    
    //Scrollingzzszsszsz
    UIScrollView *_scrollView;
    UIView *view;
    
    //Textfield
    UITextField *_chatTextField;
    
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


static ChatScene *instance;
+(ChatScene*) getInstanceFromParent: (SPSprite*) parent{
    if(instance == nil) {
        instance = [[ChatScene alloc] initFromParent:parent];
    }
    return instance;
}


-(void) setup
{
    [super setup];
    //To add UIKit stuffs to sparrow
    view = Sparrow.currentController.view;
    
    SPImage *background = [[SPImage alloc]
                           initWithContentsOfFile:@"chatBackground@2x.png"];
    //background.scaleX = 0.8;
    //background.scaleY = 0.8;
    //background.x = 30;
    //background.y = 50;
    
    [_contents addChild:background];
    
    
    SPTexture *buttonTexture3 = [SPTexture textureWithContentsOfFile:@"close-button-log.png"];
    SPButton * button3 = [SPButton buttonWithUpState:buttonTexture3];
    
    button3.scaleY = 0.3;
    button3.scaleX = 0.3;
    button3.x = _gameWidth - button3.width /2 + 15;
    button3.y = 8;
    
    [_contents addChild:button3];
    
    [button3 addEventListener:@selector(onButtonTriggered:) atObject:self forType:SP_EVENT_TYPE_TRIGGERED];
    
    
    
    NSMutableArray *log = [[NSMutableArray alloc]init];
    
    log = [[NSMutableArray alloc] init];
    
    if([Game currentGame] != nil){
        for(GameChatMessage *msg in [[Game currentGame] chatMessages]) {
            [log addObject:[NSString stringWithFormat:@"%@: %@", msg.user.username, msg.message]];
        }
    }
    
    //Make text field to add in scrollView
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 300, 260)];
    _textView.backgroundColor= [UIColor clearColor];
    _textView.editable = NO;
    _textView.textColor = [UIColor whiteColor];
    
    //Seperate each line
    _textView.text = [log componentsJoinedByString:@"\n"];
    
    
    //Add scroll to scene
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(5, 50, 300, 260)];
    _scrollView.pagingEnabled = NO;
    _scrollView.showsVerticalScrollIndicator = YES;
    _scrollView.hidden = YES;
    
    
    [view addSubview:_scrollView];
    
    //Add textfield in scrollView
    [_scrollView addSubview:_textView];
    [_scrollView setContentSize:CGSizeMake(300, 460)];
    
    
    _chatTextField = [[UITextField alloc] initWithFrame:CGRectMake(5, 300, 300, 30)];
    _chatTextField.borderStyle = UITextBorderStyleRoundedRect;
    _chatTextField.textColor = [UIColor blackColor];
    _chatTextField.font = [UIFont systemFontOfSize:17.0];
    _chatTextField.placeholder = @"Enter a message!";
    _chatTextField.autocorrectionType = UITextAutocorrectionTypeYes;
    _chatTextField.keyboardType = UIKeyboardTypeDefault;
    _chatTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _chatTextField.delegate = self;
    [view addSubview:_chatTextField];
    _chatTextField.selected=true;
    _chatTextField.hidden=YES;
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(newChatMessage:)
                                                 name:@"newChatMessage"
                                               object:nil];
   
}


-(void) onButtonTriggered: (SPEvent *) event
{
    [self hide];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (([[_chatTextField text] length] < 1))
    {
        
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sent"
                                                        message:@"Your chat message was sent"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        
        [[InGameServerAccess instance] sendChatMessage:[_chatTextField text] withSuccess:nil];
        [_chatTextField setText:@""];
    }
    
    
    [textField resignFirstResponder];
    
    return YES;
}

-(void) show{
    [super show];
    _scrollView.hidden = NO;
    _chatTextField.hidden = NO;
}

-(void) hide{
    [super hide];
    _scrollView.hidden = YES;
    _chatTextField.hidden = YES;
}

-(void) newChatMessage: (NSNotification*) notif{
    [self updateChat];
}

-(void) updateChat{
    NSMutableArray *log = [[NSMutableArray alloc] init];
    
    if([Game currentGame] != nil){
        for(GameChatMessage *msg in [[Game currentGame] chatMessages]) {
            [log addObject:[NSString stringWithFormat:@"%@: %@", msg.user.username, msg.message]];
        }
    }
    
    _textView.text = [log componentsJoinedByString:@"\n"];
}

-(void) dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
