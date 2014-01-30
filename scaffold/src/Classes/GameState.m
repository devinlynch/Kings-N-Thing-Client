//
//  GameState.m
//  3004iPhone
//
//  Created by Devin Lynch on 2014-01-26.
//
//

#import "GameState.h"
#import "Player.h"
#import "Game.h"
#import "PlayingCup.h"
#import "Bank.h"
#import "HexLocation.h"

@implementation GameState

@synthesize players = _players;
@synthesize game = _game;

-(id<JSONSerializable>)initFromJSON:(NSDictionary*) json{
    self=[super init];
    if(self && json != nil) {
        NSArray *playersJsonArr = [json objectForKey:@"players"];
        if(playersJsonArr != nil){
            [self setPlayers:[[NSMutableArray alloc] init]];
            for(id o in playersJsonArr) {
                if(o != nil && ([o isKindOfClass:[NSDictionary class]])){
                    NSDictionary *playerDic = (NSDictionary*) o;
                    Player *u = [[Player alloc] initFromJSON:playerDic];
                    [self.players addObject:u];
                }
            }
        }
    }
    return self;
}

-(void)findPathFromLocation:(HexLocation *)location withMoves:(int)moves{
    
    if(location.tile.isHilighted){
        return;
    }
    
    if (moves == 0) {
        [[location tile] hilight];
        return;
    }
    else{
        [[location tile] hilight];
    }
    
    for (HexLocation *tileLocation in [location neighbours]){
        [self findPathFromLocation:tileLocation withMoves:--moves];
    }
    
    
    
}

