include <constants.scad>;

plate_thick = 2.5;
tube_thick = 2;
fan_hole = fan_frame_width - 4;
duct_width_base = 25.4 /* conversion */ * 4 /* inches */;
duct_width_taper = duct_width_base - 2;
transition = 10;
duct_end = 30;
epsilon = 0.01;

$fn = 80;

module main() {
    mounting_plate(roundover_and_margin=minimum_roundover, plate_thick=plate_thick, hole_dia=fan_hole);

    // transition
    difference() {
        cylinder(d1=fan_hole + tube_thick, d2=duct_width_base, h=transition);
        translate([0, 0, -epsilon])
        cylinder(d1=fan_hole, d2=duct_width_base - tube_thick, h=transition + epsilon * 2);
    }

    // duct end
    translate([0, 0, transition - epsilon])
    difference() {
        cylinder(
            d1=duct_width_base,
            d2=duct_width_taper,
        h=duct_end);
        translate([0, 0, -epsilon])
        cylinder(
            d1=duct_width_base - tube_thick,
            d2=duct_width_taper - tube_thick,
            h=duct_end + epsilon * 2);
    }
}

difference() {
    main();
    *translate([0, 0, -50]) cube([100, 100, 100]);
}
