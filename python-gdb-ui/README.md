# python-gdb-ui

Initial prototype for rendering an aligned disassembly table from `gdb`.

## Run

```bash
python3 python-gdb-ui/text_view.py
```

Default target:
- binary: `step-0000/jonesforth`
- start: `code_LIT`
- end: `_start+18`

You can override:

```bash
python3 python-gdb-ui/text_view.py step-0000/jonesforth --start code_LIT --end _start+18
```

## Output columns

1. label
2. address
3. byte values
4. instruction
