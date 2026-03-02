# Scenario 001: `_WORD`

Goal: step through `_WORD` and observe how input is consumed from `buffer`
while characters are copied into `word_buffer`.

## Run

From `step-9000-full`:

```bash
make gdb-scenario-001-word
```

Or directly:

```bash
gdb -q -x gdb-scenarios/001-word/session.gdb ./jonesforth
```

In GDB:

```gdb
word-run
word-show
word-step
word-steps 10
word-go
```

## Notes

- `word-run` uses `gdb-scenarios/001-word/input.f`.
- `word-show` includes:
  - instruction + key registers (`eax/ecx/edx/esi/edi`)
  - `currkey` / `bufftop`
  - `ui-buffer` input window
  - `word_buffer` bytes and best-effort string view
- This scenario is useful for understanding:
  - skipping blanks
  - skipping `\\` comments to newline
  - accumulating token bytes into `word_buffer`
