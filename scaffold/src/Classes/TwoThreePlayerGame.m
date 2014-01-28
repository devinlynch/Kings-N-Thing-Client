//
//  TwoThreePlayerGame.m
//  3004iPhone
//
//  Created by Richard Ison on 1/13/2014.
//
//

#import "TwoThreePlayerGame.h"
#import "TouchSheet.h"
#import "Scene.h"
#import "TileMenu.h"
#import "ScaledGamePiece.h"


// --- private interface ---------------------------------------------------------------------------

@interface TwoThreePlayerGame ()

- (void)setup;
- (void)onResize:(SPResizeEvent *)event;
- (void)showScene:(SPSprite *)scene;

@end


// --- class implementation ------------------------------------------------------------------------

@implementation TwoThreePlayerGame
{
    NSMutableArray *gamePieces;
    
    SPSprite *_currentScene;
    SPSprite *_contents;
    
    
    int _gameWidth;
    int _gameHeight;
    
    
    //Tiles
    SPImage *_backTile;
    SPImage *_seaTile;
    SPImage *_desertTile;
    SPImage *_forestTile;
    SPImage *_mountainTile;
    SPImage *_swampTile;
    SPImage *_frozenTile;
    SPImage *_jungleTile;
    SPImage *_plainesTile;
    
    //Other images
    SPImage *_rack;
    SPImage *_bowl;
    SPImage *_dice;
    SPImage *_creatureDice;
    SPTextField *_bankText;
    
    //TouchSheet
    TouchSheet *_sheet;
    
    
    //Gold
    ScaledGamePiece *gold_01;
    ScaledGamePiece *gold_02;
    ScaledGamePiece *gold_05;
    ScaledGamePiece *gold_10;
    ScaledGamePiece *gold_15;
    ScaledGamePiece *gold_20;
    
    //Jungle --- terrain-name-combat-symbol(s)-counter
    //           f = flying
    //           r = ranged
    //           c = charge in combat
    //           m = magic
    //           s = special ability
    
    ScaledGamePiece *jungle_dinosaur_4_000;
    ScaledGamePiece *jungle_elephant_4_001;
    ScaledGamePiece *jungle_flugsaurier_2_fr_002;
    ScaledGamePiece *jungle_kletterranken_6_003;
    ScaledGamePiece *jungle_kopfjager_2_r_004;
    ScaledGamePiece *jungle_krokodile_2_005;
    ScaledGamePiece *jungle_medizinmann_2_star_006;
    ScaledGamePiece *jungle_paradiesvogel_1_f_007;
    ScaledGamePiece *jungle_pygmae_2_008;
    ScaledGamePiece *jungle_riesenaffe_5_009;
    ScaledGamePiece *jungle_riesenschlange_3_010;
    ScaledGamePiece *jungle_tiger_3_011;
    ScaledGamePiece *jungle_watussi_2_012;
    
    //Plains --- terrain-name-combat-symbol(s)-counter
    //           f = flying
    //           r = ranged
    //           c = charge in combat
    //           m = magic
    //           s = special ability
    ScaledGamePiece *plains_alder_2_013;
    ScaledGamePiece *plains_bauer_1_014;
    ScaledGamePiece *plains_bosewicht_2_015;
    ScaledGamePiece *plains_buffelherde_3_016;
    ScaledGamePiece *plains_buffelherde_4_017;
    ScaledGamePiece *plains_flugbuffel_2_f_018;
    ScaledGamePiece *plains_flugsaurier_3_f_019;
    ScaledGamePiece *plains_grobfalke_2_f_020;
    ScaledGamePiece *plains_grobjager_4_r_021;
    ScaledGamePiece *plains_jager_1_r_022;
    ScaledGamePiece *plains_libelle_2_f_023;
    ScaledGamePiece *plains_pegasus_2_f_024;
    ScaledGamePiece *plains_prachtlowe_3_025;
    ScaledGamePiece *plains_riesenkafer_2_f_026;
    ScaledGamePiece *plains_stammeskrieger_2_027;
    ScaledGamePiece *plains_stammeskrieger_1_f_028;
    ScaledGamePiece *plains_weiberritter_3_c_029;
    ScaledGamePiece *plains_wolfsmeute_3_030;
    ScaledGamePiece *plains_zentaur_2_031;
    ScaledGamePiece *plains_zigeuner_1_m_032;
    ScaledGamePiece *plains_zigeuner_2_m_033;
    
    //Mountains --- terrain-name-combat-symbol(s)-counter
    //           f = flying
    //           r = ranged
    //           c = charge in combat
    //           m = magic
    //           s = special ability
    ScaledGamePiece *mountain_bergbewohner_1_034;
    ScaledGamePiece *mounatin_berglowe_2_035;
    ScaledGamePiece *mountain_braunerdrache_3_f_036;
    ScaledGamePiece *mountain_braunerritter_4_c_037;
    ScaledGamePiece *mountain_golin_1_038;
    ScaledGamePiece *mountain_grobadler_2_f_039;
    ScaledGamePiece *mountain_grobfalke_1_f_040;
    ScaledGamePiece *mountain_kleunerrockvogel_2_f_041;
    ScaledGamePiece *mountain_oger_2_042;
    ScaledGamePiece *mountain_riese_4_r_043;
    ScaledGamePiece *mountain_riesenkomdor_3_f_044;
    ScaledGamePiece *mountain_riesenrockvogel_3_f_045;
    ScaledGamePiece *mountain_troll_4_046;
    ScaledGamePiece *mountain_zwerg_2_r_047;
    ScaledGamePiece *mountain_zwerg_3_r_048;
    ScaledGamePiece *mountain_zwerg_3_c_049;
    ScaledGamePiece *mountain_zyklop_5_050;
    
    //Frozen waste --- terrain-name-combat-symbol(s)-counter
    //           f = flying
    //           r = ranged
    //           c = charge in combat
    //           m = magic
    //           s = special ability
    ScaledGamePiece *frozen_drachenrelter_3_rf_051;
    ScaledGamePiece *frozen_eisbar_4_052;
    ScaledGamePiece *frozen_eisfledermaus_1_f_053;
    ScaledGamePiece *frozen_eisriese_5_r_054;
    ScaledGamePiece *frozen_eiswurm_4_m_055;
    ScaledGamePiece *frozen_elcherde_2_056;
    ScaledGamePiece *frozen_eskimo_2_057;
    ScaledGamePiece *frozen_mammut_5_c_058;
    ScaledGamePiece *frozen_mordepapgeientaucher_2_f_059;
    ScaledGamePiece *frozen_morderpinguin_3_060;
    ScaledGamePiece *frozen_nordwind_2_fm_061;
    ScaledGamePiece *frozen_warlrob_4_062;
    ScaledGamePiece *frozen_weiberdrachen_5_m_063;
    ScaledGamePiece *frozen_wolf_3_064;
    
    
    //Swamp --- terrain-name-combat-symbol(s)-counter
    //           f = flying
    //           r = ranged
    //           c = charge in combat
    //           m = magic
    //           s = special ability
    
    ScaledGamePiece *swamp_basilik_3_m_065;
    ScaledGamePiece *swamp_ding_2_066;
    ScaledGamePiece *swamp_flugpiranha_3_f_067;
    ScaledGamePiece *swamp_geist_2_m_068;
    ScaledGamePiece *swamp_gespenst_1_f_069;
    ScaledGamePiece *swamp_giftfrosch_1_070;
    ScaledGamePiece *swamp_irrlicht_2_m_071;
    ScaledGamePiece *swamp_kobold_1_m_072;
    ScaledGamePiece *swamp_krokodile_2_073;
    ScaledGamePiece *swamp_piraten_2_074;
    ScaledGamePiece *swamp_riesenblutegel_2_075;
    ScaledGamePiece *swmap_riesenechse_2_076;
    ScaledGamePiece *swamp_riesenmoskito_2_f_077;
    ScaledGamePiece *swamp_riesenschlange_3_078;
    ScaledGamePiece *swamp_schleimbestie_3_079;
    ScaledGamePiece *swamp_schwarzerritter_3_c_080;
    ScaledGamePiece *swamp_schwatsmagier_1_fm_081;
    ScaledGamePiece *swamp_sumpfgas_1_f_082;
    ScaledGamePiece *swamp_sumpfratte_1__083;
    ScaledGamePiece *swamp_vamplirfledermaus_4_f_084;
    ScaledGamePiece *swamp_wasserschlange_1_085;
    
    
    //Forest --- terrain-name-combat-symbol(s)-counter
    //           f = flying
    //           r = ranged
    //           c = charge in combat
    //           m = magic
    //           s = special ability
    
    ScaledGamePiece *forest_banditen_2_086;
    ScaledGamePiece *forest_baren_2_087;
    ScaledGamePiece *forest_druide_3_m_088;
    ScaledGamePiece *forest_dryade_1_m_089;
    ScaledGamePiece *forest_einhorn_4_090;
    ScaledGamePiece *forest_elf_2_r_091;
    ScaledGamePiece *forest_elf_3_f_092;
    ScaledGamePiece *forest_elfenmagier_2_m_093;
    ScaledGamePiece *forest_flugeichhomchen_2_f_094;
    ScaledGamePiece *forest_flugeichhomchen_1_f_095;
    ScaledGamePiece *forest_grobeule_2_f_096;
    ScaledGamePiece *forest_grunerritter_4_c_097;
    ScaledGamePiece *forest_laufbaum_5_098;
    ScaledGamePiece *forest_lindwurm_3_f_099;
    ScaledGamePiece *forest_morederwaschbar_2_100;
    ScaledGamePiece *forest_waldlaufer_2_r_101;
    ScaledGamePiece *forest_wichtelmann_1_f_102;
    ScaledGamePiece *forest_wildkatze_2_103;
    ScaledGamePiece *forest_yeti_5_104;
    
    //Desert --- terrain-name-combat-symbol(s)-counter
    //           f = flying
    //           r = ranged
    //           c = charge in combat
    //           m = magic
    //           s = special ability
    
    ScaledGamePiece *desert_alterdrache_4_fm_105;
    ScaledGamePiece *desert_babydrache_3_f_106;
    ScaledGamePiece *desert_bussard_1_f_107;
    ScaledGamePiece *desert_derwisch_2_m_108;
    ScaledGamePiece *desert_dschinn_4_m_109;
    ScaledGamePiece *desert_geier_1_f_110;
    ScaledGamePiece *desert_gelberritter_3_c_111;
    ScaledGamePiece *desert_greif_2_f_112;
    ScaledGamePiece *desert_kamelreiter_3_113;
    ScaledGamePiece *desert_nomade_1_114;
    ScaledGamePiece *desert_riesenspinne_1_115;
    ScaledGamePiece *desert_riesenwespe_4_f_116;
    ScaledGamePiece *desert_riesenwespe_2_f_117;
    ScaledGamePiece *desert_sandwurm_3_118;
    ScaledGamePiece *desert_skelett_1_119;
    ScaledGamePiece *desert_sphinx_4_m_120;
    ScaledGamePiece *desert_staubteufel_4_f_121;
    ScaledGamePiece *desert_wustenfledermaus_1_f_122;
    

}

