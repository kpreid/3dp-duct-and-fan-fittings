include <constants.scad>;

// must be at least 7.5 mm to allow for the difference between hole pattern and frame size, but we also want to fit over a bad/misaligned hole
roundover_and_margin = 7.5 + 4;
plate_thick = 1.5;

screen_frame_thick = 1;
screen_slat_thick = 1;
screen_across = fan_frame_width + 5;
screen_depth = 15;
screen_slat_spacing = 14;
screen_slat_phase = 0;

epsilon = 0.1;

translate([0, 0, plate_thick / 2])
mounting_plate(roundover_and_margin=roundover_and_margin, plate_thick=plate_thick, hole_dia=screen_across);

// frame of louver
translate(plate_thick - epsilon)
screen();

module screen() {
    translate([0, 0, screen_depth / 2])
    difference() {
      cylinder(
        d1=screen_across + screen_frame_thick * 4,
        d2=screen_across + screen_frame_thick * 2,
        h=screen_depth,
        center=true);
      cylinder(d=screen_across, h=screen_depth + epsilon, center=true);
    }

    difference() {
        intersection() {
            for (i = [-5:4]) {
                diag = isosceles_hypotenuse(screen_depth * 2) - isosceles_hypotenuse(screen_slat_thick);

                translate([0, screen_slat_phase + screen_slat_spacing * i, 0])
                rotate([45, 0, 0])
                cube([screen_across, diag, screen_slat_thick], center=true);
            }
            cylinder(d=screen_across + epsilon, h=1000, center=true);
        }
        
        // cut slats off at base for support
        halfneg = -(screen_across + epsilon) / 2;
        translate([halfneg, halfneg, -screen_depth])
        cube([screen_across + epsilon, screen_across + epsilon, screen_depth]);
    }
}

function isosceles_hypotenuse(d) = sqrt(pow(d, 2) * 2);