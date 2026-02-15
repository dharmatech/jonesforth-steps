
# gdb -q -x archive/loop-until-key.gdb ./jonesforth

define stepi-until-key

    while (1 < 2)
        # if we're at _KEY then exit loop
        #    ....
        # otherwise stepi:
        stepi
    end

end


define stepi-skip-key

    while (1 < 2)
        if $pc == _KEY
            # Do not stepi through _KEY
            # Continue until the _KEY routine returns.
            finish
        else
            stepi
        end
    end
end


define stepi-loop
    while (1 < 2)
        stepi
    end
end

define setup-logging
    set logging file trace.md
    set logging overwrite on
    set logging redirect on
    set logging enabled on
    set confirm off
end

# ----------------------------------------------------------------------

break _start

# break _KEY

run < examples/core-add.f

setup-logging

# stepi-loop

stepi-skip-key