- (id)init
{
    if ((self = [super init]))
    {
        [self setup];
    }
    return self;
}

-(void) initScaledTileCreatures
{
    
    jungle_dinosaur_4_000 =         [[ScaledGamePiece alloc]initWithContentsOfFile:@"T_Jungle_000"];
    jungle_elephant_4_001 =         [[ScaledGamePiece alloc]initWithContentsOfFile:@"T_Jungle_001"];
    jungle_flugsaurier_2_fr_002 =   [[ScaledGamePiece alloc]initWithContentsOfFile:@"T_Jungle_002"];
    jungle_kletterranken_6_003 =    [[ScaledGamePiece alloc]initWithContentsOfFile:@"T_Jungle_003"];
    jungle_kopfjager_2_r_004 =      [[ScaledGamePiece alloc]initWithContentsOfFile:@"T_Jungle_004"];
    jungle_krokodile_2_005 =        [[ScaledGamePiece alloc]initWithContentsOfFile:@"T_Jungle_005"];
    jungle_medizinmann_2_star_006 = [[ScaledGamePiece alloc]initWithContentsOfFile:@"T_Jungle_006"];
    jungle_paradiesvogel_1_f_007 =  [[ScaledGamePiece alloc]initWithContentsOfFile:@"T_Jungle_007"];
    jungle_pygmae_2_008 =           [[ScaledGamePiece alloc]initWithContentsOfFile:@"T_Jungle_008"];
    jungle_riesenaffe_5_009 =       [[ScaledGamePiece alloc]initWithContentsOfFile:@"T_Jungle_009"];
    jungle_riesenschlange_3_010 =   [[ScaledGamePiece alloc]initWithContentsOfFile:@"T_Jungle_010"];
    jungle_tiger_3_011 =            [[ScaledGamePiece alloc]initWithContentsOfFile:@"T_Jungle_011"];
    jungle_watussi_2_012 =          [[ScaledGamePiece alloc]initWithContentsOfFile:@"T_Jungle_012"];


    plains_alder_2_013 =            [[ScaledGamePiece alloc]initWithContentsOfFile:@"T_Plains_013"];
    plains_bauer_1_014=             [[ScaledGamePiece alloc]initWithContentsOfFile:@"T_Plains_014"];
    plains_bosewicht_2_015=         [[ScaledGamePiece alloc]initWithContentsOfFile:@"T_Plains_015"];
    plains_buffelherde_3_016=       [[ScaledGamePiece alloc]initWithContentsOfFile:@"T_Plains_016"];
    plains_buffelherde_4_017=       [[ScaledGamePiece alloc]initWithContentsOfFile:@"T_Plains_017"];
    plains_flugbuffel_2_f_018=      [[ScaledGamePiece alloc]initWithContentsOfFile:@"T_Plains_018"];
    plains_flugsaurier_3_f_019=     [[ScaledGamePiece alloc]initWithContentsOfFile:@"T_Plains_019"];
    plains_grobfalke_2_f_020=       [[ScaledGamePiece alloc]initWithContentsOfFile:@"T_Plains_020"];
    plains_grobjager_4_r_021=       [[ScaledGamePiece alloc]initWithContentsOfFile:@"T_Plains_021"];
    plains_jager_1_r_022=           [[ScaledGamePiece alloc]initWithContentsOfFile:@"T_Plains_022"];
    plains_libelle_2_f_023=         [[ScaledGamePiece alloc]initWithContentsOfFile:@"T_Plains_023"];
    plains_pegasus_2_f_024=         [[ScaledGamePiece alloc]initWithContentsOfFile:@"T_Plains_024"];
    plains_prachtlowe_3_025=        [[ScaledGamePiece alloc]initWithContentsOfFile:@"T_Plains_025"];
    plains_riesenkafer_2_f_026=     [[ScaledGamePiece alloc]initWithContentsOfFile:@"T_Plains_026"];
    plains_stammeskrieger_2_027=    [[ScaledGamePiece alloc]initWithContentsOfFile:@"T_Plains_027"];
    plains_stammeskrieger_1_f_028=  [[ScaledGamePiece alloc]initWithContentsOfFile:@"T_Plains_028"];
    plains_weiberritter_3_c_029=    [[ScaledGamePiece alloc]initWithContentsOfFile:@"T_Plains_029"];
    plains_wolfsmeute_3_030=        [[ScaledGamePiece alloc]initWithContentsOfFile:@"T_Plains_030"];
    plains_zentaur_2_031=           [[ScaledGamePiece alloc]initWithContentsOfFile:@"T_Plains_031"];
    plains_zigeuner_1_m_032=        [[ScaledGamePiece alloc]initWithContentsOfFile:@"T_Plains_032"];
    plains_zigeuner_2_m_033=        [[ScaledGamePiece alloc]initWithContentsOfFile:@"T_Plains_033"];
    
    
    mountain_bergbewohner_1_034 =   [[ScaledGamePiece alloc]initWithContentsOfFile:@"T_Mountains_034"];
    mounatin_berglowe_2_035 =       [[ScaledGamePiece alloc]initWithContentsOfFile:@"T_Mountains_035"];
    mountain_braunerdrache_3_f_036= [[ScaledGamePiece alloc]initWithContentsOfFile:@"T_Mountains_036"];
    mountain_braunerritter_4_c_037= [[ScaledGamePiece alloc]initWithContentsOfFile:@"T_Mountains_037"];
    mountain_golin_1_038=           [[ScaledGamePiece alloc]initWithContentsOfFile:@"T_Mountains_038"];
    mountain_grobadler_2_f_039=     [[ScaledGamePiece alloc]initWithContentsOfFile:@"T_Mountains_039"];
    mountain_grobfalke_1_f_040=     [[ScaledGamePiece alloc]initWithContentsOfFile:@"T_Mountains_040"];
    mountain_kleunerrockvogel_2_f_041= [[ScaledGamePiece alloc]initWithContentsOfFile:@"T_Mountains_041"];
    mountain_oger_2_042=            [[ScaledGamePiece alloc]initWithContentsOfFile:@"T_Mountains_042"];
    mountain_riese_4_r_043=         [[ScaledGamePiece alloc]initWithContentsOfFile:@"T_Mountains_043"];
    mountain_riesenkomdor_3_f_044=  [[ScaledGamePiece alloc]initWithContentsOfFile:@"T_Mountains_044"];
    mountain_riesenrockvogel_3_f_045= [[ScaledGamePiece alloc]initWithContentsOfFile:@"T_Mountains_045"];
    mountain_troll_4_046=           [[ScaledGamePiece alloc]initWithContentsOfFile:@"T_Mountains_046"];
    mountain_zwerg_2_r_047=         [[ScaledGamePiece alloc]initWithContentsOfFile:@"T_Mountains_047"];
    mountain_zwerg_3_r_048=         [[ScaledGamePiece alloc]initWithContentsOfFile:@"T_Mountains_048"];
    mountain_zwerg_3_c_049=         [[ScaledGamePiece alloc]initWithContentsOfFile:@"T_Mountains_049"];
    mountain_zyklop_5_050=          [[ScaledGamePiece alloc]initWithContentsOfFile:@"T_Mountains_050"];

    
    frozen_drachenrelter_3_rf_051=  [[ScaledGamePiece alloc]initWithContentsOfFile:@"T_Frozen_Waste_051"];
    frozen_eisbar_4_052=            [[ScaledGamePiece alloc]initWithContentsOfFile:@"T_Frozen_Waste_052"];
    frozen_eisfledermaus_1_f_053=   [[ScaledGamePiece alloc]initWithContentsOfFile:@"T_Frozen_Waste_053"];
    frozen_eisriese_5_r_054=        [[ScaledGamePiece alloc]initWithContentsOfFile:@"T_Frozen_Waste_054"];
    frozen_eiswurm_4_m_055=         [[ScaledGamePiece alloc]initWithContentsOfFile:@"T_Frozen_Waste_055"];
    frozen_elcherde_2_056=          [[ScaledGamePiece alloc]initWithContentsOfFile:@"T_Frozen_Waste_056"];
    frozen_eskimo_2_057=            [[ScaledGamePiece alloc]initWithContentsOfFile:@"T_Frozen_Waste_057"];
    frozen_mammut_5_c_058=          [[ScaledGamePiece alloc]initWithContentsOfFile:@"T_Frozen_Waste_058"];
    frozen_mordepapgeientaucher_2_f_059=   [[ScaledGamePiece alloc]initWithContentsOfFile:@"T_Frozen_Waste_059"];
    frozen_morderpinguin_3_060=     [[ScaledGamePiece alloc]initWithContentsOfFile:@"T_Frozen_Waste_060"];
    frozen_nordwind_2_fm_061=       [[ScaledGamePiece alloc]initWithContentsOfFile:@"T_Frozen_Waste_061"];
    frozen_warlrob_4_062=           [[ScaledGamePiece alloc]initWithContentsOfFile:@"T_Frozen_Waste_062"];
    frozen_weiberdrachen_5_m_063=   [[ScaledGamePiece alloc]initWithContentsOfFile:@"T_Frozen_Waste_063"];
    frozen_wolf_3_064=              [[ScaledGamePiece alloc]initWithContentsOfFile:@"T_Frozen_Waste_064"];
    

    swamp_basilik_3_m_065 =         [[ScaledGamePiece alloc]initWithContentsOfFile:@"T_Swamp_065"];
    swamp_ding_2_066 =              [[ScaledGamePiece alloc]initWithContentsOfFile:@"T_Swamp_066"];
    swamp_flugpiranha_3_f_067=      [[ScaledGamePiece alloc]initWithContentsOfFile:@"T_Swamp_067"];
    swamp_geist_2_m_068=            [[ScaledGamePiece alloc]initWithContentsOfFile:@"T_Swamp_068"];
    swamp_gespenst_1_f_069=         [[ScaledGamePiece alloc]initWithContentsOfFile:@"T_Swamp_069"];
    swamp_giftfrosch_1_070=         [[ScaledGamePiece alloc]initWithContentsOfFile:@"T_Swamp_070"];
    swamp_irrlicht_2_m_071=         [[ScaledGamePiece alloc]initWithContentsOfFile:@"T_Swamp_071"];
    swamp_kobold_1_m_072=           [[ScaledGamePiece alloc]initWithContentsOfFile:@"T_Swamp_072"];
    swamp_krokodile_2_073=          [[ScaledGamePiece alloc]initWithContentsOfFile:@"T_Swamp_073"];
    swamp_piraten_2_074=            [[ScaledGamePiece alloc]initWithContentsOfFile:@"T_Swamp_074"];
    swamp_riesenblutegel_2_075=     [[ScaledGamePiece alloc]initWithContentsOfFile:@"T_Swamp_075"];
    swmap_riesenechse_2_076=        [[ScaledGamePiece alloc]initWithContentsOfFile:@"T_Swamp_076"];
    swamp_riesenmoskito_2_f_077=    [[ScaledGamePiece alloc]initWithContentsOfFile:@"T_Swamp_077"];
    swamp_riesenschlange_3_078=     [[ScaledGamePiece alloc]initWithContentsOfFile:@"T_Swamp_078"];
    swamp_schleimbestie_3_079=      [[ScaledGamePiece alloc]initWithContentsOfFile:@"T_Swamp_079"];
    swamp_schwarzerritter_3_c_080=  [[ScaledGamePiece alloc]initWithContentsOfFile:@"T_Swamp_080"];
    swamp_schwatsmagier_1_fm_081=   [[ScaledGamePiece alloc]initWithContentsOfFile:@"T_Swamp_081"];
    swamp_sumpfgas_1_f_082=         [[ScaledGamePiece alloc]initWithContentsOfFile:@"T_Swamp_082"];
    swamp_sumpfratte_1__083=        [[ScaledGamePiece alloc]initWithContentsOfFile:@"T_Swamp_083"];
    swamp_vamplirfledermaus_4_f_084= [[ScaledGamePiece alloc]initWithContentsOfFile:@"T_Swamp_084"];
    swamp_wasserschlange_1_085=     [[ScaledGamePiece alloc]initWithContentsOfFile:@"T_Swamp_085"];
    
    forest_banditen_2_086=          [[ScaledGamePiece alloc]initWithContentsOfFile:@"T_Forest_086"];
    forest_baren_2_087=             [[ScaledGamePiece alloc]initWithContentsOfFile:@"T_Forest_087"];
    forest_druide_3_m_088=          [[ScaledGamePiece alloc]initWithContentsOfFile:@"T_Forest_088"];
    forest_dryade_1_m_089=          [[ScaledGamePiece alloc]initWithContentsOfFile:@"T_Forest_089"];
    forest_einhorn_4_090=           [[ScaledGamePiece alloc]initWithContentsOfFile:@"T_Forest_090"];
    forest_elf_2_r_091=             [[ScaledGamePiece alloc]initWithContentsOfFile:@"T_Forest_091"];
    forest_elf_3_f_092=             [[ScaledGamePiece alloc]initWithContentsOfFile:@"T_Forest_092"];
    forest_elfenmagier_2_m_093=     [[ScaledGamePiece alloc]initWithContentsOfFile:@"T_Forest_093"];
    forest_flugeichhomchen_2_f_094= [[ScaledGamePiece alloc]initWithContentsOfFile:@"T_Forest_094"];
    forest_flugeichhomchen_1_f_095= [[ScaledGamePiece alloc]initWithContentsOfFile:@"T_Forest_095"];
    forest_grobeule_2_f_096=        [[ScaledGamePiece alloc]initWithContentsOfFile:@"T_Forest_096"];
    forest_grunerritter_4_c_097=    [[ScaledGamePiece alloc]initWithContentsOfFile:@"T_Forest_097"];
    forest_laufbaum_5_098=          [[ScaledGamePiece alloc]initWithContentsOfFile:@"T_Forest_098"];
    forest_lindwurm_3_f_099=        [[ScaledGamePiece alloc]initWithContentsOfFile:@"T_Forest_099"];
    forest_morederwaschbar_2_100=   [[ScaledGamePiece alloc]initWithContentsOfFile:@"T_Forest_100"];
    forest_waldlaufer_2_r_101=      [[ScaledGamePiece alloc]initWithContentsOfFile:@"T_Forest_101"];
    forest_wichtelmann_1_f_102=     [[ScaledGamePiece alloc]initWithContentsOfFile:@"T_Forest_102"];
    forest_wildkatze_2_103=         [[ScaledGamePiece alloc]initWithContentsOfFile:@"T_Forest_103"];
    forest_yeti_5_104=              [[ScaledGamePiece alloc]initWithContentsOfFile:@"T_Forest_104"];
    
    desert_alterdrache_4_fm_105=    [[ScaledGamePiece alloc]initWithContentsOfFile:@"T_Desert_105"];
    desert_babydrache_3_f_106=      [[ScaledGamePiece alloc]initWithContentsOfFile:@"T_Desert_106"];
    desert_bussard_1_f_107=         [[ScaledGamePiece alloc]initWithContentsOfFile:@"T_Desert_107"];
    desert_derwisch_2_m_108=        [[ScaledGamePiece alloc]initWithContentsOfFile:@"T_Desert_108"];
    desert_dschinn_4_m_109=         [[ScaledGamePiece alloc]initWithContentsOfFile:@"T_Desert_109"];
    desert_geier_1_f_110=           [[ScaledGamePiece alloc]initWithContentsOfFile:@"T_Desert_110"];
    desert_gelberritter_3_c_111=    [[ScaledGamePiece alloc]initWithContentsOfFile:@"T_Desert_111"];
    desert_greif_2_f_112=           [[ScaledGamePiece alloc]initWithContentsOfFile:@"T_Desert_112"];
    desert_kamelreiter_3_113=       [[ScaledGamePiece alloc]initWithContentsOfFile:@"T_Desert_113"];
    desert_nomade_1_114=            [[ScaledGamePiece alloc]initWithContentsOfFile:@"T_Desert_114"];
    desert_riesenspinne_1_115=      [[ScaledGamePiece alloc]initWithContentsOfFile:@"T_Desert_115"];
    desert_riesenwespe_4_f_116=     [[ScaledGamePiece alloc]initWithContentsOfFile:@"T_Desert_116"];
    desert_riesenwespe_2_f_117=     [[ScaledGamePiece alloc]initWithContentsOfFile:@"T_Desert_117"];
    desert_sandwurm_3_118=          [[ScaledGamePiece alloc]initWithContentsOfFile:@"T_Desert_118"];
    desert_skelett_1_119=           [[ScaledGamePiece alloc]initWithContentsOfFile:@"T_Desert_119"];
    desert_sphinx_4_m_120=          [[ScaledGamePiece alloc]initWithContentsOfFile:@"T_Desert_120"];
    desert_staubteufel_4_f_121=     [[ScaledGamePiece alloc]initWithContentsOfFile:@"T_Desert_121"];
    desert_wustenfledermaus_1_f_122=[[ScaledGamePiece alloc]initWithContentsOfFile:@"T_Desert_122"];








}






