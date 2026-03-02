# Scenario 000: `_KEY`

Goal: step through `_KEY` and watch `currkey`, `bufftop`, and `buffer` window
change over time.

## Run

From `step-9000-full`:

```bash
make gdb-scenario-000-key
```

Or directly:

```bash
gdb -q -x gdb-scenarios/000-key/session.gdb ./jonesforth
```

In GDB:

```gdb
key-run
key-step
key-steps 10
key-go
```

## Notes

- `key-run` uses `gdb-scenarios/000-key/input.f`.
- `ui-buffer` is sourced automatically from `python-gdb-ui/gdb_program_ui.py`.
- This scenario is intentionally minimal so users can fork it into their own
  routine-specific sessions.

