include <constants.scad>;

// must be at least 7.5 mm to allow for the difference between hole pattern and frame size, but we also want to fit over a bad hole
roundover_and_margin = 7.5 + 8;
plate_thick = 2;

difference() {
    minkowski() {
        cylinder(r=roundover_and_margin, h=plate_thick / 2);
        cube([fan_mounting_hole_spacing, fan_mounting_hole_spacing, plate_thick / 2], center=true);
    }
    
    cylinder(r=fan_frame_width / 2, h=plate_thick * 2, center=true);
    
    frame_hole_negative();
}