include <lib-constants.scad>


duct_end_vent();


module duct_end_vent() {
    wall_thickness = 1.25;
    box_end_z = 10;
    box_width = duct_diameter_nominal;
    taper_end_z = 40;
    epsilon = 0.01;

    duct_od_base = duct_diameter_nominal + duct_taper_extreme;
    duct_od_tip = duct_diameter_nominal - duct_taper_extreme;

    $fn = cylinder_fn;

    module interior_form(extra=false) {
        hull() {
            translate([-0.5, -0.5, 0] * box_width)
            cube([box_width, box_width, box_end_z / 2 + epsilon]);
            
            translate([0, 0, taper_end_z])
            cylinder(d=duct_od_base - wall_thickness, h=epsilon);
        }
        
        translate([0, 0, taper_end_z])
        cylinder(
            d1=duct_od_base - wall_thickness,
            d2=duct_od_tip - wall_thickness,
            h=duct_fitting_length + epsilon);
    }

    module main() {
        difference() {
            minkowski(convexity=6) {
                interior_form(false);
                octahedron(wall_thickness);
            }
            interior_form(true);
            
            // cut top open flat
            translate([0, 0, duct_fitting_length + taper_end_z]) 
            cylinder(d=duct_diameter_nominal * 2, h=wall_thickness * 2);
            
            // cut bottom open flat
            if (false)
            translate([0, 0, epsilon]) 
            mirror([0, 0, 1])
            cylinder(d=duct_diameter_nominal * 2, h=wall_thickness * 2);
            
            // cut bottom open in a grid
            n = 10;
            rib_width = 1.2;
            step = (box_width - rib_width) / n;
            for (ix = [0:n - 1])
            for (iy = [0:n - 1])
            translate([
                -box_width / 2 + rib_width + ix * step,
                -box_width / 2 + rib_width + iy * step, 
                -wall_thickness - epsilon])
            cube([step - rib_width, step - rib_width, wall_thickness + epsilon * 2]);
        }
    }

    difference() {
        main();
        
        // cut for debugging
        *translate([0, 0, 0]) cube([100, 100, 100]);
    }

    module octahedron(r) {
        scale([r, r, r])
        polyhedron(
            points=[
                [1, 0, 0],
                [-1, 0, 0],
                [0, 1, 0], 
                [0, -1, 0],
                [0, 0, 1],
                [0, 0, -1],
            ],
            faces=[
                [0, 4, 2],
                [0, 2, 5],
                [0, 3, 4],
                [0, 5, 3],
                [1, 2, 4],
                [1, 5, 2],
                [1, 4, 3],
                [1, 3, 5],
            ], convexity=1);
    }
}