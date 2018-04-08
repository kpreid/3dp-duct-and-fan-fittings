fan_mounting_hole_spacing = 105;
fan_mounting_hole_diameter = 4.3;  // slightly oversized for #8, will probably need drilling anyway
fan_frame_width = 120;

module frame_hole_negative(h=1000) {
    frame_hole_pattern() cylinder(d=fan_mounting_hole_diameter, h=h, center=true);
}

module frame_hole_pattern() {
    r = fan_mounting_hole_spacing / 2;
    translate([ r,  r, 0]) children();
    translate([-r,  r, 0]) children();
    translate([ r, -r, 0]) children();
    translate([-r, -r, 0]) children();
}