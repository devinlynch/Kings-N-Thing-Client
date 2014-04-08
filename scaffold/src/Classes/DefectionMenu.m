//
//  DefectionMenu.m
//  3004iPhone
//
//  Created by Devin Lynch on 2014-04-07.
//
//

#import "DefectionMenu.h"
#import "GameResource.h"
#import "InGameServerAccess.h"
#import "GamePiece.h"
#import "Utils.h"
#import "UIAlertView+Blocks.h"
#import "RandomEventsMenu.h"

@implementation DefectionMenu
{
    GamePiece *_defectionPiece;
}
-(id) init{
    self = [super initFromParent:nil];
    if(self) {
        bgFileName = @"FourPlayerBackground@2x.png";
        [self setup];
    }
    return self;
}

-(id) initFromParent:(RandomEventsMenu *)parent withDefectionPiece: (GamePiece*) defectionPiece{
    self = [super initFromParent:parent];
    if(self) {
        _player = nil;
        _location = nil;
        bgFileName = @"FourPlayerBackground@2x.png";
        _defectionPiece = defectionPiece;
        [self initPieces];
        
        [self setup];
    }
  
    return self;
}

-(void) setup {
    [super setup];
    
    //Username text
    SPTextField *welcomeTF = [SPTextField textFieldWithWidth:300 height:80
                                                        text:@"With the defection piece you are able to recruit any of these characters."];
    welcomeTF.x = welcomeTF.y = 6;
    welcomeTF.fontName = @"ArialMT";
    welcomeTF.fontSize = 16;
    welcomeTF.color = 0xffffff;
    welcomeTF.touchable = NO;
    [_contents addChild:welcomeTF];
}

-(void) initPieces {
    NSMutableArray *tmpPieces = [[NSMutableArray alloc] init];
    
    NSEnumerator *enumerator = [[[GameResource getInstance] getAllSpecialChars] keyEnumerator];
    id key;
    while ((key = [enumerator nextObject])) {
        SpecialCharacter *character = [[[GameResource getInstance] getAllSpecialChars] objectForKey:key];
        [tmpPieces addObject:character];
    }
    
    presetPieces = [NSArray arrayWithArray:tmpPieces];
}

-(void) didClickOnRecruit:(SPEvent *) event{
    [super didClickOnRecruit:event];
    
    if(_selectedPiece != nil) {
        BOOL didRecruit = [Utils getYesOrNo];
        [[InGameServerAccess instance] randomEventPlacedDefection:_defectionPiece.gamePieceId recruitingForId:_selectedPiece.gamePieceId andDidRecruit:didRecruit andSuccess:^(ServerResponseMessage* message) {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSString* msg;
                if(!didRecruit) {
                    msg = @"Sorry the recruitment was unsuccessful";
                } else{
                    msg = @"You recruited it!";
                }
                
                [((RandomEventsMenu*)_parent) removeRandomEventPiece:(RandomEvent*)_defectionPiece];
                [self hide];
                [Utils showAlertWithTitle:@"Alert" message:msg delegate:nil cancelButtonTitle:@"Ok"];
            });
          
        }];
    }
}



@end
