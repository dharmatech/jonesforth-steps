# step-0000

`step-0000` is a debugger-first bootstrap seed for JonesForth.

This step intentionally does **not** include:
- dictionary headers
- parser/interpreter
- compile mode
- input/output words

It only contains a minimal indirect-threaded VM core:
- `NEXT` (`lodsl; jmp *(%eax)`)
- `_start` setting `%esi` to `cold_start`
- primitives: `LIT`, `DUP`, `DROP`, `ADD`, `BYE`

## Build

```bash
make clean
make
```

## Run

```bash
make run
```

The program exits immediately with status `0`.

## Debug with gdb

```bash
gdb ./jonesforth
```

Useful breakpoints:

```gdb
break _start
break code_LIT
break code_ADD
break code_BYE
run
```

Useful inspections:

```gdb
info registers eax esi esp
x/8wx $esi
x/8wx $esp
si
```

Expected flow:
1. `LIT 2` pushes `2`
2. `LIT 3` pushes `3`
3. `ADD` leaves `5` on top of `%esp`
4. `BYE` exits

## Debug with preloaded script

```bash
make debug-script
```

This loads `gdb/debug.gdb`, which preconfigures:
- breakpoints: `_start`, `code_LIT`, `code_ADD`, `code_BYE`
- displays: `$pc`, `$eax`, `$esi`, `$esp`

Then type:

```gdb
run
```

If you want preconfigured + auto-run:

```bash
make debug-script-run
```

## Debug with vendored gdb-dashboard

```bash
make debug-dashboard
```

This runs GDB with the project-local dashboard script:
- `gdb/gdb-dashboard.gdb` (copied from `~/.gdbinit`)
- `gdb/debug-dashboard.gdb` (dashboard-specific toggles, e.g. hide Threads)
- `gdb/debug.gdb` (our step breakpoints/displays)

`-nx` is used so user-specific `~/.gdbinit` is ignored and everyone gets the same dashboard behavior from the repo files.

For dashboard + auto-run:

```bash
make debug-dashboard-run
```

## One-shot memory map

```bash
make debug-map
```

This loads `gdb/memory-map.gdb`, which prints:
- symbol anchors (`LIT`, `DUP`, `ADD`, `cold_start`, etc.)
- `.text` using `disassemble /r` (instructions + opcode bytes)
- `.rodata` as 32-bit words

## Generate normalized trace

```bash
make trace
```

This runs `gdb/run-alt.gdb` to produce `trace.txt`, then creates
`trace.norm.txt` with normalized 32-bit hex addresses (7-digit forms are padded
to 8 digits).

To normalize an existing trace without rerunning GDB:

```bash
make trace-norm
```
