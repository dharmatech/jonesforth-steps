# Scenario 002: `_FIND`

Goal: step through `_FIND` and watch dictionary lookup state evolve in real time.

## Run

From `step-9000-full`:

```bash
make gdb-scenario-002-find
```

Or directly:

```bash
gdb -q -x gdb-scenarios/002-find/session.gdb ./jonesforth
```

In GDB:

```gdb
find-run
find-show
find-step
find-steps 10
find-go
```

## Notes

- `find-show` uses `ui-find` and also shows `currkey`, `bufftop`, and `ui-buffer`.
- `find-step` uses `stepi-FIND_` so each step prints the focused `_FIND` view.
- `find-run` uses `gdb-scenarios/002-find/input.f`.
