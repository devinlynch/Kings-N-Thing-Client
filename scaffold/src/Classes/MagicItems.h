//
//  MagicItems.h
//  3004iPhone
//
//  Created by John Marsh on 1/15/2014.
//
//

#import "Thing.h"


//Soooooo I just copied what Gabe initialized on the server

@interface MagicItems : Thing{
    NSString *_magicId;
    NSString *_magicType;
}

@property NSString *magicId, *magicType;

-(MagicItems*) initWithId:(NSString*) magicId andMagicType:(NSString*) type andFilename: (NSString*) filename;

+(NSMutableDictionary*) initializeAllMagicItems;




@end
