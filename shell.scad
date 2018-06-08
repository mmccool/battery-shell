// Battery Shell
// Developed by: Michael McCool
// Copyright 2018 Michael McCpp;
// License: CC BY 3.0.  See LICENSE.md
include <tols.scad>
//include <smooth_model.scad>
include <smooth_make.scad>
include <bolt_params.scad>
use <bolts.scad>

standoff_h = 44.5;
standoff_r = 6/2;
feet_h = 15;

max_h = 70;

pcb_h = 1.55;
pcb_x = 64;
pcb_bx = 55;
pcb_wx = 46;
pcb_y = 95;
pcb_by = 87;
pcb_wy = 76;
pcb_br = 3.5/2;

bolt_sm = 2*sm_base;

form_t = 3;
lip_h = 5;

top_s = 3;
top_h = top_s + form_t;

bot_s = 10;
bot_h = bot_s + form_t;

form_bt = 0.5;
form_bolt_r = 3.5/2;
form_bolt_R = 6.3/2;
form_bolt_dr = form_bolt_R - form_bolt_r;
form_R = 10/2;
form_sx = 5;
form_wh = 10;
form_ww = 65;
form_wr = 20/2;
form_tol = 1;
form_x = pcb_x + 2*form_tol + 2*form_t;
form_y = pcb_y + 2*form_tol + 2*form_R;
form_sm = 4*sm_base;
form_c = 0.2;
form_rh = 2;

hole_r = 15/2;
hole_w = 20;

top_form_h = standoff_h/2 + pcb_h + top_h - form_c/2;
bot_form_h = standoff_h/2 + pcb_h + bot_h - form_c/2;

module pcb() {
  difference() {
    translate([-pcb_x/2,-pcb_y/2,0]) 
      cube([pcb_x,pcb_y,pcb_h]);
    translate([-pcb_bx/2,-pcb_by/2,-1]) 
      cylinder(r=pcb_br,h=pcb_h+2,$fn=bolt_sm);
    translate([ pcb_bx/2,-pcb_by/2,-1]) 
      cylinder(r=pcb_br,h=pcb_h+2,$fn=bolt_sm);
    translate([-pcb_bx/2, pcb_by/2,-1]) 
      cylinder(r=pcb_br,h=pcb_h+2,$fn=bolt_sm);
    translate([ pcb_bx/2, pcb_by/2,-1]) 
      cylinder(r=pcb_br,h=pcb_h+2,$fn=bolt_sm);
  }
}

module pillar(h,r) {
  cylinder(r=r,h=h,$fn=form_sm);
}

module standoff() {
  cylinder(r=standoff_r,h=standoff_h,$fn=6);
}

module standoffs() {
  translate([-pcb_bx/2,-pcb_by/2,0]) standoff();
  translate([ pcb_bx/2,-pcb_by/2,0]) standoff();
  translate([-pcb_bx/2, pcb_by/2,0]) standoff();
  translate([ pcb_bx/2, pcb_by/2,0]) standoff();
}