- (void)dealloc
{
    // release any resources here
    [Media releaseAtlas];
    [Media releaseSound];
}

- (void)setup
{
    // This is where the code of your game will start.
    // In this sample, we add just a few simple elements to get a feeling about how it's done.
    
    [SPAudioEngine start];  // starts up the sound engine
    
    
    // The Application contains a very handy "Media" class which loads your texture atlas
    // and all available sound files automatically. Extend this class as you need it --
    // that way, you will be able to access your textures and sounds throughout your
    // application, without duplicating any resources.
    
    [Media initAtlas];      // loads your texture atlas -> see Media.h/Media.m
    [Media initSound];      // loads all your sounds    -> see Media.h/Media.m
    
    
    // Create some placeholder content: a background image, the Sparrow logo, and a text field.
    // The positions are updated when the device is rotated. To make that easy, we put all objects
    // in one sprite (_contents): it will simply be rotated to be upright when the device rotates.
    
    _gameWidth  = Sparrow.stage.width;
    _gameHeight = Sparrow.stage.height;
    
    
    gamePieces = [[NSMutableArray alloc] init];
    
    _contents = [SPSprite sprite];
    [self addChild:_contents];
   
    SPImage *background = [[SPImage alloc] initWithContentsOfFile:@"TwoThreeBoard.png"];
    //[_contents addChild:background];
    
    //necessary or else it gets placed off screen
    background.x = 0;
    background.y = 0;
    
    
    // used to handle movement and zooming of board
    TouchSheet *sheet = [[TouchSheet alloc] initWithQuad:background];
    //TouchSheet *sheet = [[TouchSheet alloc] initWithQuad:background];
    _sheet = [[TouchSheet alloc] initWithQuad:background];
    
    //[background addEventListener:@selector(onMoveBoard:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    
    
    
    [self drawStart];
    
    
    //Tiles
    _seaTile = [[SPImage alloc] initWithContentsOfFile:@"sea-tile.png"];
    _seaTile.x = 10;
    _seaTile.y = 250;
    //[sheet addChild:_seaTile];
    [gamePieces addObject:_seaTile ];
    
    _jungleTile = [[SPImage alloc] initWithContentsOfFile:@"jungle-tile.png"];
    _jungleTile.x = 60;
    _jungleTile.y = 250;
    //[sheet addChild:_jungleTile];
    [gamePieces addObject:_jungleTile];
    
    
    _desertTile = [[SPImage alloc] initWithContentsOfFile:@"desert-tile.png"];
    _desertTile.x = 110;
    _desertTile.y = 250;
   // [sheet addChild:_desertTile];
    [gamePieces addObject:_desertTile];
    
    
    _forestTile = [[SPImage alloc] initWithContentsOfFile:@"forest-tile.png"];
    _forestTile.x = 160;
    _forestTile.y = 250;
   // [sheet addChild:_forestTile];
    [gamePieces addObject:_forestTile];
    
    //Adding the sheet to contents so that it appears
    [_contents addChild: sheet];

    
    //Adding the sheet to contents so that it appears
    [_contents addChild: _sheet];
    
    
    //Other images
    _rack = [[SPImage alloc] initWithContentsOfFile:@"Rack.png"];
    _rack.x = 5;
    _rack.y = 350;
    [_contents addChild:_rack];
    [gamePieces addObject:_rack];
    
    
    _bowl = [[SPImage alloc] initWithContentsOfFile:@"Bowl.png"];
    _bowl.x = 235;
    _bowl.y = 325;
    [_contents addChild:_bowl];
    [gamePieces addObject:_bowl];
    
    
    /* Adding to _contents will ensure that these pieces do not move with the board*/
    
    _bankText = [SPTextField textFieldWithWidth:75 height:30 text:@"Bank: 0"];
    _bankText.x = 225;
    _bankText.y = 445;
    _bankText.color = SP_YELLOW;
    [_contents addChild:_bankText];

    
    
    _dice = [[SPImage alloc] initWithContentsOfFile:@"dice6.png"];
    _dice.x = 5;
    _dice.y = 10;
    [_contents addChild:_dice];

    
    
    _creatureDice = [[SPImage alloc] initWithContentsOfFile:@"creature5.png"];
    _creatureDice.x = 5;
    _creatureDice.y = 45;
    [_contents addChild:_creatureDice];

    
    //Event listeners for each image (to do: make a loop)
   
    [_seaTile addEventListener:@selector(onMoveTile:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    [_jungleTile addEventListener:@selector(onMoveTile:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    [_desertTile addEventListener:@selector(onMoveTile:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    [_forestTile addEventListener:@selector(onMoveTile:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    
    // The controller autorotates the game to all supported device orientations.
    // Choose the orienations you want to support in the Xcode Target Settings ("Summary"-tab).
    // To update the game content accordingly, listen to the "RESIZE" event; it is dispatched
    // to all game elements (just like an ENTER_FRAME event).
    //
    // To force the game to start up in landscape, add the key "Initial Interface Orientation"
    // to the "App-Info.plist" file and choose any landscape orientation.
    
    [self addEventListener:@selector(onResize:) atObject:self forType:SP_EVENT_TYPE_RESIZE];
    
    // Per default, this project compiles as a universal application. To change that, enter the
    // project info screen, and in the "Build"-tab, find the setting "Targeted device family".
    //
    // Now choose:
    //   * iPhone      -> iPhone only App
    //   * iPad        -> iPad only App
    //   * iPhone/iPad -> Universal App
    //
    // Sparrow's minimum deployment target is iOS 5.
}

- (void)onMoveTile:(SPTouchEvent*)event {
    
    SPImage *img = (SPImage*)event.target;
    
    NSArray *touches = [[event touchesWithTarget:self andPhase:SPTouchPhaseMoved] allObjects];
    
    if (touches.count == 1)
    {
        // one finger touching -> move
        SPTouch *touch = touches[0];
        SPPoint *movement = [touch movementInSpace:self.parent];
        
        img.x += movement.x;
        img.y += movement.y;
        
        
        
    }
    
}


-(void)onClickTile:(SPTouchEvent*) event
{
    SPImage * img = (SPImage*) event.target;
    SPImage *newimg;
    
    NSArray *touches = [[event touchesWithTarget:self andPhase:SPTouchPhaseBegan] allObjects];
    
     if (touches.count == 1)
    {
        NSLog(@"le tile click");
       
        //Randomize based on game logic
        [img removeFromParent];
        newimg = [[SPImage alloc] initWithContentsOfFile:@"swamp-tile.png"];
        newimg.x = img.x;
        newimg.y = img.y;
        
        [_sheet addChild:newimg];
        [newimg addEventListener:@selector(tileDoubleClick:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
        
    }
}


-(void) tileDoubleClick: (SPTouchEvent*) event
{
    NSArray *touches = [[event touchesWithTarget:self andPhase:SPTouchPhaseBegan] allObjects];
    if (touches.count == 1)
    {
        
    //Double Click
    SPTouch * clickTileMenu = [touches objectAtIndex:0];
        if (clickTileMenu.tapCount == 2){
            NSLog(@"le double click");
            
            [NSObject cancelPreviousPerformRequestsWithTarget:self];

            [self showTileMenu];
            
           
        }

    }

}

- (void)showScene:(SPSprite *)scene {
  
    [self addChild:scene];
    scene.visible = YES;
}

- (void)showTileMenu {
    TileMenu *tileScene = [[TileMenu alloc] init];
    [self showScene:tileScene];
}

-(void) drawStart
{
    //Hexagon
    
    //Drawing hexagons for middle (5)
    for (int i = 0; i < 5; i++){
        bool drawNext = false;
        _backTile = [[SPImage alloc]initWithContentsOfFile:@"back-tile.png"];
        _backTile.x = 133;
        _backTile.y = 20 + ((i  * (_backTile.height + 4)));
        
        //Draw missing tile
        if (i == 1){
            drawNext = true;
            _backTile = [[SPImage alloc]initWithContentsOfFile:@"back-tile.png"];
            _backTile.x = 133;
            _backTile.y = 20 + ((i  * (_backTile.height + 4)));
            [_sheet addChild: _backTile];
            
            [_backTile addEventListener:@selector(onClickTile:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
            
        }
        
        if (drawNext) {
            //Drawing hexagon for left side after first hexagon (4)
            for (int j = 0; j < 4; j ++) {
                _backTile = [[SPImage alloc]initWithContentsOfFile:@"back-tile.png"];
                _backTile.x = 133 - (_backTile.width - 10);
                _backTile.y = 20 + ((j  * (_backTile.height + 4))) + _backTile.height /2 ;
                [_sheet addChild: _backTile];
                
                [_backTile addEventListener:@selector(onClickTile:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
                
            }
            
            //Drawing hexagon for right side after first hexagon (4)
            for (int j = 0; j < 4; j ++) {
                _backTile = [[SPImage alloc]initWithContentsOfFile:@"back-tile.png"];
                _backTile.x = 133 + (_backTile.width - 10);
                _backTile.y = 20 + ((j  * (_backTile.height + 4))) + _backTile.height /2 ;
                [_sheet addChild: _backTile];
                
                [_backTile addEventListener:@selector(onClickTile:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
                
            }
            drawNext = false;
        }
        
        //Draw missing tile 2
        if (i == 2){
            drawNext = true;
            _backTile = [[SPImage alloc]initWithContentsOfFile:@"back-tile.png"];
            _backTile.x = 133;
            _backTile.y = 20 + ((i  * (_backTile.height + 4)));
            [_sheet addChild: _backTile];
            
            [_backTile addEventListener:@selector(onClickTile:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
            
        }
        if (drawNext) {
            //Drawing hexagon for left side after first hexagon (3)
            for (int j = 0; j < 3; j ++) {
                _backTile = [[SPImage alloc]initWithContentsOfFile:@"back-tile.png"];
                _backTile.x = 133 - ((_backTile.width * 2) - 20);
                _backTile.y = 20 + ((j  * (_backTile.height + 4))) + (_backTile.height) ;
                [_sheet addChild: _backTile];
                
                [_backTile addEventListener:@selector(onClickTile:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
            }
            
            //Drawing hexagon for right side after first hexagon (3)
            for (int j = 0; j < 3; j ++) {
                _backTile = [[SPImage alloc]initWithContentsOfFile:@"back-tile.png"];
                _backTile.x = 133 + ((_backTile.width * 2) - 20);
                _backTile.y = 20 + ((j  * (_backTile.height + 4))) + (_backTile.height) ;
                [_sheet addChild: _backTile];
                
                [_backTile addEventListener:@selector(onClickTile:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
            }
            
            drawNext = false;
        }
        
        [_sheet addChild: _backTile];
        
        
        [_backTile addEventListener:@selector(onClickTile:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    }



}

- (void)updateLocations
{
    _gameWidth  = Sparrow.stage.width;
    _gameHeight = Sparrow.stage.height;
    
    _contents.x = (int) (_gameWidth  - _contents.width)  / 2;
    _contents.y = (int) (_gameHeight - _contents.height) / 2;
}


- (void)onResize:(SPResizeEvent *)event
{
    NSLog(@"new size: %.0fx%.0f (%@)", event.width, event.height,
          event.isPortrait ? @"portrait" : @"landscape");
    
    [self updateLocations];
}

@end