-(void) initGamePieces{
    
    
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
    
    
    
    [_gamePieceResource setObject:    jungle_dinosaur_4_000  forKey:@"T_Jungle_000"];
    [_gamePieceResource setObject:    jungle_elephant_4_001  forKey:@"T_Jungle_001"];
    [_gamePieceResource setObject:    jungle_flugsaurier_2_fr_002  forKey:@"T_Jungle_002"];
    [_gamePieceResource setObject:    jungle_kletterranken_6_003  forKey:@"T_Jungle_003"];
    [_gamePieceResource setObject:    jungle_kopfjager_2_r_004  forKey:@"T_Jungle_004"];
    [_gamePieceResource setObject:    jungle_krokodile_2_005  forKey:@"T_Jungle_005"];
    [_gamePieceResource setObject:    jungle_medizinmann_2_star_006  forKey:@"T_Jungle_006"];
    [_gamePieceResource setObject:    jungle_paradiesvogel_1_f_007  forKey:@"T_Jungle_007"];
    [_gamePieceResource setObject:    jungle_pygmae_2_008  forKey:@"T_Jungle_008"];
    [_gamePieceResource setObject:    jungle_riesenaffe_5_009  forKey:@"T_Jungle_009"];
    [_gamePieceResource setObject:    jungle_riesenschlange_3_010  forKey:@"T_Jungle_010"];
    [_gamePieceResource setObject:    jungle_tiger_3_011  forKey:@"T_Jungle_011"];
    [_gamePieceResource setObject:    jungle_watussi_2_012  forKey:@"T_Jungle_012"];
    
    
    [_gamePieceResource setObject:    plains_alder_2_013  forKey:@"T_Plains_013"];
    [_gamePieceResource setObject:    plains_bauer_1_014 forKey:@"T_Plains_014"];
    [_gamePieceResource setObject:    plains_bosewicht_2_015 forKey:@"T_Plains_015"];
    [_gamePieceResource setObject:    plains_buffelherde_3_016 forKey:@"T_Plains_016"];
    [_gamePieceResource setObject:    plains_buffelherde_4_017 forKey:@"T_Plains_017"];
    [_gamePieceResource setObject:    plains_flugbuffel_2_f_018 forKey:@"T_Plains_018"];
    [_gamePieceResource setObject:    plains_flugsaurier_3_f_019 forKey:@"T_Plains_019"];
    [_gamePieceResource setObject:    plains_grobfalke_2_f_020 forKey:@"T_Plains_020"];
    [_gamePieceResource setObject:    plains_grobjager_4_r_021 forKey:@"T_Plains_021"];
    [_gamePieceResource setObject:    plains_jager_1_r_022 forKey:@"T_Plains_022"];
    [_gamePieceResource setObject:    plains_libelle_2_f_023 forKey:@"T_Plains_023"];
    [_gamePieceResource setObject:    plains_pegasus_2_f_024 forKey:@"T_Plains_024"];
    [_gamePieceResource setObject:    plains_prachtlowe_3_025 forKey:@"T_Plains_025"];
    [_gamePieceResource setObject:    plains_riesenkafer_2_f_026 forKey:@"T_Plains_026"];
    [_gamePieceResource setObject:    plains_stammeskrieger_2_027 forKey:@"T_Plains_027"];
    [_gamePieceResource setObject:    plains_stammeskrieger_1_f_028 forKey:@"T_Plains_028"];
    [_gamePieceResource setObject:    plains_weiberritter_3_c_029 forKey:@"T_Plains_029"];
    [_gamePieceResource setObject:    plains_wolfsmeute_3_030 forKey:@"T_Plains_030"];
    [_gamePieceResource setObject:    plains_zentaur_2_031 forKey:@"T_Plains_031"];
    [_gamePieceResource setObject:    plains_zigeuner_1_m_032 forKey:@"T_Plains_032"];
    [_gamePieceResource setObject:    plains_zigeuner_2_m_033 forKey:@"T_Plains_033"];
    
    
    [_gamePieceResource setObject:    mountain_bergbewohner_1_034  forKey:@"T_Mountains_034"];
    [_gamePieceResource setObject:    mounatin_berglowe_2_035  forKey:@"T_Mountains_035"];
    [_gamePieceResource setObject:    mountain_braunerdrache_3_f_036 forKey:@"T_Mountains_036"];
    [_gamePieceResource setObject:    mountain_braunerritter_4_c_037 forKey:@"T_Mountains_037"];
    [_gamePieceResource setObject:    mountain_golin_1_038 forKey:@"T_Mountains_038"];
    [_gamePieceResource setObject:    mountain_grobadler_2_f_039 forKey:@"T_Mountains_039"];
    [_gamePieceResource setObject:    mountain_grobfalke_1_f_040 forKey:@"T_Mountains_040"];
    [_gamePieceResource setObject:    mountain_kleunerrockvogel_2_f_041 forKey:@"T_Mountains_041"];
    [_gamePieceResource setObject:    mountain_oger_2_042 forKey:@"T_Mountains_042"];
    [_gamePieceResource setObject:    mountain_riese_4_r_043 forKey:@"T_Mountains_043"];
    [_gamePieceResource setObject:    mountain_riesenkomdor_3_f_044 forKey:@"T_Mountains_044"];
    [_gamePieceResource setObject:    mountain_riesenrockvogel_3_f_045 forKey:@"T_Mountains_045"];
    [_gamePieceResource setObject:    mountain_troll_4_046 forKey:@"T_Mountains_046"];
    [_gamePieceResource setObject:    mountain_zwerg_2_r_047 forKey:@"T_Mountains_047"];
    [_gamePieceResource setObject:    mountain_zwerg_3_r_048 forKey:@"T_Mountains_048"];
    [_gamePieceResource setObject:    mountain_zwerg_3_c_049 forKey:@"T_Mountains_049"];
    [_gamePieceResource setObject:    mountain_zyklop_5_050 forKey:@"T_Mountains_050"];
    
    
    [_gamePieceResource setObject:    frozen_drachenrelter_3_rf_051 forKey:@"T_Frozen_Waste_051"];
    [_gamePieceResource setObject:    frozen_eisbar_4_052 forKey:@"T_Frozen_Waste_052"];
    [_gamePieceResource setObject:    frozen_eisfledermaus_1_f_053 forKey:@"T_Frozen_Waste_053"];
    [_gamePieceResource setObject:    frozen_eisriese_5_r_054 forKey:@"T_Frozen_Waste_054"];
    [_gamePieceResource setObject:    frozen_eiswurm_4_m_055 forKey:@"T_Frozen_Waste_055"];
    [_gamePieceResource setObject:    frozen_elcherde_2_056 forKey:@"T_Frozen_Waste_056"];
    [_gamePieceResource setObject:    frozen_eskimo_2_057 forKey:@"T_Frozen_Waste_057"];
    [_gamePieceResource setObject:    frozen_mammut_5_c_058 forKey:@"T_Frozen_Waste_058"];
    [_gamePieceResource setObject:    frozen_mordepapgeientaucher_2_f_059 forKey:@"T_Frozen_Waste_059"];
    [_gamePieceResource setObject:    frozen_morderpinguin_3_060 forKey:@"T_Frozen_Waste_060"];
    [_gamePieceResource setObject:    frozen_nordwind_2_fm_061 forKey:@"T_Frozen_Waste_061"];
    [_gamePieceResource setObject:    frozen_warlrob_4_062 forKey:@"T_Frozen_Waste_062"];
    [_gamePieceResource setObject:    frozen_weiberdrachen_5_m_063 forKey:@"T_Frozen_Waste_063"];
    [_gamePieceResource setObject:    frozen_wolf_3_064 forKey:@"T_Frozen_Waste_064"];
    
    
    [_gamePieceResource setObject:    swamp_basilik_3_m_065  forKey:@"T_Swamp_065"];
    [_gamePieceResource setObject:    swamp_ding_2_066  forKey:@"T_Swamp_066"];
    [_gamePieceResource setObject:    swamp_flugpiranha_3_f_067 forKey:@"T_Swamp_067"];
    [_gamePieceResource setObject:    swamp_geist_2_m_068 forKey:@"T_Swamp_068"];
    [_gamePieceResource setObject:    swamp_gespenst_1_f_069 forKey:@"T_Swamp_069"];
    [_gamePieceResource setObject:    swamp_giftfrosch_1_070 forKey:@"T_Swamp_070"];
    [_gamePieceResource setObject:    swamp_irrlicht_2_m_071 forKey:@"T_Swamp_071"];
    [_gamePieceResource setObject:    swamp_kobold_1_m_072 forKey:@"T_Swamp_072"];
    [_gamePieceResource setObject:    swamp_krokodile_2_073 forKey:@"T_Swamp_073"];
    [_gamePieceResource setObject:    swamp_piraten_2_074 forKey:@"T_Swamp_074"];
    [_gamePieceResource setObject:    swamp_riesenblutegel_2_075 forKey:@"T_Swamp_075"];
    [_gamePieceResource setObject:    swmap_riesenechse_2_076 forKey:@"T_Swamp_076"];
    [_gamePieceResource setObject:    swamp_riesenmoskito_2_f_077 forKey:@"T_Swamp_077"];
    [_gamePieceResource setObject:    swamp_riesenschlange_3_078 forKey:@"T_Swamp_078"];
    [_gamePieceResource setObject:    swamp_schleimbestie_3_079 forKey:@"T_Swamp_079"];
    [_gamePieceResource setObject:    swamp_schwarzerritter_3_c_080 forKey:@"T_Swamp_080"];
    [_gamePieceResource setObject:    swamp_schwatsmagier_1_fm_081 forKey:@"T_Swamp_081"];
    [_gamePieceResource setObject:    swamp_sumpfgas_1_f_082 forKey:@"T_Swamp_082"];
    [_gamePieceResource setObject:    swamp_sumpfratte_1__083 forKey:@"T_Swamp_083"];
    [_gamePieceResource setObject:    swamp_vamplirfledermaus_4_f_084 forKey:@"T_Swamp_084"];
    [_gamePieceResource setObject:    swamp_wasserschlange_1_085 forKey:@"T_Swamp_085"];
    
    [_gamePieceResource setObject:    forest_banditen_2_086 forKey:@"T_Forest_086"];
    [_gamePieceResource setObject:    forest_baren_2_087 forKey:@"T_Forest_087"];
    [_gamePieceResource setObject:    forest_druide_3_m_088 forKey:@"T_Forest_088"];
    [_gamePieceResource setObject:    forest_dryade_1_m_089 forKey:@"T_Forest_089"];
    [_gamePieceResource setObject:    forest_einhorn_4_090 forKey:@"T_Forest_090"];
    [_gamePieceResource setObject:    forest_elf_2_r_091 forKey:@"T_Forest_091"];
    [_gamePieceResource setObject:    forest_elf_3_f_092 forKey:@"T_Forest_092"];
    [_gamePieceResource setObject:    forest_elfenmagier_2_m_093 forKey:@"T_Forest_093"];
    [_gamePieceResource setObject:    forest_flugeichhomchen_2_f_094 forKey:@"T_Forest_094"];
    [_gamePieceResource setObject:    forest_flugeichhomchen_1_f_095 forKey:@"T_Forest_095"];
    [_gamePieceResource setObject:    forest_grobeule_2_f_096 forKey:@"T_Forest_096"];
    [_gamePieceResource setObject:    forest_grunerritter_4_c_097 forKey:@"T_Forest_097"];
    [_gamePieceResource setObject:    forest_laufbaum_5_098 forKey:@"T_Forest_098"];
    [_gamePieceResource setObject:    forest_lindwurm_3_f_099 forKey:@"T_Forest_099"];
    [_gamePieceResource setObject:    forest_morederwaschbar_2_100 forKey:@"T_Forest_100"];
    [_gamePieceResource setObject:    forest_waldlaufer_2_r_101 forKey:@"T_Forest_101"];
    [_gamePieceResource setObject:    forest_wichtelmann_1_f_102 forKey:@"T_Forest_102"];
    [_gamePieceResource setObject:    forest_wildkatze_2_103 forKey:@"T_Forest_103"];
    [_gamePieceResource setObject:    forest_yeti_5_104 forKey:@"T_Forest_104"];
    
    [_gamePieceResource setObject:    desert_alterdrache_4_fm_105 forKey:@"T_Desert_105"];
    [_gamePieceResource setObject:    desert_babydrache_3_f_106 forKey:@"T_Desert_106"];
    [_gamePieceResource setObject:    desert_bussard_1_f_107 forKey:@"T_Desert_107"];
    [_gamePieceResource setObject:    desert_derwisch_2_m_108 forKey:@"T_Desert_108"];
    [_gamePieceResource setObject:    desert_dschinn_4_m_109 forKey:@"T_Desert_109"];
    [_gamePieceResource setObject:    desert_geier_1_f_110 forKey:@"T_Desert_110"];
    [_gamePieceResource setObject:    desert_gelberritter_3_c_111 forKey:@"T_Desert_111"];
    [_gamePieceResource setObject:    desert_greif_2_f_112 forKey:@"T_Desert_112"];
    [_gamePieceResource setObject:    desert_kamelreiter_3_113 forKey:@"T_Desert_113"];
    [_gamePieceResource setObject:    desert_nomade_1_114 forKey:@"T_Desert_114"];
    [_gamePieceResource setObject:    desert_riesenspinne_1_115 forKey:@"T_Desert_115"];
    [_gamePieceResource setObject:    desert_riesenwespe_4_f_116 forKey:@"T_Desert_116"];
    [_gamePieceResource setObject:    desert_riesenwespe_2_f_117 forKey:@"T_Desert_117"];
    [_gamePieceResource setObject:    desert_sandwurm_3_118 forKey:@"T_Desert_118"];
    [_gamePieceResource setObject:    desert_skelett_1_119 forKey:@"T_Desert_119"];
    [_gamePieceResource setObject:    desert_sphinx_4_m_120 forKey:@"T_Desert_120"];
    [_gamePieceResource setObject:    desert_staubteufel_4_f_121 forKey:@"T_Desert_121"];
    [_gamePieceResource setObject:    desert_wustenfledermaus_1_f_122 forKey:@"T_Desert_122"];


    
    
}

-(ScaledGamePiece*) getGamePieceImageForPiece:(NSString *)piece{
    ScaledGamePiece *img = [[_gamePieceResource objectForKey:piece] copy];
    
    return img;
}

@end
