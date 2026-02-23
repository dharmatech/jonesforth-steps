# Scenario 003: `INTERPRET`

Goal: step through `INTERPRET` and observe how tokens are handled as dictionary
words vs literal numbers, and how parse-error state is reached.

## Run

From `step-9000-full`:

```bash
make gdb-scenario-003-interpret
```

Or directly:

```bash
gdb -q -x gdb-scenarios/003-interpret/session.gdb ./jonesforth
```

In GDB:

```gdb
interpret-run
interpret-show
interpret-step
interpret-steps 10
interpret-continue
interpret-next
```

## Notes

- `interpret-run` uses `gdb-scenarios/003-interpret/input.f`.
- `interpret-show` includes:
  - registers: `eax ebx ecx edx esi edi`
  - `var_STATE` (compile/execute mode)
  - `interpret_is_lit`
  - input state (`currkey`, `bufftop`, `ui-buffer`)
  - `word_buffer` bytes and string view
- `interpret-continue` continues to the next `code_INTERPRET` breakpoint and then
  shows state.
- `interpret-next` runs gdb `next` (source-level step-over) and then shows state.
