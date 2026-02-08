
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

# Makefile

```
make clean
make 
make run
make test
```