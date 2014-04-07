//
//  GameBoardHelper.m
//  3004iPhone
//
//  Created by Devin Lynch on 2014-04-07.
//
//

#import "GameBoardHelper.h"
#import "TileLocation.h"
#import "GameState.h"
#import "FourPlayerGame.h"
#import "HexTile.h"
#import "HexLocation.h"
#import "TouchSheet.h"


@implementation GameBoardHelper


+(NSMutableDictionary*) locations{
    NSMutableDictionary *d  = [[NSMutableDictionary alloc] init];
    
    [d setObject:[[TileLocation alloc] initWithHexNumber:0 andColumn:3 andRow:3] forKey:@""];
    [d setObject:[[TileLocation alloc] initWithHexNumber:1 andColumn:3 andRow:2] forKey:@"1"];
    [d setObject:[[TileLocation alloc] initWithHexNumber:2 andColumn:4 andRow:2] forKey:@"2"];
    [d setObject:[[TileLocation alloc] initWithHexNumber:3 andColumn:4 andRow:3] forKey:@"3"];
    [d setObject:[[TileLocation alloc] initWithHexNumber:4 andColumn:3 andRow:4] forKey:@"4"];
    [d setObject:[[TileLocation alloc] initWithHexNumber:5 andColumn:2 andRow:3] forKey:@"5"];
    [d setObject:[[TileLocation alloc] initWithHexNumber:6 andColumn:2 andRow:2] forKey:@"6"];
    [d setObject:[[TileLocation alloc] initWithHexNumber:7 andColumn:2 andRow:1] forKey:@"7"];
    [d setObject:[[TileLocation alloc] initWithHexNumber:8 andColumn:3 andRow:1] forKey:@"8"];
    [d setObject:[[TileLocation alloc] initWithHexNumber:9 andColumn:4 andRow:1] forKey:@"9"];
    [d setObject:[[TileLocation alloc] initWithHexNumber:10 andColumn:5 andRow:1] forKey:@"10"];
    [d setObject:[[TileLocation alloc] initWithHexNumber:11 andColumn:5 andRow:2] forKey:@"11"];
    [d setObject:[[TileLocation alloc] initWithHexNumber:12 andColumn:5 andRow:3] forKey:@"12"];
    [d setObject:[[TileLocation alloc] initWithHexNumber:13 andColumn:4 andRow:4] forKey:@"13"];
    [d setObject:[[TileLocation alloc] initWithHexNumber:14 andColumn:3 andRow:5] forKey:@"14"];
    [d setObject:[[TileLocation alloc] initWithHexNumber:15 andColumn:2 andRow:4] forKey:@"15"];
    [d setObject:[[TileLocation alloc] initWithHexNumber:16 andColumn:1 andRow:3] forKey:@"16"];
    [d setObject:[[TileLocation alloc] initWithHexNumber:17 andColumn:1 andRow:2] forKey:@"17"];
    [d setObject:[[TileLocation alloc] initWithHexNumber:18 andColumn:1 andRow:1] forKey:@"18"];
    [d setObject:[[TileLocation alloc] initWithHexNumber:19 andColumn:1 andRow:0] forKey:@"19"];
    [d setObject:[[TileLocation alloc] initWithHexNumber:20 andColumn:2 andRow:0] forKey:@"20"];
    [d setObject:[[TileLocation alloc] initWithHexNumber:21 andColumn:3 andRow:0] forKey:@"21"];
    [d setObject:[[TileLocation alloc] initWithHexNumber:22 andColumn:4 andRow:0] forKey:@"22"];
    [d setObject:[[TileLocation alloc] initWithHexNumber:23 andColumn:5 andRow:0] forKey:@"23"];
    [d setObject:[[TileLocation alloc] initWithHexNumber:24 andColumn:6 andRow:0] forKey:@"24"];
    [d setObject:[[TileLocation alloc] initWithHexNumber:25 andColumn:6 andRow:1] forKey:@"25"];
    [d setObject:[[TileLocation alloc] initWithHexNumber:26 andColumn:6 andRow:2] forKey:@"26"];
    [d setObject:[[TileLocation alloc] initWithHexNumber:27 andColumn:6 andRow:3] forKey:@"27"];
    [d setObject:[[TileLocation alloc] initWithHexNumber:28 andColumn:5 andRow:4] forKey:@"28"];
    [d setObject:[[TileLocation alloc] initWithHexNumber:29 andColumn:4 andRow:5] forKey:@"29"];
    [d setObject:[[TileLocation alloc] initWithHexNumber:30 andColumn:3 andRow:6] forKey:@"30"];
    [d setObject:[[TileLocation alloc] initWithHexNumber:31 andColumn:2 andRow:5] forKey:@"31"];
    [d setObject:[[TileLocation alloc] initWithHexNumber:32 andColumn:1 andRow:4] forKey:@"32"];
    [d setObject:[[TileLocation alloc] initWithHexNumber:33 andColumn:0 andRow:3] forKey:@"33"];
    [d setObject:[[TileLocation alloc] initWithHexNumber:34 andColumn:0 andRow:2] forKey:@"34"];
    [d setObject:[[TileLocation alloc] initWithHexNumber:35 andColumn:0 andRow:1] forKey:@"35"];
    [d setObject:[[TileLocation alloc] initWithHexNumber:36 andColumn:0 andRow:0] forKey:@"36"];
    return d;
}

