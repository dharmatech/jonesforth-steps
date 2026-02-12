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
(gdb) source python-gdb-ui/gdb_program_ui.py
```

Generic commands:

- `ui-text [start_expr] [end_expr]`
- `ui-rodata [start_expr] [end_expr] [--labels FILE] [--word-size N]`
- `ui-data [start_expr] [end_expr] [--labels FILE] [--word-size N]`
- `ui-sections [--labels FILE] [--word-size N] [--md]`
- `ui-reg <reg> [reg ...]`

Defaults:

- `ui-text` uses full `.text` section if no range is provided.
- `ui-rodata` uses full `.rodata` section if no range is provided.
- `ui-data` uses full `.data` section if no range is provided.
- `ui-rodata` default word size is pointer size (`sizeof(void*)`).
- `ui-sections` prints `.text`, `.rodata`, and `.data` together with shared column alignment.
- In `ui-sections`, missing `.rodata` or `.data` is shown as `(section not found)`.
- `ui-sections --md` emits markdown headings + fenced code blocks for easy folding in markdown files.
- `ui-reg` prints register values, appends symbol labels, and when register values point to readable memory shows `-> <pointee> <label>`.

Compatibility aliases:

- `ui-words` -> `ui-rodata`

Examples:

```gdb
(gdb) file step-0000/jonesforth
(gdb) source python-gdb-ui/gdb_program_ui.py
(gdb) ui-text
(gdb) ui-rodata --word-size 4
(gdb) ui-data --word-size 4
(gdb) ui-sections --word-size 4
(gdb) ui-sections --word-size 4 --md
(gdb) starti
(gdb) ui-reg eip esi eax
(gdb) ui-rodata '&LIT' '((unsigned int)&cold_start)+24' --word-size 4 --labels python-gdb-ui/labels.example.txt
```
