//
//  SideMenu.m
//  3004iPhone
//
//  Created by Richard Ison on 2014-03-10.
//
//

#import "SideMenu.h"

@implementation SideMenu{
    SPSprite *_contents;
    
    int _gameWidth;
    int _gameHeight;
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
    _contents = [SPSprite sprite];
    
    //To add UIKit stuffs to sparrow
    UIView *view = Sparrow.currentController.view;
    
    [self addChild:_contents];
    
    
    SPImage *background = [[SPImage alloc]
                           initWithContentsOfFile:@"sideMenuBackground@2x.png"];

    
    [_contents addChild:background];
    
    
    //TODO:
    // Add UITableView
    // this table will hold all the stuffs
    // i.e logs, info of app, instructions, stuffs, etc



}

@end
