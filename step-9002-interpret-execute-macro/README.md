
# JONESFORTH

This is a fork of Richard WM Jones's excellent literate x86 assembly
implementation of Forth, more on which here:
http://rwmj.wordpress.com/2010/08/07/jonesforth-git-repository/

This has been tested on Ubuntu 22.04.5 in WSL on Windows 11.

# Required packages

On Ubuntu 22.04.5, the following are needed:

```
sudo apt-get update
sudo apt-get install -y gcc-multilib g++-multilib rlwrap
```

# Build

```
make jonesforth
```

# Run

Explicit command:

```
cat jonesforth.f - | ./jonesforth
```

Run with make:

```
make run
```

Run with rlwrap:

```
make run-rlwrap
```

# Run program

```
cat jonesforth.f examples/add.f - | ./jonesforth
```

```
make run-rlwrap PROG=examples/words.f
```

# Run example and exit

```
make run-exit PROG=examples/add.f
```

# GDB

See:

- [docs/gdb-example.md]()
- [docs/gdb-example-two-terminals.md]()
- [docs/gdb-notes.md]()

