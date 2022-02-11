var setThrust = func (e, v) {
    print(v);
    if (v > 0.5) {
        setprop('controls/engines/engine[' ~ e ~ ']/throttle', 0);
        setprop('controls/engines/engine[' ~ e ~ ']/reverse-lever', (v - 0.5) * 2.0);
    }
    else {
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
