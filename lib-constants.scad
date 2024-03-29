fan_mounting_hole_spacing = 105;
fan_mounting_hole_diameter = 4.3;  // slightly oversized for #8, will probably need drilling anyway
fan_frame_width = 120;

duct_diameter_nominal = 25.4 /* conversion */ * 4 /* inches */;
duct_taper_extreme = 1.5;
duct_fitting_length = 30;

minimum_roundover = (fan_frame_width - fan_mounting_hole_spacing) / 2;
cylinder_fn = 80;

module mounting_plate(roundover_and_margin, plate_thick, hole_dia) {
  difference() {
        minkowski() {
            // each of these has half height so the sum is full height
            cylinder(r=roundover_and_margin, h=plate_thick / 2, center=true);
            cube([fan_mounting_hole_spacing, fan_mounting_hole_spacing, plate_thick / 2], center=true);
        }
        
        cylinder(d=hole_dia, h=plate_thick * 2, center=true, $fn=cylinder_fn);
        
        frame_hole_negative();
    }
}

module frame_hole_negative(h=1000) {
    frame_hole_pattern() cylinder(d=fan_mounting_hole_diameter, h=h, center=true);
}

module frame_hole_pattern() {
    r = fan_mounting_hole_spacing / 2;
    translate([ r,  r, 0]) children();
    translate([-r,  r, 0]) children();
    translate([ r, -r, 0]) children();
    translate([-r, -r, 0]) children();
}