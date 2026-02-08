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
