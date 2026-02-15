        defcode "DSP@",4,,DSPFETCH
        mov %esp,%eax
        push %eax
        NEXT

        defcode "DSP!",4,,DSPSTORE
        pop %esp
        NEXT

/*      INPUT AND OUTPUT ----------------------------------------------------------------------

        These are our first really meaty/complicated FORTH primitives.  I have chosen to write them in
        assembler, but surprisingly in "real" FORTH implementations these are often written in terms
        of more fundamental FORTH primitives.  I chose to avoid that because I think that just obscures
        the implementation.  After all, you may not understand assembler but you can just think of it
        as an opaque block of code that does what it says.

        Let's discuss input first.

        The FORTH word KEY reads the next byte from stdin (and pushes it on the parameter stack).
        So if KEY is called and someone hits the space key, then the number 32 (ASCII code of space)
        is pushed on the stack.

        In FORTH there is no distinction between reading code and reading input.  We might be reading
        and compiling code, we might be reading words to execute, we might be asking for the user
        to type their name -- ultimately it all comes in through KEY.

        The implementation of KEY uses an input buffer of a certain size (defined at the end of this
        file).  It calls the Linux read(2) system call to fill this buffer and tracks its position
        in the buffer using a couple of variables, and if it runs out of input buffer then it refills
        it automatically.  The other thing that KEY does is if it detects that stdin has closed, it
        exits the program, which is why when you hit ^D the FORTH system cleanly exits.

      buffer                           bufftop
        |                                |
        V                                V
        +-------------------------------+--------------------------------------+
        | INPUT READ FROM STDIN ....... | unused part of the buffer            |
        +-------------------------------+--------------------------------------+
                      ^
                      |
                   currkey (next character to read)

        <---------------------- BUFFER_SIZE (4096 bytes) ----------------------> 
*/

        defcode "KEY",3,,KEY
        call _KEY
        push %eax		// push return value on stack
        NEXT
_KEY:
        mov (currkey),%ebx
        cmp (bufftop),%ebx
        jge 1f			// exhausted the input buffer?
        xor %eax,%eax
        mov (%ebx),%al		// get next key from input buffer
        inc %ebx
        mov %ebx,(currkey)	// increment currkey
        ret

1:	// Out of input; use read(2) to fetch more input from stdin.
        xor %ebx,%ebx		// 1st param: stdin
        mov $buffer,%ecx	// 2nd param: buffer
        mov %ecx,currkey
        mov $BUFFER_SIZE,%edx	// 3rd param: max length
        mov $__NR_read,%eax	// syscall: read
        int $0x80
        test %eax,%eax		// If %eax <= 0, then exit.
        jbe 2f
        addl %eax,%ecx		// buffer+%eax = bufftop
        mov %ecx,bufftop
        jmp _KEY

2:	// Error or end of input: exit the program.
        xor %ebx,%ebx
        mov $__NR_exit,%eax	// syscall: exit
        int $0x80


        .data
        .align 4
currkey:
        .int buffer		// Current place in input buffer (next character to read).
bufftop:
        .int buffer		// Last valid data in input buffer + 1.
