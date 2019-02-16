include <lib-constants.scad>

// The stator is broken into halves for printability. Print two copies and glue.

body_height = 25;
body_wall_thick = 1;
cell_size = 12;
cell_wall = 0.86;


stator_body_half();


module stator_body_half() {
    mounting_plate(
        roundover_and_margin=minimum_roundover,
    plate_thick=2.5,
    hole_dia=fan_frame_width - body_wall_thick * 2);

    linear_extrude(body_height / 2) {
        $fn = cylinder_fn;
        
        difference() {
            // Outer duct
            circle(d=fan_frame_width);
        
            // Inner cutouts
            intersection() {
                // Region constraint
                circle(d=fan_frame_width - body_wall_thick * 2);
                
                // Hex grid of holes
                index_radius = ceil(fan_frame_width / cell_size * 0.6);
                for (ix = [-index_radius:index_radius])
                for (iy = [-index_radius:index_radius]) {
                    translate([ix * cell_size * sin(60), (iy + ix / 2) * cell_size])
                    circle(d=cell_size / sin(60) - cell_wall, $fn=6);
                }
            }
        }
    }
}
