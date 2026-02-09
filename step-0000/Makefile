SHELL := /bin/bash

all: jonesforth

jonesforth: jonesforth.S
	gcc -g -m32 -nostdlib -static -o $@ $<

run: jonesforth
	./jonesforth

debug: jonesforth
	gdb ./jonesforth

debug-script: jonesforth gdb/debug.gdb
	gdb -x gdb/debug.gdb ./jonesforth

debug-script-run: jonesforth gdb/debug.gdb gdb/run.gdb
	gdb -x gdb/debug.gdb -x gdb/run.gdb ./jonesforth

debug-dashboard: jonesforth gdb/gdb-dashboard.gdb gdb/debug-dashboard.gdb gdb/debug.gdb
	gdb -nx -x gdb/gdb-dashboard.gdb -x gdb/debug-dashboard.gdb -x gdb/debug.gdb ./jonesforth

debug-dashboard-run: jonesforth gdb/gdb-dashboard.gdb gdb/debug-dashboard.gdb gdb/debug.gdb gdb/run.gdb
	gdb -nx -x gdb/gdb-dashboard.gdb -x gdb/debug-dashboard.gdb -x gdb/debug.gdb -x gdb/run.gdb ./jonesforth

debug-map: jonesforth gdb/memory-map.gdb
	gdb -q -x gdb/memory-map.gdb ./jonesforth

clean:
	rm -f jonesforth *~ core

.PHONY: all run debug debug-script debug-script-run debug-dashboard debug-dashboard-run debug-map clean
