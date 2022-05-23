# Thrustmaster TCA Airbus Edition Configuration for FlightGear

This is my joystick configuration for the TCA Airbus Edition flightstick and
throttle quadrant. It features automatic aircraft type detection, and loads
additional configuration "overlays" to map aircraft-specific bindings to axes
and buttons.

## Installation

- Unpack into a directory of your choice. If you've downloaded the source code
  zip from github, it will contain a single folder named
  `flightgear-joystick-config-tca-master` or similar; if so, you need the files
  *inside* that folder. If you've used `git clone`, then the files you need
  will be directly at the top level.
- Copy or symlink all these files into the FlightGear joystick configuration
  folder. On a typical Linux system, this will be
  `$HOME/.fgfs/Input/Joysticks`.

**WARNING:** If you use the in-sim joystick configuration GUI, it will
overwrite your XML configuration without warning, so it's a good idea to keep
your original copies around, in case that happens.

## Modifying / Customizing

### Modifying default bindings.

Default bindings are defined in `Thrustmaster-TA320-Pilot.xml` for the
sidestick, and `Thrustmaster-TCA-Q-Eng-1&2.xml` for the throttle quadrant.
Inside these files, there's a chunk of Nasal code at the top, in a `<nasal>`
tag, which I suggest you don't mess with, because that's the bit that does the
aircraft detection and overlay loading magic; everything else is regular XML
joystick configuration stuff.

### Modifying aircraft-specific bindings.

Aircraft-specific bindings are defined as "overlays", and can be found in
`overlay/TA320-Pilot/` and `overlay/TCA-Q-Eng12/`. These files are named
by aircraft type or family, and more than one can be loaded for a given type
(more on that below). They are regular XML joystick binding files, too, but
anything you define in them will overwrite the defaults.

### Adding more aircraft types.

Overlays are loaded based on 3 values:

- "Subtype": the exact name of the current aircraft model, as found in the
  property `/sim/aircraft`. For example, this might read "CRJ900LR".
- "Type": the name of the current family of aircraft models, as found in the
  property `/sim/variant-of`. For the CRJ900LR, this would be "CRJ700".
- "Family": a more general name of the aircraft type family, possibly
  independent from the specific FG model loaded. This one is found by matching
  against a list called `family_patterns`, found in `tca-common.nas`.

Typically, you would do the following to add a new aircraft type:

1. Fire up FlightGear, open the property browser (`/` key), and navigate to
   `/sim/variant-of`. Note whatever that says, or, if it's empty, use
   `/sim/aircraft` instead, e.g. `J3Cub`.
2. Create new XML file in `overlay/TA320-Pilot` and `overlay/TCA-Q-Eng12`, e.g.
   `overlay/TA320-Pilot/J3Cub.xml` and `overlay/TCA-Q-Eng12/J3Cub.xml`, with
   `<PropertyList>` as the root element, and `<axis>` and `<button>` elements
   for each binding you want to add or override.

### Some tips:

- Overriding is done by merging XML subtrees, so you need to use the `n="..."`
  attribute to make sure the right ones get overwritten.
- Because of the XML subtree merging thing, you cannot *remove* existing XML
  elements, you can only *change* their contents. A caveat with this is that
  when the default contains multiple bindings, you have to override them *all*,
  and if there is a `<condition>` anywhere, it will not be removed by
  overwriting the parent binding. This can be surprising at times, but there
  is not much I can do about it.
- You can test your configuration more quickly by using the "Debug" -> "Reload
  Inputs" menu item inside FG; it will reload the entire configuration, and
  re-run the aircraft detection, so even if you fiddle with the latter, you
  still don't need to reload FG itself.
