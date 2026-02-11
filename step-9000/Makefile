
#BUILD_ID_NONE := -Wl,--build-id=none 
BUILD_ID_NONE := 

SHELL	:= /bin/bash
TRACE_INPUT := .trace.input.f

all:	jonesforth

jonesforth: jonesforth.S
	gcc -g -m32 -nostdlib -static $(BUILD_ID_NONE) -o $@ $<

run:
	cat jonesforth.f $(PROG) - | ./jonesforth

run_exit:
	cat jonesforth.f $(PROG) <(echo BYE) | ./jonesforth

trace: jonesforth gdb/trace.gdb
	@test -n "$(PROG)" || (echo "Usage: make trace PROG=examples/add.f" && exit 1)
	@cat jonesforth.f $(PROG) <(echo BYE) > $(TRACE_INPUT)
	gdb -q -x gdb/trace.gdb ./jonesforth
	$(MAKE) trace-norm

trace-norm:
	@test -f trace.md || (echo "trace.md not found; run 'make trace PROG=...' first." && exit 1)
	perl -pe 's/\b0x([0-9a-fA-F]{7})\b/"0x0$$1"/ge' trace.md > trace.norm.md

clean:
	rm -f jonesforth perf_dupdrop *~ core .test_* trace.md trace.norm.md $(TRACE_INPUT)

# Tests.

TESTS	:= $(patsubst tests/%.f,%.test,$(wildcard tests/test_*.f))

test check: $(TESTS)

test_%.test: tests/test_%.f jonesforth
	@echo -n "$< ... "
	@rm -f .$@
	@cat <(echo ': TEST-MODE ;') jonesforth.f $< <(echo 'TEST') | \
	  ./jonesforth 2>&1 | \
	  sed 's/DSP=[0-9]*//g' > .$@
	@diff -u .$@ $<.out
	@rm -f .$@
	@echo "ok"

# Performance.

perf_dupdrop: perf_dupdrop.c
	gcc -m32 -O3 -Wall -Werror -o $@ $<

run_perf_dupdrop: jonesforth
	cat <(echo ': TEST-MODE ;') jonesforth.f perf_dupdrop.f | ./jonesforth

.SUFFIXES: .f .test
.PHONY: test check run run_exit trace trace-norm run_perf_dupdrop
