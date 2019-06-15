This is a collection of adapters to combine 4" ducts (as commonly used for venting clothes dryers) and 120 mm "computer case" fans in various ways. Make your own small-scale ventilation systems with commodity parts.

## Components

* `fan-to-duct-inner.scad` bolts to a fan and fits into the end of 4" duct. While the taper will often let it fit fairly snugly, additional materials may be desired to secure the duct — tape, glue, screws. If using screws, be sure to pre-drill the hole to avoid cracking apart the plastic layers.

* `fan-to-duct-outer.scad` bolts to a fan and is the size of 4" duct, so it accepts tubes designed to insert into 4" duct.

Note that 4" ducts are widely varying in fit and you may need to adjust the sizes or add tape or other filler to make a snug connection.

* `fan-louver.scad` provides moderate weather/finger protection for a 120 mm fan mounted to the other side of a panel. (It would be oversized if used for a duct, but a redesign would be feasible.)

* `stator.scad` is a simple stator (in the fluid dynamic sense, not the electric motor sense) for 120 mm fans. When using two fans in series, placing the stator between them will provide a moderate improvement in performance. **Print two copies and glue them together,** using the 1/4" center hole for alignment while gluing.

* `fan-table-edge-clamp.scad` adds a flat plate sticking out of the side of an assembly of the other 120 mm components, which may be used with a clamp to secure the assembly to the edge of a flat surface perpendicular to the direction of the duct. This design needs work — it lacks some tolerances and room for nut/bolt insertion.

## License

Copyright 2018, 2019 Kevin Reid <kpreid@switchb.org>

This work is licensed under a <a rel="license" href="https://creativecommons.org/licenses/by/4.0/">Creative Commons Attribution 4.0 International License</a>.
