//
//  ScaleImage.m
//  3004iPhone
//
//  Created by Richard Ison on 1/16/2014.
//
//

#import "ScaledGamePiece.h"

@implementation ScaledGamePiece{
    
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
    ScaledGamePiece *jungle_elephant_4_001s;
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
    
    //Plains
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
    
    //Mountains
    ScaledGamePiece *mountain_bergbewohner_1_034;
    ScaledGamePiece *mounatin_berglowe_2_035;
    ScaledGamePiece *mountain_braunerdrache_3_f_036;
    ScaledGamePiece *mountain_braunerritter_4_c_037;
    ScaledGamePiece *mountain_golin_1_038;
    ScaledGamePiece *mountain_grobadler_2_f_039;
    
    
    
    
    
    
    


}

- (id) initWithContentsOfFile:(NSString *)path
{
    ScaledGamePiece *img = [super initWithContentsOfFile:path generateMipmaps:NO];
    
    img.scaleX = 0.75f;
    img.scaleY = 0.75f;
    
    [img addEventListener:@selector(onMoveTile:) atObject:self forType:SP_EVENT_TYPE_TOUCH];

 
    return img;
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

@end
