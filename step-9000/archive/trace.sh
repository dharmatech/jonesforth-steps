#!/usr/bin/bash

gdb \
	-ex 'source ../../../python-gdb-ui/gdb_program_ui.py' \
	-ex 'source ../../gdb/trace-core-no-deps.gdb' \
	../../jonesforth

perl -pe 's/\b0x([0-9a-fA-F]{7})\b/"0x0$1"/ge' trace.md > trace.norm.md
