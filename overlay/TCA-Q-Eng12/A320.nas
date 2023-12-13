var setThrust = func (e, v) {
    print(v);
    if (v > 0.55) {
        setprop('controls/engines/engine[' ~ e ~ ']/reverse-engage', 1);
        setprop('controls/engines/engine[' ~ e ~ ']/reverse-lever', 1);
        setprop('controls/engines/engine[' ~ e ~ ']/throttle', (v - 0.55) * 2);
    }
    else {
        setprop('controls/engines/engine[' ~ e ~ ']/reverse-engage', 0);
        setprop('controls/engines/engine[' ~ e ~ ']/reverse-lever', 0);
        setprop('controls/engines/engine[' ~ e ~ ']/reverse-lever', 0);
        if (v > 0.44) {
            setprop('controls/engines/engine[' ~ e ~ ']/throttle', 0);
        }
        elsif (v > 0.01) {
            # MAN
            setprop('controls/engines/engine[' ~ e ~ ']/throttle', 0.63 * (v - 0.44) / -0.44);
        }
        elsif (v > -0.41) {
            # CL
            setprop('controls/engines/engine[' ~ e ~ ']/throttle', 0.63);
        }
        elsif (v > -0.90) {
            # MCT
            setprop('controls/engines/engine[' ~ e ~ ']/throttle', 0.8);
        }
        else {
            # TOGA
            setprop('controls/engines/engine[' ~ e ~ ']/throttle', 1.0);
        }
    }
};

var synchronizeLights = func {
    if (getprop('controls/lighting/turnoff-light-switch')) {
        if (getprop('controls/switches/landing-lights-l') == 1) {
            # Landing lights are on: turn nose light to the "TO"
            # position
            setprop('controls/lighting/taxi-light-switch', 1);
        }
        else {
            # Landing lights are off: use the "TAXI" switch position
            setprop('controls/lighting/taxi-light-switch', 0.5);
        }
    }
    else {
        if (getprop('controls/switches/landing-lights-l') == 1) {
            # Landing lights are on: keep nose light to the "TO"
            # position
            setprop('controls/lighting/taxi-light-switch', 1);
        }
        else {
            # Landing lights are off: use the "OFF" switch position
            setprop('controls/lighting/taxi-light-switch', 0);
        }
    }
}
