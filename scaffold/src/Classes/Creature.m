//
//  Creature.m
//  3004iPhone
//
//  Created by John Marsh on 1/15/2014.
//
//

#import "Creature.h"
#import "CombatType.h"
#import "Terrain.h"
#import "ScaledGamePiece.h"

@implementation Creature

@synthesize combatValue = _combatValue;
@synthesize combatType  = _combatType;
@synthesize terrain = _terrain;


-(Creature*) initWithId:(NSString*) creatureId andCombatValue:(int) value andCombatType: (CombatType*) type andTerrain: (Terrain*) t andFilename: (NSString*) filename{
    self = [super init];
    
    _gamePieceId = [[NSString alloc] initWithString:creatureId];
    _combatValue = value;
    _combatType = type;
    _terrain = t;
    _pieceImage = [[ScaledGamePiece alloc] initWithContentsOfFile:filename andOwner:self];
    _fileName = [[NSString alloc] initWithString:filename];
    [_pieceImage addEventListener:@selector(creatureDoubleClick:) atObject:self forType:SP_EVENT_TYPE_TOUCH];

    
    return self;
}


-(void) creatureDoubleClick: (SPTouchEvent*) event
{
    NSArray *touches = [[event touchesWithTarget:[self pieceImage] andPhase:SPTouchPhaseBegan] allObjects];
    
    if (touches.count == 1)
    {
        //Double Click
        SPTouch *clicks = [touches objectAtIndex:0];
        if (clicks.tapCount == 2){
            NSLog(@"le double click");
            [[NSNotificationCenter defaultCenter] postNotificationName:@"pieceSelected" object:self];
        }
        
    }
    
}


