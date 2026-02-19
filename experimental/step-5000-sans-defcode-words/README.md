
# JONESFORTH

This is a fork of Richard WM Jones's excellent literate x86 assembly
implementation of Forth, more on which here:
http://rwmj.wordpress.com/2010/08/07/jonesforth-git-repository/

This has been tested on Ubuntu 22.04.5 in WSL on Windows 11.

# Required packages

On Ubuntu 22.04.5, the following are needed:

```
sudo apt-get update && sudo apt-get install -y gcc-multilib g++-multilib
```

# Build

```
gcc -m32 -nostdlib -static -Wl,--build-id=none -o jonesforth jonesforth.S
```

# Run

```
cat jonesforth.f - | ./jonesforth
```

# Run example

```
cat jonesforth.f examples/add.f - | ./jonesforth
```

# Run example and exit

```
make run_exit PROG=examples/add.f
```

# Debug an example program

```
make debug_prog PROG=examples/add.f
```

# Trace an example program

```
make trace PROG=examples/add.f
```

This writes:

- `trace.md`
- `trace.norm.md`

# Makefile

```
make clean
make 
make run
make run_exit PROG=examples/add.f
make debug_prog PROG=examples/add.f
make trace PROG=examples/add.f
make test
```
