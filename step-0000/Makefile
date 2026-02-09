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

trace: jonesforth gdb/run-alt.gdb
	gdb -q -x gdb/run-alt.gdb ./jonesforth
	$(MAKE) trace-norm

trace-norm:
	@test -f trace.md || (echo "trace.md not found; run 'make trace' first." && exit 1)
	perl -pe 's/\b0x([0-9a-fA-F]{7})\b/"0x0$$1"/ge' trace.md > trace.norm.md

clean:
	rm -f jonesforth trace.txt trace.norm.txt trace.md trace.norm.md *~ core

.PHONY: all run debug debug-script debug-script-run debug-dashboard debug-dashboard-run debug-map trace trace-norm clean