module form(h,c,bottom=false,lip=0) {
  difference() {
    hull() {
      translate([-form_x/2+form_R,-form_y/2+form_R,-lip]) pillar(h+lip,form_R);
      translate([ form_x/2-form_R,-form_y/2+form_R,-lip]) pillar(h+lip,form_R);
      translate([-form_x/2+form_R, form_y/2-form_R,-lip]) pillar(h+lip,form_R);
      translate([ form_x/2-form_R, form_y/2-form_R,-lip]) pillar(h+lip,form_R);
    }
    // main inner space
    hull() {
      translate([-form_x/2+form_R,-form_y/2+form_R,-c-lip]) pillar(h+lip,form_R-form_t);
      translate([ form_x/2-form_R,-form_y/2+form_R,-c-lip]) pillar(h+lip,form_R-form_t);
      translate([-form_x/2+form_R, form_y/2-form_R,-c-lip]) pillar(h+lip,form_R-form_t);
      translate([ form_x/2-form_R, form_y/2-form_R,-c-lip]) pillar(h+lip,form_R-form_t);
    }
    // x inner space
    hull() {
      translate([-pcb_wx/2+form_R,-form_y/2+form_R+form_t,-form_t-lip]) pillar(h+lip,form_R);
      translate([ pcb_wx/2-form_R,-form_y/2+form_R+form_t,-form_t-lip]) pillar(h+lip,form_R);
      translate([-pcb_wx/2+form_R, form_y/2-form_R-form_t,-form_t-lip]) pillar(h+lip,form_R);
      translate([ pcb_wx/2-form_R, form_y/2-form_R-form_t,-form_t-lip]) pillar(h+lip,form_R);
    }
    // y inner space
    hull() {
      translate([-form_x/2+form_R+form_t,-pcb_wy/2+form_R,-form_t-lip]) pillar(h+lip,form_R);
      translate([ form_x/2-form_R-form_t,-pcb_wy/2+form_R,-form_t-lip]) pillar(h+lip,form_R);
      translate([-form_x/2+form_R+form_t, pcb_wy/2-form_R,-form_t-lip]) pillar(h+lip,form_R);
      translate([ form_x/2-form_R-form_t, pcb_wy/2-form_R,-form_t-lip]) pillar(h+lip,form_R);
    }
    // side cutouts
    hull() {
      translate([-form_x,form_ww/2-form_wr,0]) 
        rotate([0,90,0])
           cylinder(r=form_wr,h=2*form_x,$fn=form_sm);
      translate([-form_x,-form_ww/2+form_wr,0]) 
        rotate([0,90,0])
           cylinder(r=form_wr,h=2*form_x,$fn=form_sm);
      translate([-form_x,form_ww/2-form_wr,h-c-form_wr-pcb_h-form_wh]) 
        rotate([0,90,0])
           cylinder(r=form_wr,h=2*form_x,$fn=form_sm);
      translate([-form_x,-form_ww/2+form_wr,h-c-form_wr-pcb_h-form_wh]) 
        rotate([0,90,0])
           cylinder(r=form_wr,h=2*form_x,$fn=form_sm);

      translate([-form_x,form_ww/2-form_wr,-form_wr]) 
        rotate([0,90,0])
           cylinder(r=form_wr,h=2*form_x,$fn=form_sm);
      translate([-form_x,-form_ww/2+form_wr,-form_wr]) 
        rotate([0,90,0])
           cylinder(r=form_wr,h=2*form_x,$fn=form_sm);
      translate([-form_x,form_ww/2-form_wr,h-c-form_wr-pcb_h-form_wh-form_wr]) 
        rotate([0,90,0])
           cylinder(r=form_wr,h=2*form_x,$fn=form_sm);
      translate([-form_x,-form_ww/2+form_wr,h-c-form_wr-pcb_h-form_wh-form_wr]) 
        rotate([0,90,0])
           cylinder(r=form_wr,h=2*form_x,$fn=form_sm);
    }
    // cable hole (bottom only)
    if (bottom) {
      difference() {
        hull() {
          translate([-form_x/2+form_t,hole_w/2-hole_r,0]) 
            cylinder(r=hole_r,h=1.2*h,$fn=form_sm);
          translate([-form_x/2+form_t,-hole_w/2+hole_r,0]) 
            cylinder(r=hole_r,h=1.2*h,$fn=form_sm);
        }
        translate([-form_x/2-1.2*hole_r+form_t,-1.2*hole_w/2,-0.1*h]) 
          cube([1.2*hole_r,1.2*hole_w,2.2*h]);
      }
      rotate([0,90,0]) difference() {
        hull() {
          translate([-h,hole_w/2-hole_r,-form_x/2-form_t+tol]) 
            cylinder(r=hole_r,h=2*form_t,$fn=form_sm);
          translate([-h,-hole_w/2+hole_r,-form_x/2-form_t+tol]) 
            cylinder(r=hole_r,h=2*form_t,$fn=form_sm);
        }
      }
    }
    // bolt holes
    translate([-pcb_bx/2,-pcb_by/2,-1]) 
      cylinder(r=form_bolt_r,h=h+2,$fn=bolt_sm);
    translate([ pcb_bx/2,-pcb_by/2,-1]) 
      cylinder(r=form_bolt_r,h=h+2,$fn=bolt_sm);
    translate([-pcb_bx/2, pcb_by/2,-1]) 
      cylinder(r=form_bolt_r,h=h+2,$fn=bolt_sm);
    translate([ pcb_bx/2, pcb_by/2,-1]) 
      cylinder(r=form_bolt_r,h=h+2,$fn=bolt_sm);
    // cap holes
    translate([-pcb_bx/2,-pcb_by/2,h-c+form_bt+form_bolt_dr]) 
      cylinder(r=form_bolt_R,h=c,$fn=bolt_sm);
    translate([-pcb_bx/2,-pcb_by/2,h-c+form_bt]) 
      cylinder(r1=form_bolt_r,r2=form_bolt_R,h=form_bolt_dr+tol,$fn=bolt_sm);

    translate([ pcb_bx/2,-pcb_by/2,h-c+form_bt+form_bolt_dr]) 
      cylinder(r=form_bolt_R,h=c,$fn=bolt_sm);
    translate([ pcb_bx/2,-pcb_by/2,h-c+form_bt]) 
      cylinder(r1=form_bolt_r,r2=form_bolt_R,h=form_bolt_dr+tol,$fn=bolt_sm);

    translate([-pcb_bx/2, pcb_by/2,h-c+form_bt+form_bolt_dr]) 
      cylinder(r=form_bolt_R,h=c,$fn=bolt_sm);
    translate([-pcb_bx/2, pcb_by/2,h-c+form_bt]) 
      cylinder(r1=form_bolt_r,r2=form_bolt_R,h=form_bolt_dr+tol,$fn=bolt_sm);

    translate([ pcb_bx/2, pcb_by/2,h-c+form_bt+form_bolt_dr]) 
      cylinder(r=form_bolt_R,h=c,$fn=bolt_sm);
    translate([ pcb_bx/2, pcb_by/2,h-c+form_bt]) 
      cylinder(r1=form_bolt_r,r2=form_bolt_R,h=form_bolt_dr+tol,$fn=bolt_sm);
    // lip
    if (bottom) {
      hull() {
        translate([-form_x/2+form_R,-form_y/2+form_R,-tol]) pillar(eps,form_R-form_t/3);
        translate([ form_x/2-form_R,-form_y/2+form_R,-tol]) pillar(eps,form_R-form_t/3);
        translate([-form_x/2+form_R, form_y/2-form_R,-tol]) pillar(eps,form_R-form_t/3);
        translate([ form_x/2-form_R, form_y/2-form_R,-tol]) pillar(eps,form_R-form_t/3);
        translate([-form_x/2+form_R,-form_y/2+form_R,lip_h]) pillar(eps,form_R-2*form_t/3);
        translate([ form_x/2-form_R,-form_y/2+form_R,lip_h]) pillar(eps,form_R-2*form_t/3);
        translate([-form_x/2+form_R, form_y/2-form_R,lip_h]) pillar(eps,form_R-2*form_t/3);
        translate([ form_x/2-form_R, form_y/2-form_R,lip_h]) pillar(eps,form_R-2*form_t/3);
      }
    } else {
      translate([0,0,-lip_h]) difference() {
        hull() {
          translate([-form_x/2+form_R,-form_y/2+form_R,-tol]) pillar(lip_h+tol,form_R+tol);
          translate([ form_x/2-form_R,-form_y/2+form_R,-tol]) pillar(lip_h+tol,form_R+tol);
          translate([-form_x/2+form_R, form_y/2-form_R,-tol]) pillar(lip_h+tol,form_R+tol);
          translate([ form_x/2-form_R, form_y/2-form_R,-tol]) pillar(lip_h+tol,form_R+tol);
        }
        hull() {
          translate([-form_x/2+form_R,-form_y/2+form_R,lip_h]) pillar(eps,form_R-form_t/3);
          translate([ form_x/2-form_R,-form_y/2+form_R,lip_h]) pillar(eps,form_R-form_t/3);
          translate([-form_x/2+form_R, form_y/2-form_R,lip_h]) pillar(eps,form_R-form_t/3);
          translate([ form_x/2-form_R, form_y/2-form_R,lip_h]) pillar(eps,form_R-form_t/3);
          translate([-form_x/2+form_R,-form_y/2+form_R,-tol]) pillar(eps,form_R-2*form_t/3);
          translate([ form_x/2-form_R,-form_y/2+form_R,-tol]) pillar(eps,form_R-2*form_t/3);
          translate([-form_x/2+form_R, form_y/2-form_R,-tol]) pillar(eps,form_R-2*form_t/3);
          translate([ form_x/2-form_R, form_y/2-form_R,-tol]) pillar(eps,form_R-2*form_t/3);
        }
      }
    }
  }
}
 