+(void) populateHexLocationsFromFourPlayerGame: (FourPlayerGame*) fourPlayerGame is2Player:(BOOL) is2Player fromGameState: (GameState*) gameState withTouchSheet: (TouchSheet*) _sheet{
    
    NSMutableDictionary* locations = [GameBoardHelper locations];
    NSEnumerator *enumerator = [locations keyEnumerator];
    NSString* hexNumString;
    while ((hexNumString = [enumerator nextObject])) {
        TileLocation *location = [locations objectForKey:hexNumString];
        
        HexLocation *hexLocation = [gameState.hexLocations objectForKey:[NSString stringWithFormat:@"hexLocation_%d", location.hexNumber]];
        
        if(hexLocation == nil)
            continue;
        
        HexTile *tile = hexLocation.tile;
        tile.image.x = tile.hilightImage.x  = [GameBoardHelper getXValueForHexAtColumn:location.column];
        tile.image.y = tile.hilightImage.y = [GameBoardHelper getYValueForHexAtRow:location.row andColumn:location.column];
        [tile.image addEventListener:@selector(onTileClick:) atObject:fourPlayerGame forType:SP_EVENT_TYPE_TOUCH];
        [_sheet addChild: tile.image];
        [_sheet addChild: tile.hilightImage];

    }
}

+(int) getXValueForHexAtColumn: (int) column{
    int tileWidth= 52;
    int startX = 7;
    int xOffset = tileWidth/2 + (tileWidth/3);
    
    if(column <=6)
        return startX + (xOffset*column);
    return 0;
}

+(int) getYValueForHexAtRow: (int) row andColumn: (int) column{
    int tileHeight= 46;
    int startY = -18;
    switch (column) {
        case 0:
            return startY +((tileHeight/2) * 3) + ((row+1) * tileHeight);
            break;
        case 1:
            return startY +((tileHeight/2) * 2) + ((row+1) * tileHeight);
            break;
        case 2:
            return startY +((tileHeight/2) * 1) + ((row+1) * tileHeight);
            break;
        case 3:
            return startY +((tileHeight/2) * 0) + ((row+1) * tileHeight);
            break;
        case 4:
            return startY +((tileHeight/2) * 1) + ((row+1) * tileHeight);
            break;
        case 5:
            return startY +((tileHeight/2) * 2) + ((row+1) * tileHeight);
            break;
        case 6:
            return startY +((tileHeight/2) * 3) + ((row+1) * tileHeight);
            break;
        default:
            break;
    }
    return 0;
}

@end
