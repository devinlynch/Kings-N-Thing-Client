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


-(Creature*) initWithId:(NSString*) creatureId andCombatValue:(int) value andCombatType: (CombatType*) type andTerrain: (Terrain*) t andFilename: (NSString*) filename andName:(NSString *)name{
    self = [super init];
    
    _gamePieceId = [[NSString alloc] initWithString:creatureId];
    _combatValue = value;
    _combatType = type;
    _terrain = t;
    _pieceImage = [[ScaledGamePiece alloc] initWithContentsOfFile:filename andOwner:self];
    _fileName = [[NSString alloc] initWithString:filename];
    _bluffImage = [[ScaledGamePiece alloc] initWithContentsOfFile:@"T_Back.png" andOwner:self];
    [_bluffImage setVisible:NO];
    [_pieceImage addEventListener:@selector(creatureDoubleClick:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    _name = name;

    
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

-(void) bluff{
    [_bluffImage setVisible:YES];
}

-(void) unbluff{
    [_bluffImage setVisible:NO];
}



+(NSMutableDictionary*) initializeAllCreatures{
    NSMutableDictionary *creatures = [[NSMutableDictionary alloc] init];
    
    [creatures setObject:[[Creature alloc] initWithId:@"T_Desert_105-01" andCombatValue:4 andCombatType:[CombatType getMagicInstance] andTerrain:[Terrain getDesertInstance] andFilename:@"T_Desert_105.png" andName: @"AlterDrache"] forKey: @"T_Desert_105-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Desert_106-01" andCombatValue:3 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getDesertInstance] andFilename:@"T_Desert_106.png" andName: @"Babydrache"] forKey: @"T_Desert_106-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Desert_107-01" andCombatValue:1 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getDesertInstance] andFilename:@"T_Desert_107.png" andName: @"Bussard"] forKey: @"T_Desert_107-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Desert_108-01" andCombatValue:2 andCombatType:[CombatType getMagicInstance] andTerrain:[Terrain getDesertInstance] andFilename:@"T_Desert_108.png" andName: @"Derwisch"] forKey: @"T_Desert_108-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Desert_108-02" andCombatValue:2 andCombatType:[CombatType getMagicInstance] andTerrain:[Terrain getDesertInstance] andFilename:@"T_Desert_108.png" andName: @"Derwisch2"] forKey: @"T_Desert_108-02"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Desert_109-01" andCombatValue:4 andCombatType:[CombatType getMagicInstance] andTerrain:[Terrain getDesertInstance] andFilename:@"T_Desert_109.png" andName: @"Dschinn"] forKey: @"T_Desert_109-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Desert_110-01" andCombatValue:1 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getDesertInstance] andFilename:@"T_Desert_110.png" andName: @"Geier"] forKey: @"T_Desert_110-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Desert_111-01" andCombatValue:3 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getDesertInstance] andFilename:@"T_Desert_111.png" andName: @"GelberRitter"] forKey: @"T_Desert_111-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Desert_112-01" andCombatValue:2 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getDesertInstance] andFilename:@"T_Desert_112.png" andName: @"Greif"] forKey: @"T_Desert_112-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Desert_113-01" andCombatValue:3 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getDesertInstance] andFilename:@"T_Desert_113.png" andName: @"Kamelreiter"] forKey: @"T_Desert_113-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Desert_114-01" andCombatValue:1 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getDesertInstance] andFilename:@"T_Desert_114.png" andName: @"Nomade"] forKey: @"T_Desert_114-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Desert_114-02" andCombatValue:1 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getDesertInstance] andFilename:@"T_Desert_114.png" andName: @"Nomade2"] forKey: @"T_Desert_114-02"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Desert_115-01" andCombatValue:1 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getDesertInstance] andFilename:@"T_Desert_115.png" andName: @"Riesenspinne"] forKey: @"T_Desert_115-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Desert_116-01" andCombatValue:4 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getDesertInstance] andFilename:@"T_Desert_116.png" andName: @"Riesenwespe"] forKey: @"T_Desert_116-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Desert_116-02" andCombatValue:4 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getDesertInstance] andFilename:@"T_Desert_116.png" andName: @"Riesenwespe2"] forKey: @"T_Desert_116-02"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Desert_117-01" andCombatValue:3 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getDesertInstance] andFilename:@"T_Desert_117.png" andName: @"Sandwurm"] forKey: @"T_Desert_117-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Desert_118-01" andCombatValue:1 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getDesertInstance] andFilename:@"T_Desert_118.png" andName: @"Skelett"] forKey: @"T_Desert_118-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Desert_118-02" andCombatValue:1 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getDesertInstance] andFilename:@"T_Desert_118.png" andName: @"Skelett2"] forKey: @"T_Desert_118-02"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Desert_119-01" andCombatValue:4 andCombatType:[CombatType getMagicInstance] andTerrain:[Terrain getDesertInstance] andFilename:@"T_Desert_119.png" andName: @"Sphinx"] forKey: @"T_Desert_119-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Desert_120-01" andCombatValue:4 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getDesertInstance] andFilename:@"T_Desert_120.png" andName: @"Staubteufel"] forKey: @"T_Desert_120-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Desert_122-01" andCombatValue:1 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getDesertInstance] andFilename:@"T_Desert_122.png" andName: @"W¸stenfledermaus"] forKey: @"T_Desert_122-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Forest_086-01" andCombatValue:2 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getForestInstance] andFilename:@"T_Forest_086.png" andName: @"Banditen"] forKey: @"T_Forest_086-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Forest_087-01" andCombatValue:2 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getForestInstance] andFilename:@"T_Forest_087.png" andName: @"B‰ren"] forKey: @"T_Forest_087-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Forest_088-01" andCombatValue:3 andCombatType:[CombatType getMagicInstance] andTerrain:[Terrain getForestInstance] andFilename:@"T_Forest_088.png" andName: @"Druide"] forKey: @"T_Forest_088-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Forest_089-01" andCombatValue:1 andCombatType:[CombatType getMagicInstance] andTerrain:[Terrain getForestInstance] andFilename:@"T_Forest_089.png" andName: @"Dryade"] forKey: @"T_Forest_089-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Forest_090-01" andCombatValue:4 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getForestInstance] andFilename:@"T_Forest_090.png" andName: @"Einhorn"] forKey: @"T_Forest_090-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Forest_091-01" andCombatValue:2 andCombatType:[CombatType getRangeInstance] andTerrain:[Terrain getForestInstance] andFilename:@"T_Forest_091.png" andName: @"Elf"] forKey: @"T_Forest_091-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Forest_091-02" andCombatValue:2 andCombatType:[CombatType getRangeInstance] andTerrain:[Terrain getForestInstance] andFilename:@"T_Forest_091.png" andName: @"Elf2"] forKey: @"T_Forest_091-02"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Forest_092-01" andCombatValue:3 andCombatType:[CombatType getRangeInstance] andTerrain:[Terrain getForestInstance] andFilename:@"T_Forest_092.png" andName: @"Elf3"] forKey: @"T_Forest_092-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Forest_093-01" andCombatValue:2 andCombatType:[CombatType getMagicInstance] andTerrain:[Terrain getForestInstance] andFilename:@"T_Forest_093.png" andName: @"Elfenmagier"] forKey: @"T_Forest_093-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Forest_094-01" andCombatValue:2 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getForestInstance] andFilename:@"T_Forest_094.png" andName: @"Flugeichhˆrnchen"] forKey: @"T_Forest_094-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Forest_095-01" andCombatValue:1 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getForestInstance] andFilename:@"T_Forest_095.png" andName: @"Flugeichhˆrnchen2"] forKey: @"T_Forest_095-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Forest_096-01" andCombatValue:4 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getForestInstance] andFilename:@"T_Forest_096.png" andName: @"Groﬂeule"] forKey: @"T_Forest_096-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Forest_097-01" andCombatValue:4 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getForestInstance] andFilename:@"T_Forest_097.png" andName: @"Gr¸nerRitter"] forKey: @"T_Forest_097-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Forest_098-01" andCombatValue:5 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getForestInstance] andFilename:@"T_Forest_098.png" andName: @"Laufbaum"] forKey: @"T_Forest_098-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Forest_099-01" andCombatValue:3 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getForestInstance] andFilename:@"T_Forest_099.png" andName: @"Lindwurm"] forKey: @"T_Forest_099-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Forest_100-01" andCombatValue:2 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getForestInstance] andFilename:@"T_Forest_100.png" andName: @"Mˆrderwaschb‰r"] forKey: @"T_Forest_100-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Forest_101-01" andCombatValue:2 andCombatType:[CombatType getRangeInstance] andTerrain:[Terrain getForestInstance] andFilename:@"T_Forest_101.png" andName: @"Waldl‰ufer"] forKey: @"T_Forest_101-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Forest_102-01" andCombatValue:1 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getForestInstance] andFilename:@"T_Forest_102.png" andName: @"Wichtelmann"] forKey: @"T_Forest_102-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Forest_102-02" andCombatValue:1 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getForestInstance] andFilename:@"T_Forest_102.png" andName: @"Wichtelmann2"] forKey: @"T_Forest_102-02"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Forest_103-01" andCombatValue:2 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getForestInstance] andFilename:@"T_Forest_103.png" andName: @"Wildkatze"] forKey: @"T_Forest_103-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Forest_104-01" andCombatValue:5 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getForestInstance] andFilename:@"T_Forest_104.png" andName: @"Yeti"] forKey: @"T_Forest_104-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Frozen_Waste_051-01" andCombatValue:3 andCombatType:[CombatType getRangeInstance] andTerrain:[Terrain getFrozenInstance] andFilename:@"T_Frozen_Waste_051.png" andName: @"Drachenreiter"] forKey: @"T_Frozen_Waste_051-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Frozen_Waste_052-01" andCombatValue:4 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getFrozenInstance] andFilename:@"T_Frozen_Waste_052.png" andName: @"Eisb‰r"] forKey: @"T_Frozen_Waste_052-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Frozen_Waste_053-01" andCombatValue:1 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getFrozenInstance] andFilename:@"T_Frozen_Waste_053.png" andName: @"Eisfledermaus"] forKey: @"T_Frozen_Waste_053-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Frozen_Waste_054-01" andCombatValue:5 andCombatType:[CombatType getRangeInstance] andTerrain:[Terrain getFrozenInstance] andFilename:@"T_Frozen_Waste_054.png" andName: @"Eisriese"] forKey: @"T_Frozen_Waste_054-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Frozen_Waste_055-01" andCombatValue:4 andCombatType:[CombatType getMagicInstance] andTerrain:[Terrain getFrozenInstance] andFilename:@"T_Frozen_Waste_055.png" andName: @"Eiswurm"] forKey: @"T_Frozen_Waste_055-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Frozen_Waste_056-01" andCombatValue:2 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getFrozenInstance] andFilename:@"T_Frozen_Waste_056.png" andName: @"Elchherde"] forKey: @"T_Frozen_Waste_056-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Frozen_Waste_057-01" andCombatValue:2 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getFrozenInstance] andFilename:@"T_Frozen_Waste_057.png" andName: @"Eskimo"] forKey: @"T_Frozen_Waste_057-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Frozen_Waste_057-02" andCombatValue:2 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getFrozenInstance] andFilename:@"T_Frozen_Waste_057.png" andName: @"Eskimo2"] forKey: @"T_Frozen_Waste_057-02"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Frozen_Waste_057-03" andCombatValue:2 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getFrozenInstance] andFilename:@"T_Frozen_Waste_057.png" andName: @"Eskimo3"] forKey: @"T_Frozen_Waste_057-03"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Frozen_Waste_057-04" andCombatValue:2 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getFrozenInstance] andFilename:@"T_Frozen_Waste_057.png" andName: @"Eskimo4"] forKey: @"T_Frozen_Waste_057-04"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Frozen_Waste_058-01" andCombatValue:5 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getFrozenInstance] andFilename:@"T_Frozen_Waste_058.png" andName: @"Mammut"] forKey: @"T_Frozen_Waste_058-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Frozen_Waste_059-01" andCombatValue:2 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getFrozenInstance] andFilename:@"T_Frozen_Waste_059.png" andName: @"Mˆrderpapageientaucher"] forKey: @"T_Frozen_Waste_059-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Frozen_Waste_060-01" andCombatValue:3 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getFrozenInstance] andFilename:@"T_Frozen_Waste_060.png" andName: @"Mˆrderpinguin"] forKey: @"T_Frozen_Waste_060-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Frozen_Waste_061-01" andCombatValue:2 andCombatType:[CombatType getMagicInstance] andTerrain:[Terrain getFrozenInstance] andFilename:@"T_Frozen_Waste_061.png" andName: @"Nordwind"] forKey: @"T_Frozen_Waste_061-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Frozen_Waste_062-01" andCombatValue:4 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getFrozenInstance] andFilename:@"T_Frozen_Waste_062.png" andName: @"Walroﬂ"] forKey: @"T_Frozen_Waste_062-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Frozen_Waste_063-01" andCombatValue:5 andCombatType:[CombatType getMagicInstance] andTerrain:[Terrain getFrozenInstance] andFilename:@"T_Frozen_Waste_063.png" andName: @"WeiﬂerDrachen"] forKey: @"T_Frozen_Waste_063-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Frozen_Waste_064-01" andCombatValue:3 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getFrozenInstance] andFilename:@"T_Frozen_Waste_064.png" andName: @"Wolf"] forKey: @"T_Frozen_Waste_064-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Jungle_000-01" andCombatValue:4 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getJungleInstance] andFilename:@"T_Jungle_000.png" andName: @"Dinosaurier"] forKey: @"T_Jungle_000-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Jungle_000-02" andCombatValue:4 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getJungleInstance] andFilename:@"T_Jungle_000.png" andName: @"Dinosaurier2"] forKey: @"T_Jungle_000-02"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Jungle_001-01" andCombatValue:4 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getJungleInstance] andFilename:@"T_Jungle_001.png" andName: @"Elefant"] forKey: @"T_Jungle_001-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Jungle_002-01" andCombatValue:2 andCombatType:[CombatType getRangeInstance] andTerrain:[Terrain getJungleInstance] andFilename:@"T_Jungle_002.png" andName: @"Flugsaurierkrieger"] forKey: @"T_Jungle_002-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Jungle_002-02" andCombatValue:2 andCombatType:[CombatType getRangeInstance] andTerrain:[Terrain getJungleInstance] andFilename:@"T_Jungle_002.png" andName: @"Flugsaurierkrieger2"] forKey: @"T_Jungle_002-02"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Jungle_003-01" andCombatValue:6 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getJungleInstance] andFilename:@"T_Jungle_003.png" andName: @"Kletterranken"] forKey: @"T_Jungle_003-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Jungle_004-01" andCombatValue:2 andCombatType:[CombatType getRangeInstance] andTerrain:[Terrain getJungleInstance] andFilename:@"T_Jungle_004.png" andName: @"Kopfj‰ger"] forKey: @"T_Jungle_004-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Jungle_005-01" andCombatValue:2 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getJungleInstance] andFilename:@"T_Jungle_005.png" andName: @"Krokodile"] forKey: @"T_Jungle_005-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Jungle_006-01" andCombatValue:2 andCombatType:[CombatType getMagicInstance] andTerrain:[Terrain getJungleInstance] andFilename:@"T_Jungle_006.png" andName: @"Medizinmann"] forKey: @"T_Jungle_006-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Jungle_007-01" andCombatValue:1 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getJungleInstance] andFilename:@"T_Jungle_007.png" andName: @"Paradiesvogel"] forKey: @"T_Jungle_007-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Jungle_008-01" andCombatValue:2 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getJungleInstance] andFilename:@"T_Jungle_008.png" andName: @"Pygm‰e"] forKey: @"T_Jungle_008-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Jungle_009-01" andCombatValue:5 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getJungleInstance] andFilename:@"T_Jungle_009.png" andName: @"Riesenaffe"] forKey: @"T_Jungle_009-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Jungle_009-02" andCombatValue:5 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getJungleInstance] andFilename:@"T_Jungle_009.png" andName: @"Riesenaffe2"] forKey: @"T_Jungle_009-02"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Jungle_010-01" andCombatValue:3 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getJungleInstance] andFilename:@"T_Jungle_010.png" andName: @"Riesenschlange"] forKey: @"T_Jungle_010-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Jungle_011-01" andCombatValue:3 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getJungleInstance] andFilename:@"T_Jungle_011.png" andName: @"Tiger"] forKey: @"T_Jungle_011-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Jungle_011-02" andCombatValue:3 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getJungleInstance] andFilename:@"T_Jungle_011.png" andName: @"Tiger2"] forKey: @"T_Jungle_011-02"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Jungle_012-01" andCombatValue:2 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getJungleInstance] andFilename:@"T_Jungle_012.png" andName: @"Watussi"] forKey: @"T_Jungle_012-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Mountains_034-01" andCombatValue:1 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getMountainInstance] andFilename:@"T_Mountains_034.png" andName: @"Bergbewohner"] forKey: @"T_Mountains_034-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Mountains_034-02" andCombatValue:1 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getMountainInstance] andFilename:@"T_Mountains_034.png" andName: @"Bergbewohner2"] forKey: @"T_Mountains_034-02"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Mountains_035-01" andCombatValue:2 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getMountainInstance] andFilename:@"T_Mountains_035.png" andName: @"Berglˆwe"] forKey: @"T_Mountains_035-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Mountains_036-01" andCombatValue:3 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getMountainInstance] andFilename:@"T_Mountains_036.png" andName: @"BraunerDrache"] forKey: @"T_Mountains_036-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Mountains_037-01" andCombatValue:4 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getMountainInstance] andFilename:@"T_Mountains_037.png" andName: @"BraunerRitter"] forKey: @"T_Mountains_037-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Mountains_038-01" andCombatValue:1 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getMountainInstance] andFilename:@"T_Mountains_038.png" andName: @"Goblin"] forKey: @"T_Mountains_038-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Mountains_038-02" andCombatValue:1 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getMountainInstance] andFilename:@"T_Mountains_038.png" andName: @"Goblin2"] forKey: @"T_Mountains_038-02"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Mountains_038-03" andCombatValue:1 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getMountainInstance] andFilename:@"T_Mountains_038.png" andName: @"Goblin3"] forKey: @"T_Mountains_038-03"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Mountains_038-04" andCombatValue:1 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getMountainInstance] andFilename:@"T_Mountains_038.png" andName: @"Goblin4"] forKey: @"T_Mountains_038-04"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Mountains_039-01" andCombatValue:2 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getMountainInstance] andFilename:@"T_Mountains_039.png" andName: @"Groﬂadler"] forKey: @"T_Mountains_039-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Mountains_040-01" andCombatValue:1 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getMountainInstance] andFilename:@"T_Mountains_040.png" andName: @"Groﬂfalke"] forKey: @"T_Mountains_040-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Mountains_041-01" andCombatValue:2 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getMountainInstance] andFilename:@"T_Mountains_041.png" andName: @"KleinerRockvogel"] forKey: @"T_Mountains_041-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Mountains_042-01" andCombatValue:2 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getMountainInstance] andFilename:@"T_Mountains_042.png" andName: @"Oger"] forKey: @"T_Mountains_042-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Mountains_043-01" andCombatValue:4 andCombatType:[CombatType getRangeInstance] andTerrain:[Terrain getMountainInstance] andFilename:@"T_Mountains_043.png" andName: @"Riese"] forKey: @"T_Mountains_043-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Mountains_044-01" andCombatValue:3 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getMountainInstance] andFilename:@"T_Mountains_044.png" andName: @"Riesenkondor"] forKey: @"T_Mountains_044-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Mountains_045-01" andCombatValue:3 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getMountainInstance] andFilename:@"T_Mountains_045.png" andName: @"Riesenrockvogel"] forKey: @"T_Mountains_045-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Mountains_046-01" andCombatValue:4 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getMountainInstance] andFilename:@"T_Mountains_046.png" andName: @"Troll"] forKey: @"T_Mountains_046-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Mountains_047-01" andCombatValue:2 andCombatType:[CombatType getRangeInstance] andTerrain:[Terrain getMountainInstance] andFilename:@"T_Mountains_047.png" andName: @"Zwerg"] forKey: @"T_Mountains_047-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Mountains_048-01" andCombatValue:3 andCombatType:[CombatType getRangeInstance] andTerrain:[Terrain getMountainInstance] andFilename:@"T_Mountains_048.png" andName: @"Zwerg2"] forKey: @"T_Mountains_048-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Mountains_049-01" andCombatValue:3 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getMountainInstance] andFilename:@"T_Mountains_049.png" andName: @"Zwerg3"] forKey: @"T_Mountains_049-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Mountains_048-01" andCombatValue:5 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getMountainInstance] andFilename:@"T_Mountains_048.png" andName: @"Zwerg2"] forKey: @"T_Mountains_048-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Mountains_049-01" andCombatValue:3 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getMountainInstance] andFilename:@"T_Mountains_049.png" andName: @"Zwerg3"] forKey: @"T_Mountains_049-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Mountains_050-01" andCombatValue:5 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getMountainInstance] andFilename:@"T_Mountains_050.png" andName: @"Zyklop"] forKey: @"T_Mountains_050-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Plains_013-01" andCombatValue:2 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getPlainesInstance] andFilename:@"T_Plains_013.png" andName: @"Adler"] forKey: @"T_Plains_013-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Plains_014-01" andCombatValue:1 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getPlainesInstance] andFilename:@"T_Plains_014.png" andName: @"Bauer"] forKey: @"T_Plains_014-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Plains_014-02" andCombatValue:1 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getPlainesInstance] andFilename:@"T_Plains_014.png" andName: @"Bauer2"] forKey: @"T_Plains_014-02"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Plains_014-03" andCombatValue:1 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getPlainesInstance] andFilename:@"T_Plains_014.png" andName: @"Bauer3"] forKey: @"T_Plains_014-03"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Plains_014-04" andCombatValue:1 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getPlainesInstance] andFilename:@"T_Plains_014.png" andName: @"Bauer4"] forKey: @"T_Plains_014-04"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Plains_015-01" andCombatValue:2 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getPlainesInstance] andFilename:@"T_Plains_015.png" andName: @"Bˆsewicht"] forKey: @"T_Plains_015-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Plains_016-01" andCombatValue:3 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getPlainesInstance] andFilename:@"T_Plains_016.png" andName: @"B¸ffelherde"] forKey: @"T_Plains_016-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Plains_017-01" andCombatValue:4 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getPlainesInstance] andFilename:@"T_Plains_017.png" andName: @"B¸ffelherde2"] forKey: @"T_Plains_017-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Plains_018-01" andCombatValue:2 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getPlainesInstance] andFilename:@"T_Plains_018.png" andName: @"Flugb¸ffel"] forKey: @"T_Plains_018-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Plains_019-01" andCombatValue:3 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getPlainesInstance] andFilename:@"T_Plains_019.png" andName: @"Flugsaurier"] forKey: @"T_Plains_019-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Plains_020-01" andCombatValue:2 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getPlainesInstance] andFilename:@"T_Plains_020.png" andName: @"Groﬂfalke"] forKey: @"T_Plains_020-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Plains_021-01" andCombatValue:4 andCombatType:[CombatType getRangeInstance] andTerrain:[Terrain getPlainesInstance] andFilename:@"T_Plains_021.png" andName: @"Groﬂj‰ger"] forKey: @"T_Plains_021-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Plains_022-01" andCombatValue:1 andCombatType:[CombatType getRangeInstance] andTerrain:[Terrain getPlainesInstance] andFilename:@"T_Plains_022.png" andName: @"J‰ger"] forKey: @"T_Plains_022-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Plains_023-01" andCombatValue:2 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getPlainesInstance] andFilename:@"T_Plains_023.png" andName: @"Libelle"] forKey: @"T_Plains_023-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Plains_024-01" andCombatValue:2 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getPlainesInstance] andFilename:@"T_Plains_024.png" andName: @"Pegasus"] forKey: @"T_Plains_024-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Plains_025-01" andCombatValue:3 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getPlainesInstance] andFilename:@"T_Plains_025.png" andName: @"Prachtlˆwe"] forKey: @"T_Plains_025-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Plains_026-01" andCombatValue:2 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getPlainesInstance] andFilename:@"T_Plains_026.png" andName: @"Riesenk‰fer"] forKey: @"T_Plains_026-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Plains_027-01" andCombatValue:2 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getPlainesInstance] andFilename:@"T_Plains_027.png" andName: @"Stammeskrieger"] forKey: @"T_Plains_027-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Plains_027-02" andCombatValue:2 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getPlainesInstance] andFilename:@"T_Plains_027.png" andName: @"Stammeskrieger2"] forKey: @"T_Plains_027-02"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Plains_028-01" andCombatValue:1 andCombatType:[CombatType getRangeInstance] andTerrain:[Terrain getPlainesInstance] andFilename:@"T_Plains_028.png" andName: @"Stammeskrieger3"] forKey: @"T_Plains_028-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Plains_029-01" andCombatValue:3 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getPlainesInstance] andFilename:@"T_Plains_029.png" andName: @"WeiﬂerRitter"] forKey: @"T_Plains_029-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Plains_030-01" andCombatValue:3 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getPlainesInstance] andFilename:@"T_Plains_030.png" andName: @"Wolfsmeute"] forKey: @"T_Plains_030-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Plains_031-01" andCombatValue:2 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getPlainesInstance] andFilename:@"T_Plains_031.png" andName: @"Zentaur"] forKey: @"T_Plains_031-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Plains_032-01" andCombatValue:1 andCombatType:[CombatType getMagicInstance] andTerrain:[Terrain getPlainesInstance] andFilename:@"T_Plains_032.png" andName: @"Zigeuner"] forKey: @"T_Plains_032-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Plains_033-01" andCombatValue:2 andCombatType:[CombatType getMagicInstance] andTerrain:[Terrain getPlainesInstance] andFilename:@"T_Plains_033.png" andName: @"Zigeuner2"] forKey: @"T_Plains_033-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Swamp_065-01" andCombatValue:3 andCombatType:[CombatType getMagicInstance] andTerrain:[Terrain getSwampInstance] andFilename:@"T_Swamp_065.png" andName: @"Basilisk"] forKey: @"T_Swamp_065-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Swamp_066-01" andCombatValue:2 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getSwampInstance] andFilename:@"T_Swamp_066.png" andName: @"Ding"] forKey: @"T_Swamp_066-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Swamp_067-01" andCombatValue:3 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getSwampInstance] andFilename:@"T_Swamp_067.png" andName: @"Flugpiranha"] forKey: @"T_Swamp_067-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Swamp_068-01" andCombatValue:2 andCombatType:[CombatType getMagicInstance] andTerrain:[Terrain getSwampInstance] andFilename:@"T_Swamp_068.png" andName: @"Geist"] forKey: @"T_Swamp_068-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Swamp_069-01" andCombatValue:1 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getSwampInstance] andFilename:@"T_Swamp_069.png" andName: @"Gespenst"] forKey: @"T_Swamp_069-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Swamp_069-02" andCombatValue:1 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getSwampInstance] andFilename:@"T_Swamp_069.png" andName: @"Gespenst2"] forKey: @"T_Swamp_069-02"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Swamp_069-03" andCombatValue:1 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getSwampInstance] andFilename:@"T_Swamp_069.png" andName: @"Gespenst3"] forKey: @"T_Swamp_069-03"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Swamp_069-04" andCombatValue:1 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getSwampInstance] andFilename:@"T_Swamp_069.png" andName: @"Gespenst4"] forKey: @"T_Swamp_069-04"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Swamp_070-01" andCombatValue:1 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getSwampInstance] andFilename:@"T_Swamp_070.png" andName: @"Giftfrosch"] forKey: @"T_Swamp_070-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Swamp_071-01" andCombatValue:2 andCombatType:[CombatType getMagicInstance] andTerrain:[Terrain getSwampInstance] andFilename:@"T_Swamp_071.png" andName: @"Irrlicht"] forKey: @"T_Swamp_071-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Swamp_072-01" andCombatValue:1 andCombatType:[CombatType getMagicInstance] andTerrain:[Terrain getSwampInstance] andFilename:@"T_Swamp_072.png" andName: @"Kobold"] forKey: @"T_Swamp_072-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Swamp_073-01" andCombatValue:2 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getSwampInstance] andFilename:@"T_Swamp_073.png" andName: @"Krokodile"] forKey: @"T_Swamp_073-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Swamp_074-01" andCombatValue:2 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getSwampInstance] andFilename:@"T_Swamp_074.png" andName: @"Piraten"] forKey: @"T_Swamp_074-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Swamp_075-01" andCombatValue:2 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getSwampInstance] andFilename:@"T_Swamp_075.png" andName: @"Riesenblutegel"] forKey: @"T_Swamp_075-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Swamp_076-01" andCombatValue:2 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getSwampInstance] andFilename:@"T_Swamp_076.png" andName: @"Riesenechse"] forKey: @"T_Swamp_076-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Swamp_076-02" andCombatValue:2 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getSwampInstance] andFilename:@"T_Swamp_076.png" andName: @"Riesenechse2"] forKey: @"T_Swamp_076-02"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Swamp_077-01" andCombatValue:2 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getSwampInstance] andFilename:@"T_Swamp_077.png" andName: @"Riesenmoskito"] forKey: @"T_Swamp_077-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Swamp_078-01" andCombatValue:3 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getSwampInstance] andFilename:@"T_Swamp_078.png" andName: @"Riesenschlange"] forKey: @"T_Swamp_078-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Swamp_079-01" andCombatValue:3 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getSwampInstance] andFilename:@"T_Swamp_079.png" andName: @"Schleimbestie"] forKey: @"T_Swamp_079-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Swamp_080-01" andCombatValue:3 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getSwampInstance] andFilename:@"T_Swamp_080.png" andName: @"SchwartzeRitter"] forKey: @"T_Swamp_080-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Swamp_081-01" andCombatValue:1 andCombatType:[CombatType getMagicInstance] andTerrain:[Terrain getSwampInstance] andFilename:@"T_Swamp_081.png" andName: @"Schwarzmagier"] forKey: @"T_Swamp_081-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Swamp_082-01" andCombatValue:1 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getSwampInstance] andFilename:@"T_Swamp_082.png" andName: @"Sumpfgas"] forKey: @"T_Swamp_082-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Swamp_083-01" andCombatValue:1 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getSwampInstance] andFilename:@"T_Swamp_083.png" andName: @"Sumpfratte"] forKey: @"T_Swamp_083-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Swamp_084-01" andCombatValue:4 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getSwampInstance] andFilename:@"T_Swamp_084.png" andName: @"Vampirfledermaus"] forKey: @"T_Swamp_084-01"];
    [creatures setObject:[[Creature alloc] initWithId:@"T_Swamp_085-01" andCombatValue:1 andCombatType:[CombatType getMeleeInstance] andTerrain:[Terrain getSwampInstance] andFilename:@"T_Swamp_085.png" andName: @"Wasserschlange"] forKey: @"T_Swamp_085-01"];



    
    return creatures;
}

@end
