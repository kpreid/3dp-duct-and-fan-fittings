include <lib-constants.scad>

// The stator is broken into halves for printability. Print two copies and glue.

body_height = 25;
body_wall_thick = 1;
vane_wall = 0.86;
hub_diameter = 36;
center_hole_diameter = 25.4 / 4;  // hole for temporary 1/4" bolt
plate_thick = 2.5;  // TODO: make a common constant


stator_body_half();


module stator_body_half() {
    translate([0, 0, plate_thick / 2])
    mounting_plate(
        roundover_and_margin=minimum_roundover,
    plate_thick=plate_thick,
    hole_dia=fan_frame_width - body_wall_thick * 2);

    linear_extrude(body_height / 2) {
        $fn = cylinder_fn;
        
        difference() {
            // Outer duct
            circle(d=fan_frame_width);
        
            // Inner cutouts
            difference() {
                // Interior volume
                circle(d=fan_frame_width - body_wall_thick * 2);
                
                // Double-negated stator vanes
                for (angle = [0:15:180])
                rotate(angle)
                square([vane_wall, fan_frame_width], center=true);
                
                // Center hub
                circle(d=hub_diameter);
            }
            
            // Assembly clamping hole
            circle(d=center_hole_diameter);
        }
    }
}
