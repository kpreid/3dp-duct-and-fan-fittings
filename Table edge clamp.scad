include <constants.scad>

// measured about table
table_thick = 7;
table_underside_before_pipe = 54;

// chosen
plate_thick = 2.5;
channel_vert_thick = 2;
channel_depth = 20;
adaptation_length = 20;

// calculated
overall_length = fan_mounting_hole_spacing + adaptation_length + table_underside_before_pipe;
fan_hole = fan_frame_width - 4;  // TODO duplicate with fan_to_duct.scad


epsilon = 0.01;


main();

module main() {

    $fn = 80;

    // unused, delete
    module channel() {
        difference() {
            translate([-fan_frame_width / 2 - channel_vert_thick, 0])
            square([fan_frame_width + channel_vert_thick * 2, channel_depth]);
            translate([-fan_frame_width / 2, plate_thick])
            square([fan_frame_width, channel_depth]);
        }
    }
    
    difference() {
        union() {
            translate([-fan_mounting_hole_spacing / 2, -fan_mounting_hole_spacing / 2, 0])
            linear_extrude(plate_thick)
            mounting_plate_positive_2d();
            
        }
        
        if (false)
        rotate([90, 0, 0])
        linear_extrude(fan_frame_width * 2, convexity=10)
        channel();
        
        frame_hole_negative();
        cylinder(d=fan_hole, h=1000, center=true);
    }

    braces();
    
    module braces() {
        brace();
        scale([-1, 1, 1]) brace();
    }
    
    module brace() {
        outer = fan_frame_width / 2 + plate_thick / 4;
        thick = channel_vert_thick;
        difference() {
            hull_chain() {
                // far fan corner
                translate([outer, -fan_mounting_hole_spacing / 2, 0])
                cylinder(d=thick, h=plate_thick, $fn=8);

                // near fan corner + span middle
                translate([outer, fan_frame_width / 2, 0])
                cylinder(d=thick, h=channel_depth, $fn=8);

                // span middle
                hull() {
                    translate([outer, fan_frame_width / 2, 0])
                    cylinder(d=thick, h=channel_depth, $fn=8);

                    translate([0, fan_frame_width / 2, 0])
                    cylinder(d=thick, h=channel_depth, $fn=8);
                }
                
                // central taper point
                translate([0, fan_frame_width / 2 + adaptation_length, 0])
                cylinder(d=thick, h=channel_depth, $fn=8);
                
                // end of brace
                translate([0, overall_length - fan_frame_width / 2 - thick / 2, 0])
                cylinder(d=thick, h=plate_thick, $fn=8);
            }
            
            nut_access_thick = 6;
            translate([fan_mounting_hole_spacing / 2, fan_mounting_hole_spacing / 2, plate_thick + nut_access_thick / 2])
            cylinder(d=25, h=nut_access_thick, center=true);
        }
    }
}

module mounting_plate_positive_2d() {
    minkowski() {
        circle(r=minimum_roundover);
        translate([-channel_vert_thick, 0])
        square([fan_mounting_hole_spacing + channel_vert_thick * 2, overall_length - minimum_roundover * 2]);
    }
}

module hull_chain() {
    if ($children <= 1) {
        children();
    } else {
        for (i = [0:$children-2]) {
            hull() children([i, i+1]);
        }
    }
}