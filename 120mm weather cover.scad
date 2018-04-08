include <constants.scad>;

// must be at least 7.5 mm to allow for the difference between hole pattern and frame size, but we also want to fit over a bad hole
roundover_and_margin = 7.5 + 8;
plate_thick = 2;

screen_frame_thick = 1;
screen_slat_thick = 1;
screen_across = fan_frame_width;
screen_depth = 10;

epsilon = 0.1;

translate([0, 0, plate_thick / 2])
difference() {
    minkowski() {
        // each of these has half height so the sum is full height
        cylinder(r=roundover_and_margin, h=plate_thick / 2, center=true);
        cube([fan_mounting_hole_spacing, fan_mounting_hole_spacing, plate_thick / 2], center=true);
    }
    
    cylinder(r=fan_frame_width / 2, h=plate_thick * 2, center=true);
    
    frame_hole_negative();
}

// frame of louver
translate(plate_thick - epsilon)
screen();

module screen() {
    translate([0, 0, screen_depth / 2])
    difference() {
      big_across = screen_across + screen_frame_thick * 2;
      cube([big_across, screen_across - epsilon, screen_depth], center=true);
      cube([screen_across, screen_across, screen_depth + epsilon], center=true);
    }

    difference() {
        intersection() {
            for (i = [-10:10]) {
                diag = isosceles_hypotenuse(screen_depth * 2) - isosceles_hypotenuse(screen_slat_thick);

                translate([0, 10 * i, 0])
                rotate([45, 0, 0])
                cube([screen_across, diag, screen_slat_thick], center=true);
            }
            cube([screen_across + epsilon, screen_across + epsilon, 1000], center=true);
        }
        
        // cut slats off at base for support
        halfneg = -(fan_frame_width + epsilon) / 2;
        translate([halfneg, halfneg, -screen_depth])
        cube([fan_frame_width + epsilon, fan_frame_width + epsilon, screen_depth]);
    }
}

function isosceles_hypotenuse(d) = sqrt(pow(d, 2) * 2);