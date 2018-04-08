include <constants.scad>;

frame_thick = 2;
tube_thick = 2;
fan_hole = fan_frame_width - 4;
duct_width = 25.4 * 4;
transition = 20;
duct_end = 50;
epsilon = 0.5;

$fn = 80;

intersection() {
    difference() {
        cube([fan_frame_width, fan_frame_width, frame_thick], center=true);
        cylinder(d=fan_hole, h=frame_thick * 2, center=true);
    }
}

// transition
difference() {
    cylinder(d1=fan_hole + tube_thick, d2=duct_width, h=transition);
    translate([0, 0, -epsilon])
    cylinder(d1=fan_hole, d2=duct_width - tube_thick, h=transition + epsilon * 2);
}

// duct end
translate([0, 0, transition - epsilon])
difference() {
    cylinder(d=duct_width, h=duct_end);
    translate([0, 0, -epsilon])
    cylinder(d=duct_width - tube_thick, h=duct_end + epsilon * 2);
}
