SHELL := /bin/bash

all: jonesforth

jonesforth: jonesforth.S
	gcc -m32 -nostdlib -static -o $@ $<

run: jonesforth
	./jonesforth

clean:
	rm -f jonesforth *~ core

.PHONY: all run clean
