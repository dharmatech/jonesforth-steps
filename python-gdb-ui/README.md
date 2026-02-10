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

## GDB Python Extension (Generic)

Load custom GDB commands:

```gdb
(gdb) source python-gdb-ui/gdb_jonesforth_ui.py
```

Generic commands:

- `ui-text [start_expr] [end_expr]`
- `ui-words [start_expr] [end_expr] [--labels FILE] [--word-size N]`

Defaults:

- `ui-text` uses full `.text` section if no range is provided.
- `ui-words` uses full `.rodata` section if no range is provided.
- `ui-words` default word size is pointer size (`sizeof(void*)`).

Compatibility aliases:

- `jf-text` -> `ui-text`
- `jf-rodata` -> `ui-words`

Examples:

```gdb
(gdb) file step-0000/jonesforth
(gdb) source python-gdb-ui/gdb_jonesforth_ui.py
(gdb) ui-text
(gdb) ui-words --word-size 4
(gdb) ui-words '&LIT' '((unsigned int)&cold_start)+24' --word-size 4 --labels python-gdb-ui/labels.example.txt
```
