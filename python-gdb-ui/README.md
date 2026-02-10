# python-gdb-ui

Prototype for rendering aligned debugger tables from `gdb`.

## Views

- `text`: `label | address | byte values | instruction`
- `rodata`: `label | address | value | optional pointed label`

## Run

```bash
python3 python-gdb-ui/text_view.py --view text
python3 python-gdb-ui/text_view.py --view rodata
```

Default target binary is `step-0000/jonesforth`.

## Ranges

Text defaults:
- `--start code_LIT`
- `--end _start+18`

Rodata defaults:
- `--start &LIT`
- `--end ((unsigned int)&cold_start)+24`

Override example:

```bash
python3 python-gdb-ui/text_view.py step-0000/jonesforth --view rodata --start '&LIT' --end '((unsigned int)&cold_start)+24'
```

## Optional Label File

For stripped binaries or ambiguous symbols, provide `--labels`.

Accepted line formats:

```text
# comments allowed
0x0804a000 LIT
0x08049000 code_LIT
0x0804a00c=ADD
```

Overrides apply to:
- row labels (address column)
- pointer labels (value column)
