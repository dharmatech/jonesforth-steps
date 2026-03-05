
# See stack:

```
(gdb) x/4xw $esp
0xffbb7b6c:     0x0000000a      0x00000001      0xffbb9cac      0x00000000
```

```
(gdb) x/4dw $esp
0xffbb7b6c:     10      1       -4481876        0
```

# gdb commands

#### `forth-dict [N]`

Walk and display the FORTH dictionary linked list from var_LATEST.
N limits output entries (default 256).

#### `forth-next-known [N]`

Step machine instructions until ESI moves to a known FORTH frame address,
then render forth-view. Repeats N times (default 1).

```
forth-until-silent
forth-next-cell     
forth-until         
forth-view
```
