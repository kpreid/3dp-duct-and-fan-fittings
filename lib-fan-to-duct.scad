include <lib-constants.scad>;

module fan_to_duct(is_male_end) {
    plate_thick = 2.5;
    tube_thick = 2.5;
    fan_hole = fan_frame_width - 4;
    duct_diameter_nominal = 25.4 /* conversion */ * 4 /* inches */;
    duct_taper_extreme = 1.5;
    transition = 10;
    duct_end = 30;
    epsilon = 0.01;

    duct_od_base = duct_diameter_nominal + (is_male_end ? duct_taper_extreme : tube_thick);
    duct_od_tip = duct_diameter_nominal + (is_male_end ? -duct_taper_extreme : tube_thick);

    $fn = cylinder_fn;

    module main() {
        mounting_plate(roundover_and_margin=minimum_roundover, plate_thick=plate_thick, hole_dia=fan_hole);

        // transition
        difference() {
            cylinder(d1=fan_hole + tube_thick, d2=duct_od_base, h=transition);
            translate([0, 0, -epsilon])
            cylinder(d1=fan_hole, d2=duct_od_base - tube_thick, h=transition + epsilon * 2);
        }

        // duct end
        translate([0, 0, transition - epsilon])
        difference() {
            cylinder(
                d1=duct_od_base,
                d2=duct_od_tip,
            h=duct_end);
            translate([0, 0, -epsilon])
            cylinder(
                d1=duct_od_base - tube_thick,
                d2=duct_od_tip - tube_thick,
                h=duct_end + epsilon * 2);
        }
    }

    difference() {
        main();
        
        // cut for debugging
        *translate([0, 0, -50]) cube([100, 100, 100]);
    }
}