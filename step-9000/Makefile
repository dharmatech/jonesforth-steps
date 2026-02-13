
#BUILD_ID_NONE := -Wl,--build-id=none 
BUILD_ID_NONE := 

SHELL	:= /bin/bash
TRACE_INPUT := .trace.input.f
DEBUG_INPUT := .debug.input.f

all:	jonesforth

jonesforth: jonesforth.S
	gcc -g -m32 -nostdlib -static $(BUILD_ID_NONE) -o $@ $<

run:
	cat jonesforth.f $(PROG) - | ./jonesforth

run_exit:
	cat jonesforth.f $(PROG) <(echo BYE) | ./jonesforth

debug:
	gdb -q ./jonesforth

# Open GDB and let the user set breakpoints before running.
debug_run: jonesforth
	gdb -q ./jonesforth

# Convenience: break at _start, preload jonesforth.f, then keep stdin interactive.
debug_run_start: jonesforth
	gdb -q -ex "break _start" -ex "run < <(cat jonesforth.f -)" ./jonesforth

debug_prog: jonesforth
	@test -n "$(PROG)" || (echo "Usage: make debug_prog PROG=examples/add.f" && exit 1)
	@cat jonesforth.f $(PROG) <(echo BYE) > $(DEBUG_INPUT)
	gdb -q -ex "break _start" -ex "run < $(DEBUG_INPUT)" ./jonesforth

tmux_run_gdb: jonesforth
	@command -v tmux >/dev/null || (echo "tmux not found" && exit 1)
	@command -v gdb >/dev/null || (echo "gdb not found" && exit 1)
	@OLD_PIDS="$$(pgrep -x jonesforth 2>/dev/null | tr '\n' ' ')"; \
	SESSION="jonesdbg-$$RANDOM"; \
	tmux new-session -d -s "$$SESSION" -n "dbg" "bash -lc 'make -C $(CURDIR) run PROG=\"$(PROG)\"'"; \
	tmux set-option -t "$$SESSION" -g mouse on; \
	tmux split-window -h -t "$$SESSION:0"; \
	tmux send-keys -t "$$SESSION:0.1" "bash -lc 'OLD_PIDS=\"$$OLD_PIDS\"; while true; do for PID in \$$(pgrep -x jonesforth 2>/dev/null); do case \" $$OLD_PIDS \" in *\" \$$PID \"*) ;; *) exec gdb -q -p \$$PID ;; esac; done; sleep 0.05; done'" C-m; \
	tmux select-layout -t "$$SESSION:0" even-horizontal; \
	tmux attach -t "$$SESSION"

tmux_trace_loop: jonesforth gdb/trace-loop.gdb
	@command -v tmux >/dev/null || (echo "tmux not found" && exit 1)
	@command -v gdb >/dev/null || (echo "gdb not found" && exit 1)
	@OLD_PIDS="$$(pgrep -x jonesforth 2>/dev/null | tr '\n' ' ')"; \
	SESSION="jonesdbg-$$RANDOM"; \
	tmux new-session -d -s "$$SESSION" -n "dbg" "bash -lc 'make -C $(CURDIR) run PROG=\"$(PROG)\"'"; \
	tmux set-option -t "$$SESSION" -g mouse on; \
	tmux split-window -h -t "$$SESSION:0"; \
	tmux send-keys -t "$$SESSION:0.1" "bash -lc 'OLD_PIDS=\"$$OLD_PIDS\"; while true; do for PID in \$$(pgrep -x jonesforth 2>/dev/null); do case \" $$OLD_PIDS \" in *\" \$$PID \"*) ;; *) exec gdb -q -ex \"source $(CURDIR)/gdb/trace-loop.gdb\" -ex \"trace-loop\" -p \$$PID ;; esac; done; sleep 0.05; done'" C-m; \
	tmux select-layout -t "$$SESSION:0" even-horizontal; \
	tmux attach -t "$$SESSION"

trace: jonesforth gdb/trace.gdb
	@test -n "$(PROG)" || (echo "Usage: make trace PROG=examples/add.f" && exit 1)
	@{ cat jonesforth.f; \
	   echo ': __TRACE_GATE__ ; __TRACE_GATE__'; \
	   cat $(PROG); \
	   echo; \
	   echo BYE; } > $(TRACE_INPUT)
	gdb -q -x gdb/trace.gdb ./jonesforth
	$(MAKE) trace-norm

trace_core: jonesforth gdb/trace-core.gdb
	@test -n "$(PROG)" || (echo "Usage: make trace_core PROG=examples/core-add.f" && exit 1)
	@{ cat $(PROG); echo; } > $(TRACE_INPUT)
	gdb -q -x gdb/trace-core.gdb ./jonesforth
	$(MAKE) trace-norm

trace-norm:
	@test -f trace.md || (echo "trace.md not found; run 'make trace PROG=...' first." && exit 1)
	perl -pe 's/\b0x([0-9a-fA-F]{7})\b/"0x0$$1"/ge' trace.md > trace.norm.md

clean:
	rm -f jonesforth perf_dupdrop *~ core .test_* trace.md trace.norm.md $(TRACE_INPUT) $(DEBUG_INPUT)

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
.PHONY: test check run run_exit debug debug_run debug_run_start debug_prog tmux_run_gdb tmux_trace_loop trace trace_core trace-norm run_perf_dupdrop
