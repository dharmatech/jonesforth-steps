SHELL := /bin/bash

all: jonesforth

jonesforth: jonesforth.S
	gcc -g -m32 -nostdlib -static -o $@ $<

run: jonesforth
	./jonesforth

debug: jonesforth
	gdb ./jonesforth

debug-script: jonesforth debug.gdb
	gdb -x debug.gdb ./jonesforth

debug-script-run: jonesforth debug.gdb run.gdb
	gdb -x debug.gdb -x run.gdb ./jonesforth

debug-dashboard: jonesforth gdb-dashboard.gdb debug-dashboard.gdb debug.gdb
	gdb -nx -x gdb-dashboard.gdb -x debug-dashboard.gdb -x debug.gdb ./jonesforth

debug-dashboard-run: jonesforth gdb-dashboard.gdb debug-dashboard.gdb debug.gdb run.gdb
	gdb -nx -x gdb-dashboard.gdb -x debug-dashboard.gdb -x debug.gdb -x run.gdb ./jonesforth

debug-map: jonesforth memory-map.gdb
	gdb -q -x memory-map.gdb ./jonesforth

clean:
	rm -f jonesforth *~ core

.PHONY: all run debug debug-script debug-script-run debug-dashboard debug-dashboard-run debug-map clean
