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

debug-dashboard: jonesforth gdb-dashboard.gdb debug.gdb
	gdb -nx -x gdb-dashboard.gdb -x debug.gdb ./jonesforth

clean:
	rm -f jonesforth *~ core

.PHONY: all run debug debug-script debug-dashboard clean
