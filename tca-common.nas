var loaded = 1;

var load_overlay = func(carg, subdir, name) {
    if (name == nil) return;
    foreach (var dir; [getprop("/sim/fg-home"), getprop("/sim/fg-root")]) {
        var file = dir ~ "/Input/Joysticks/overlay/" ~ subdir ~ "/" ~ name ~ ".xml";
        if (io.stat(file) != nil) {
            print("Loading overlay " ~ file);
            carg.setValues({command: "nasal", script: ""});
            io.read_properties(file, carg.getParent());
            props.runBinding(carg);
            break;
        }
    }
}

var family_patterns = [
    [ "777-*", "777" ],
    [ "747-*", "747" ],
    [ "dhc6*", "DHC6" ],
    [ "PA28-*", "P28A" ],
    [ "Citation-II*", "C550" ],
    [ "Embraer1[79][05]", "E170" ],
    [ "EmbraerLineage1000", "E170" ],
    [ "A320*", "A320" ],
    [ "MD-11*", "MD11" ],
    [ "Lockheed1049*", "CONI" ],
];

var subtype = getprop('/sim/aircraft');
var type = getprop('/sim/variant-of');
var family = nil;
foreach (var pattern; family_patterns) {
    if (string.match(subtype, pattern[0])) {
        family = pattern[1];
        break;
    }
}

print("Type: " ~ (type or '?') ~ " [" ~ (subtype or '?') ~ "] (" ~ (family or '?') ~ ")");
