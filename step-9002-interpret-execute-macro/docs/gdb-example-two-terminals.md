
Run JONESFORTH in a terminal.

Then run GDB in another terminal attaching to JONESFORTH in the other terminal.

# terminal 1

    cat jonesforth.f - | ./jonesforth

# terminal 2

    pgrep jonesforth
    gdb -q -p 889723 -ex 'source gdb/forth-dict.gdb'

Or:

    gdb -q -p `pgrep jonesforth` -ex 'source gdb/forth-dict.gdb'

# Interaction

At this point, you can run `forth-next-known` at the `(gdb)` prompt.

Then you can enter expressions at the JF prompt and see gdb update.