// tool to check height clearances
module max_level() {
  translate([-2*form_x/3,-4*form_y/3,max_h]) cube([4*form_x/3,4*form_y/3,1]);
  cylinder(r=5,h=max_h,$fn=6);
  translate([-2*form_x/3,-4*form_y/3,-1]) cube([4*form_x/3,4*form_y/3,1]);
}

module assembly() {
  color([0,1,0,1]) translate([0,0,standoff_h/2]) pcb();
  translate([0,0,form_c/2]) form(top_form_h,top_h,lip=lip_h);
  color([0,1,0,1]) translate([0,0,-standoff_h/2-pcb_h]) pcb();
  translate([0,0,-form_c/2]) rotate([0,180,0]) form(bot_form_h,bot_h,bottom=true);
  color([0.7,0.7,0.7,1]) translate([0,0,-standoff_h/2]) standoffs();
  color([0.7,0.7,0.7,1]) translate([0,0,-feet_h-standoff_h/2-pcb_h]) standoffs(feet_h);
  // color([1,0,0,1]) translate([0,2*form_y/3,-feet_h-standoff_h/2-pcb_h]) max_level();
}

module cutaway() {
  difference() {
    assembly();
    translate([0,0,-50]) cube([100,100,100]);
  }
}

assembly();
//cutaway();
// translate([0,0,tol]) 
//  form(top_form_h,top_h,lip=lip_h);
// rotate([0,180,0]) 
//  form(bot_form_h,bot_h,bottom=true);