+(NSMutableDictionary*) initializeAllCreatures{
    NSMutableDictionary *creatures = [[NSMutableDictionary alloc] init];
    
    [creatures setObject:[[Creature alloc] initWithId:@"T_Desert_105-01" andCombatValue:4 andCombatType:[CombatType getMagicInstance] andTerrain:[Terrain getDesertInstance] andFilename:@"T_Desert_105.png"] forKey:@"T_Desert_105-01"];
    
    [creatures setObject:[[Creature alloc] initWithId:@"T_Desert_106-01" andCombatValue:3 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getDesertInstance] andFilename:@"T_Desert_106.png"] forKey:@"T_Desert_106-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Desert_107-01" andCombatValue:1 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getDesertInstance] andFilename:@"T_Desert_107.png"] forKey:@"T_Desert_107-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Desert_108-01" andCombatValue:2 andCombatType:[CombatType getMagicInstance] andTerrain:[Terrain getDesertInstance] andFilename:@"T_Desert_108.png"] forKey:@"T_Desert_108-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Desert_108-02" andCombatValue:2 andCombatType:[CombatType getMagicInstance] andTerrain:[Terrain getDesertInstance] andFilename:@"T_Desert_108.png"] forKey:@"T_Desert_108-02"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Desert_109-01" andCombatValue:4 andCombatType:[CombatType getMagicInstance] andTerrain:[Terrain getDesertInstance] andFilename:@"T_Desert_109.png"] forKey:@"T_Desert_109-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Desert_110-01" andCombatValue:1 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getDesertInstance] andFilename:@"T_Desert_110.png"] forKey:@"T_Desert_110-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Desert_111-01" andCombatValue:3 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getDesertInstance] andFilename:@"T_Desert_111.png"] forKey:@"T_Desert_111-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Desert_112-01" andCombatValue:2 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getDesertInstance] andFilename:@"T_Desert_112.png"] forKey:@"T_Desert_112-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Desert_113-01" andCombatValue:3 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getDesertInstance] andFilename:@"T_Desert_113.png"] forKey:@"T_Desert_113-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Desert_114-01" andCombatValue:1 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getDesertInstance] andFilename:@"T_Desert_114.png"] forKey:@"T_Desert_114-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Desert_114-02" andCombatValue:1 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getDesertInstance] andFilename:@"T_Desert_114.png"] forKey:@"T_Desert_114-02"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Desert_115-01" andCombatValue:1 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getDesertInstance] andFilename:@"T_Desert_115.png"] forKey:@"T_Desert_115-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Desert_116-01" andCombatValue:4 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getDesertInstance] andFilename:@"T_Desert_116.png"] forKey:@"T_Desert_116-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Desert_116-02" andCombatValue:4 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getDesertInstance] andFilename:@"T_Desert_116.png"] forKey:@"T_Desert_116-02"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Desert_117-01" andCombatValue:3 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getDesertInstance] andFilename:@"T_Desert_117.png"] forKey:@"T_Desert_117-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Desert_118-01" andCombatValue:1 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getDesertInstance] andFilename:@"T_Desert_118.png"] forKey:@"T_Desert_118-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Desert_118-02" andCombatValue:1 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getDesertInstance] andFilename:@"T_Desert_118.png"] forKey:@"T_Desert_118-02"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Desert_119-01" andCombatValue:4 andCombatType:[CombatType getMagicInstance] andTerrain:[Terrain getDesertInstance] andFilename:@"T_Desert_119.png"] forKey:@"T_Desert_119-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Desert_120-01" andCombatValue:4 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getDesertInstance] andFilename:@"T_Desert_120.png"] forKey:@"T_Desert_120-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Desert_122-01" andCombatValue:1 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getDesertInstance] andFilename:@"T_Desert_122.png"] forKey:@"T_Desert_122-01"];
    
    //Forest
    [creatures setObject:[[Creature alloc] initWithId:@"T_Forest_086-01" andCombatValue:2 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getForestInstance] andFilename:@"T_Forest_086.png"] forKey:@"T_Forest_086-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Forest_087-01" andCombatValue:2 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getForestInstance] andFilename:@"T_Forest_087.png"] forKey:@"T_Forest_087-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Forest_088-01" andCombatValue:3 andCombatType:[CombatType getMagicInstance] andTerrain:[Terrain getForestInstance] andFilename:@"T_Forest_088.png"] forKey:@"T_Forest_088-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Forest_089-01" andCombatValue:1 andCombatType:[CombatType getMagicInstance] andTerrain:[Terrain getForestInstance] andFilename:@"T_Forest_089.png"] forKey:@"T_Forest_089-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Forest_090-01" andCombatValue:4 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getForestInstance] andFilename:@"T_Forest_090.png"] forKey:@"T_Forest_090-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Forest_091-01" andCombatValue:2 andCombatType:[CombatType getRangeInstance] andTerrain:[Terrain getForestInstance] andFilename:@"T_Forest_091.png"] forKey:@"T_Forest_091-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Forest_091-02" andCombatValue:2 andCombatType:[CombatType getRangeInstance] andTerrain:[Terrain getForestInstance] andFilename:@"T_Forest_091.png"] forKey:@"T_Forest_091-02"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Forest_092-01" andCombatValue:3 andCombatType:[CombatType getRangeInstance] andTerrain:[Terrain getForestInstance] andFilename:@"T_Forest_092.png"] forKey:@"T_Forest_092-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Forest_093-01" andCombatValue:2 andCombatType:[CombatType getMagicInstance] andTerrain:[Terrain getForestInstance] andFilename:@"T_Forest_093.png"] forKey:@"T_Forest_093-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Forest_094-01" andCombatValue:2 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getForestInstance] andFilename:@"T_Forest_094.png"] forKey:@"T_Forest_094-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Forest_095-01" andCombatValue:1 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getForestInstance] andFilename:@"T_Forest_095.png"] forKey:@"T_Forest_095-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Forest_096-01" andCombatValue:4 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getForestInstance] andFilename:@"T_Forest_096.png"] forKey:@"T_Forest_096-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Forest_097-01" andCombatValue:4 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getForestInstance] andFilename:@"T_Forest_097.png"] forKey:@"T_Forest_097-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Forest_098-01" andCombatValue:5 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getForestInstance] andFilename:@"T_Forest_098.png"] forKey:@"T_Forest_098-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Forest_099-01" andCombatValue:3 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getForestInstance] andFilename:@"T_Forest_099.png"] forKey:@"T_Forest_099-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Forest_100-01" andCombatValue:2 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getForestInstance] andFilename:@"T_Forest_100.png"] forKey:@"T_Forest_100-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Forest_101-01" andCombatValue:2 andCombatType:[CombatType getRangeInstance] andTerrain:[Terrain getForestInstance] andFilename:@"T_Forest_101.png"] forKey:@"T_Forest_101-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Forest_102-01" andCombatValue:1 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getForestInstance] andFilename:@"T_Forest_102.png"] forKey:@"T_Forest_102-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Forest_102-02" andCombatValue:1 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getForestInstance] andFilename:@"T_Forest_102.png"] forKey:@"T_Forest_102-02"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Forest_103-01" andCombatValue:2 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getForestInstance] andFilename:@"T_Forest_103.png"] forKey:@"T_Forest_103-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Forest_104-01" andCombatValue:5 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getForestInstance] andFilename:@"T_Forest_104.png"] forKey:@"T_Forest_104-01"];
    
    //Frozen
    [creatures setObject:[[Creature alloc] initWithId:@"T_Frozen_Waste_051-01" andCombatValue:3 andCombatType:[CombatType getRangeInstance] andTerrain:[Terrain getFrozenInstance] andFilename:@"T_Frozen_Waste_051.png"] forKey:@"T_Frozen_Waste_051-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Frozen_Waste_052-01" andCombatValue:4 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getFrozenInstance] andFilename:@"T_Frozen_Waste_052.png"] forKey:@"T_Frozen_Waste_052-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Frozen_Waste_053-01" andCombatValue:1 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getFrozenInstance] andFilename:@"T_Frozen_Waste_053.png"] forKey:@"T_Frozen_Waste_053-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Frozen_Waste_054-01" andCombatValue:5 andCombatType:[CombatType getRangeInstance] andTerrain:[Terrain getFrozenInstance] andFilename:@"T_Frozen_Waste_054.png"] forKey:@"T_Frozen_Waste_054-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Frozen_Waste_055-01" andCombatValue:4 andCombatType:[CombatType getMagicInstance] andTerrain:[Terrain getFrozenInstance] andFilename:@"T_Frozen_Waste_055.png"] forKey:@"T_Frozen_Waste_055-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Frozen_Waste_056-01" andCombatValue:2 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getFrozenInstance] andFilename:@"T_Frozen_Waste_056.png"] forKey:@"T_Frozen_Waste_056-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Frozen_Waste_057-01" andCombatValue:2 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getFrozenInstance] andFilename:@"T_Frozen_Waste_057.png"] forKey:@"T_Frozen_Waste_057-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Frozen_Waste_057-02" andCombatValue:2 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getFrozenInstance] andFilename:@"T_Frozen_Waste_057.png"] forKey:@"T_Frozen_Waste_057-02"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Frozen_Waste_057-03" andCombatValue:2 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getFrozenInstance] andFilename:@"T_Frozen_Waste_057.png"] forKey:@"T_Frozen_Waste_057-03"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Frozen_Waste_057-04" andCombatValue:2 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getFrozenInstance] andFilename:@"T_Frozen_Waste_057.png"] forKey:@"T_Frozen_Waste_057-04"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Frozen_Waste_058-01" andCombatValue:5 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getFrozenInstance] andFilename:@"T_Frozen_Waste_058.png"] forKey:@"T_Frozen_Waste_058-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Frozen_Waste_059-01" andCombatValue:2 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getFrozenInstance] andFilename:@"T_Frozen_Waste_059.png"] forKey:@"T_Frozen_Waste_059-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Frozen_Waste_060-01" andCombatValue:3 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getFrozenInstance] andFilename:@"T_Frozen_Waste_060.png"] forKey:@"T_Frozen_Waste_060-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Frozen_Waste_061-01" andCombatValue:2 andCombatType:[CombatType getMagicInstance] andTerrain:[Terrain getFrozenInstance] andFilename:@"T_Frozen_Waste_061.png"] forKey:@"T_Frozen_Waste_061-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Frozen_Waste_062-01" andCombatValue:4 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getFrozenInstance] andFilename:@"T_Frozen_Waste_062.png"] forKey:@"T_Frozen_Waste_062-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Frozen_Waste_063-01" andCombatValue:5 andCombatType:[CombatType getMagicInstance] andTerrain:[Terrain getFrozenInstance] andFilename:@"T_Frozen_Waste_063.png"] forKey:@"T_Frozen_Waste_063-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Frozen_Waste_064-01" andCombatValue:3 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getFrozenInstance] andFilename:@"T_Frozen_Waste_064.png"] forKey:@"T_Frozen_Waste_064-01"];
    
    //Jungle
    [creatures setObject:[[Creature alloc] initWithId:@"T_Jungle_000-01" andCombatValue:4 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getJungleInstance] andFilename:@"T_Jungle_000.png"] forKey:@"T_Jungle_000-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Jungle_000-02" andCombatValue:4 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getJungleInstance] andFilename:@"T_Jungle_000.png"] forKey:@"T_Jungle_000-02"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Jungle_001-01" andCombatValue:4 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getJungleInstance] andFilename:@"T_Jungle_001.png"] forKey:@"T_Jungle_001-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Jungle_002-01" andCombatValue:2 andCombatType:[CombatType getRangeInstance] andTerrain:[Terrain getJungleInstance] andFilename:@"T_Jungle_002.png"] forKey:@"T_Jungle_002-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Jungle_002-02" andCombatValue:2 andCombatType:[CombatType getRangeInstance] andTerrain:[Terrain getJungleInstance] andFilename:@"T_Jungle_002.png"] forKey:@"T_Jungle_002-02"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Jungle_003-01" andCombatValue:6 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getJungleInstance] andFilename:@"T_Jungle_003.png"] forKey:@"T_Jungle_003-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Jungle_004-01" andCombatValue:2 andCombatType:[CombatType getRangeInstance] andTerrain:[Terrain getJungleInstance] andFilename:@"T_Jungle_004.png"] forKey:@"T_Jungle_004-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Jungle_005-01" andCombatValue:2 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getJungleInstance] andFilename:@"T_Jungle_005.png"] forKey:@"T_Jungle_005-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Jungle_006-01" andCombatValue:2 andCombatType:[CombatType getMagicInstance] andTerrain:[Terrain getJungleInstance] andFilename:@"T_Jungle_006.png"] forKey:@"T_Jungle_006-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Jungle_007-01" andCombatValue:1 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getJungleInstance] andFilename:@"T_Jungle_007.png"] forKey:@"T_Jungle_007-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Jungle_008-01" andCombatValue:2 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getJungleInstance] andFilename:@"T_Jungle_008.png"] forKey:@"T_Jungle_008-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Jungle_009-01" andCombatValue:5 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getJungleInstance] andFilename:@"T_Jungle_009.png"] forKey:@"T_Jungle_009-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Jungle_009-02" andCombatValue:5 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getJungleInstance] andFilename:@"T_Jungle_009.png"] forKey:@"T_Jungle_009-02"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Jungle_010-01" andCombatValue:3 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getJungleInstance] andFilename:@"T_Jungle_010.png"] forKey:@"T_Jungle_010-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Jungle_011-01" andCombatValue:3 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getJungleInstance] andFilename:@"T_Jungle_011.png"] forKey:@"T_Jungle_011-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Jungle_011-02" andCombatValue:3 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getJungleInstance] andFilename:@"T_Jungle_011.png"] forKey:@"T_Jungle_011-02"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Jungle_012-01" andCombatValue:2 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getJungleInstance] andFilename:@"T_Jungle_012.png"] forKey:@"T_Jungle_012-01"];
    
    //Mountains
    [creatures setObject:[[Creature alloc] initWithId:@"T_Mountains_034-01" andCombatValue:1 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getMountainInstance] andFilename:@"T_Mountains_034.png"] forKey:@"T_Mountains_034-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Mountains_034-02" andCombatValue:1 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getMountainInstance] andFilename:@"T_Mountains_034.png"] forKey:@"T_Mountains_034-02"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Mountains_035-01" andCombatValue:2 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getMountainInstance] andFilename:@"T_Mountains_035.png"] forKey:@"T_Mountains_035-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Mountains_036-01" andCombatValue:3 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getMountainInstance] andFilename:@"T_Mountains_036.png"] forKey:@"T_Mountains_036-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Mountains_037-01" andCombatValue:4 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getMountainInstance] andFilename:@"T_Mountains_037.png"] forKey:@"T_Mountains_037-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Mountains_038-01" andCombatValue:1 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getMountainInstance] andFilename:@"T_Mountains_038.png"] forKey:@"T_Mountains_038-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Mountains_038-02" andCombatValue:1 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getMountainInstance] andFilename:@"T_Mountains_038.png"] forKey:@"T_Mountains_038-02"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Mountains_038-03" andCombatValue:1 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getMountainInstance] andFilename:@"T_Mountains_038.png"] forKey:@"T_Mountains_038-03"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Mountains_038-04" andCombatValue:1 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getMountainInstance] andFilename:@"T_Mountains_038.png"] forKey:@"T_Mountains_038-04"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Mountains_039-01" andCombatValue:2 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getMountainInstance] andFilename:@"T_Mountains_039.png"] forKey:@"T_Mountains_039-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Mountains_040-01" andCombatValue:1 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getMountainInstance] andFilename:@"T_Mountains_040.png"] forKey:@"T_Mountains_040-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Mountains_041-01" andCombatValue:2 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getMountainInstance] andFilename:@"T_Mountains_041.png"] forKey:@"T_Mountains_041-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Mountains_042-01" andCombatValue:2 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getMountainInstance] andFilename:@"T_Mountains_042.png"] forKey:@"T_Mountains_042-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Mountains_043-01" andCombatValue:4 andCombatType:[CombatType getRangeInstance] andTerrain:[Terrain getMountainInstance] andFilename:@"T_Mountains_043.png"] forKey:@"T_Mountains_043-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Mountains_044-01" andCombatValue:3 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getMountainInstance] andFilename:@"T_Mountains_044.png"] forKey:@"T_Mountains_044-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Mountains_045-01" andCombatValue:3 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getMountainInstance] andFilename:@"T_Mountains_045.png"] forKey:@"T_Mountains_045-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Mountains_046-01" andCombatValue:4 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getMountainInstance] andFilename:@"T_Mountains_046.png"] forKey:@"T_Mountains_046-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Mountains_047-01" andCombatValue:2 andCombatType:[CombatType getRangeInstance] andTerrain:[Terrain getMountainInstance] andFilename:@"T_Mountains_047.png"] forKey:@"T_Mountains_047-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Mountains_048-01" andCombatValue:3 andCombatType:[CombatType getRangeInstance] andTerrain:[Terrain getMountainInstance] andFilename:@"T_Mountains_048.png"] forKey:@"T_Mountains_048-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Mountains_049-01" andCombatValue:3 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getMountainInstance] andFilename:@"T_Mountains_049.png"] forKey:@"T_Mountains_049-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Mountains_048-01" andCombatValue:5 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getMountainInstance] andFilename:@"T_Mountains_048.png"] forKey:@"T_Mountains_048-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Mountains_049-01" andCombatValue:3 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getMountainInstance] andFilename:@"T_Mountains_049.png"] forKey:@"T_Mountains_049-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Mountains_050-01" andCombatValue:5 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getMountainInstance] andFilename:@"T_Mountains_050.png"] forKey:@"T_Mountains_050-01"];
    
    //Plains
    [creatures setObject:[[Creature alloc] initWithId:@"T_Plains_013-01" andCombatValue:2 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getPlainesInstance] andFilename:@"T_Plains_013.png"] forKey:@"T_Plains_013-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Plains_014-01" andCombatValue:1 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getPlainesInstance] andFilename:@"T_Plains_014.png"] forKey:@"T_Plains_014-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Plains_014-02" andCombatValue:1 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getPlainesInstance] andFilename:@"T_Plains_014.png"] forKey:@"T_Plains_014-02"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Plains_014-03" andCombatValue:1 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getPlainesInstance] andFilename:@"T_Plains_014.png"] forKey:@"T_Plains_014-03"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Plains_014-04" andCombatValue:1 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getPlainesInstance] andFilename:@"T_Plains_014.png"] forKey:@"T_Plains_014-04"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Plains_015-01" andCombatValue:2 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getPlainesInstance] andFilename:@"T_Plains_015.png"] forKey:@"T_Plains_015-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Plains_016-01" andCombatValue:3 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getPlainesInstance] andFilename:@"T_Plains_016.png"] forKey:@"T_Plains_016-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Plains_017-01" andCombatValue:4 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getPlainesInstance] andFilename:@"T_Plains_017.png"] forKey:@"T_Plains_017-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Plains_018-01" andCombatValue:2 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getPlainesInstance] andFilename:@"T_Plains_018.png"] forKey:@"T_Plains_018-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Plains_019-01" andCombatValue:3 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getPlainesInstance] andFilename:@"T_Plains_019.png"] forKey:@"T_Plains_019-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Plains_020-01" andCombatValue:2 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getPlainesInstance] andFilename:@"T_Plains_020.png"] forKey:@"T_Plains_020-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Plains_021-01" andCombatValue:4 andCombatType:[CombatType getRangeInstance] andTerrain:[Terrain getPlainesInstance] andFilename:@"T_Plains_021.png"] forKey:@"T_Plains_021-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Plains_022-01" andCombatValue:1 andCombatType:[CombatType getRangeInstance] andTerrain:[Terrain getPlainesInstance] andFilename:@"T_Plains_022.png"] forKey:@"T_Plains_022-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Plains_023-01" andCombatValue:2 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getPlainesInstance] andFilename:@"T_Plains_023.png"] forKey:@"T_Plains_023-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Plains_024-01" andCombatValue:2 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getPlainesInstance] andFilename:@"T_Plains_024.png"] forKey:@"T_Plains_024-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Plains_025-01" andCombatValue:3 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getPlainesInstance] andFilename:@"T_Plains_025.png"] forKey:@"T_Plains_025-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Plains_026-01" andCombatValue:2 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getPlainesInstance] andFilename:@"T_Plains_026.png"] forKey:@"T_Plains_026-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Plains_027-01" andCombatValue:2 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getPlainesInstance] andFilename:@"T_Plains_027.png"] forKey:@"T_Plains_027-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Plains_027-02" andCombatValue:2 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getPlainesInstance] andFilename:@"T_Plains_027.png"] forKey:@"T_Plains_027-02"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Plains_028-01" andCombatValue:1 andCombatType:[CombatType getRangeInstance] andTerrain:[Terrain getPlainesInstance] andFilename:@"T_Plains_028.png"] forKey:@"T_Plains_028-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Plains_029-01" andCombatValue:3 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getPlainesInstance] andFilename:@"T_Plains_029.png"] forKey:@"T_Plains_029-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Plains_030-01" andCombatValue:3 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getPlainesInstance] andFilename:@"T_Plains_030.png"] forKey:@"T_Plains_030-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Plains_031-01" andCombatValue:2 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getPlainesInstance] andFilename:@"T_Plains_031.png"] forKey:@"T_Plains_031-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Plains_032-01" andCombatValue:1 andCombatType:[CombatType getMagicInstance] andTerrain:[Terrain getPlainesInstance] andFilename:@"T_Plains_032.png"] forKey:@"T_Plains_032-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Plains_033-01" andCombatValue:2 andCombatType:[CombatType getMagicInstance] andTerrain:[Terrain getPlainesInstance] andFilename:@"T_Plains_033.png"] forKey:@"T_Plains_033-01"];
    
    //Swamp
    [creatures setObject:[[Creature alloc] initWithId:@"T_Swamp_065-01" andCombatValue:3 andCombatType:[CombatType getMagicInstance] andTerrain:[Terrain getSwampInstance] andFilename:@"T_Swamp_065.png"] forKey:@"T_Swamp_065-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Swamp_066-01" andCombatValue:2 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getSwampInstance] andFilename:@"T_Swamp_066.png"] forKey:@"T_Swamp_066-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Swamp_067-01" andCombatValue:3 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getSwampInstance] andFilename:@"T_Swamp_067.png"] forKey:@"T_Swamp_067-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Swamp_068-01" andCombatValue:2 andCombatType:[CombatType getMagicInstance] andTerrain:[Terrain getSwampInstance] andFilename:@"T_Swamp_068.png"] forKey:@"T_Swamp_068-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Swamp_069-01" andCombatValue:1 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getSwampInstance] andFilename:@"T_Swamp_069.png"] forKey:@"T_Swamp_069-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Swamp_069-02" andCombatValue:1 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getSwampInstance] andFilename:@"T_Swamp_069.png"] forKey:@"T_Swamp_069-02"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Swamp_069-03" andCombatValue:1 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getSwampInstance] andFilename:@"T_Swamp_069.png"] forKey:@"T_Swamp_069-03"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Swamp_069-04" andCombatValue:1 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getSwampInstance] andFilename:@"T_Swamp_069.png"] forKey:@"T_Swamp_069-04"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Swamp_070-01" andCombatValue:1 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getSwampInstance] andFilename:@"T_Swamp_070.png"] forKey:@"T_Swamp_070-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Swamp_071-01" andCombatValue:2 andCombatType:[CombatType getMagicInstance] andTerrain:[Terrain getSwampInstance] andFilename:@"T_Swamp_071.png"] forKey:@"T_Swamp_071-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Swamp_072-01" andCombatValue:1 andCombatType:[CombatType getMagicInstance] andTerrain:[Terrain getSwampInstance] andFilename:@"T_Swamp_072.png"] forKey:@"T_Swamp_072-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Swamp_073-01" andCombatValue:2 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getSwampInstance] andFilename:@"T_Swamp_073.png"] forKey:@"T_Swamp_073-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Swamp_074-01" andCombatValue:2 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getSwampInstance] andFilename:@"T_Swamp_074.png"] forKey:@"T_Swamp_074-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Swamp_075-01" andCombatValue:2 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getSwampInstance] andFilename:@"T_Swamp_075.png"] forKey:@"T_Swamp_075-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Swamp_076-01" andCombatValue:2 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getSwampInstance] andFilename:@"T_Swamp_076.png"] forKey:@"T_Swamp_076-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Swamp_076-02" andCombatValue:2 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getSwampInstance] andFilename:@"T_Swamp_076.png"] forKey:@"T_Swamp_076-02"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Swamp_077-01" andCombatValue:2 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getSwampInstance] andFilename:@"T_Swamp_077.png"] forKey:@"T_Swamp_077-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Swamp_078-01" andCombatValue:3 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getSwampInstance] andFilename:@"T_Swamp_078.png"] forKey:@"T_Swamp_078-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Swamp_079-01" andCombatValue:3 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getSwampInstance] andFilename:@"T_Swamp_079.png"] forKey:@"T_Swamp_079-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Swamp_080-01" andCombatValue:3 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getSwampInstance] andFilename:@"T_Swamp_080.png"] forKey:@"T_Swamp_080-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Swamp_081-01" andCombatValue:1 andCombatType:[CombatType getMagicInstance] andTerrain:[Terrain getSwampInstance] andFilename:@"T_Swamp_081.png"] forKey:@"T_Swamp_081-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Swamp_082-01" andCombatValue:1 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getSwampInstance] andFilename:@"T_Swamp_082.png"] forKey:@"T_Swamp_082-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Swamp_083-01" andCombatValue:1 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getSwampInstance] andFilename:@"T_Swamp_083.png"] forKey:@"T_Swamp_083-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Swamp_084-01" andCombatValue:4 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getSwampInstance] andFilename:@"T_Swamp_084.png"] forKey:@"T_Swamp_084-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Swamp_085-01" andCombatValue:1 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getSwampInstance] andFilename:@"T_Swamp_085.png"] forKey:@"T_Swamp_085-01"];
    
    return creatures;
}

@end
