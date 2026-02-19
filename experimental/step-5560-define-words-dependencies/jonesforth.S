
.macro NEXT
    lodsl
    jmp *(%eax)
.endm

/* Macros to deal with the return stack. */
.macro PUSHRSP reg
    lea -4(%ebp),%ebp       // push reg on to return stack
    movl \reg,(%ebp)
.endm

.macro POPRSP reg
    mov (%ebp),\reg         // pop top of return stack to reg
    lea 4(%ebp),%ebp
.endm

/* DOCOL - the interpreter! */
.text
.align 4
DOCOL:
        PUSHRSP %esi            // push %esi on to the return stack
        addl $4,%eax            // %eax points to codeword, so make
        movl %eax,%esi          // %esi point to first data word
NEXT

.set F_IMMED,0x80
.set F_HIDDEN,0x20
.set F_LENMASK,0x1f     // length mask

// Store the chain of links.
.set link,0

.macro defword name, namelen, flags=0, label
    .section .rodata
    .align 4
    
    .globl name_\label
    name_\label :
    	.int link               // link
    	.set link,name_\label
    	.byte \flags+\namelen   // flags + length byte
    	.ascii "\name"          // the name
    	.align 4                // padding to next 4 byte boundary

    .globl \label
    \label :
    	.int DOCOL              // codeword - the interpreter
                                // list of word pointers follow
.endm


.macro defcode name, namelen, flags=0, label
    .section .rodata
    .align 4
    
    .globl name_\label
    name_\label :
        .int link               // link
        .set link,name_\label
        .byte \flags+\namelen   // flags + length byte
        .ascii "\name"          // the name
        .align 4                // padding to next 4 byte boundary
    
    .globl \label
    \label :
        .int code_\label        // codeword
    
    .text
        //.align 4
        .globl code_\label
        code_\label :                   // assembler code follows
.endm

defcode "LIT",3,,LIT
    // %esi points to the next command, but in this case it points to the next
    // literal 32 bit integer.  Get that literal into %eax and increment %esi.
    // On x86, it's a convenient single byte instruction!  (cf. NEXT macro)
    lodsl
    push %eax               // push the literal number on to stack
NEXT
#define HAVE_WORD_LIT 1

.macro defvar name, namelen, flags=0, label, initial=0
    defcode \name,\namelen,\flags,\label
    push $var_\name
    NEXT
    .data
    .align 4
    var_\name :
    .int \initial
.endm

defvar "STATE",5,,STATE
defvar "HERE",4,,HERE
defvar "LATEST",6,,LATEST,name_SYSCALL0 // SYSCALL0 must be last in built-in dictionary
defvar "S0",2,,SZ
defvar "BASE",4,,BASE,10
#define HAVE_VAR_LATEST 1


//#include <asm-i386/unistd.h>  // you might need this instead
#include <asm/unistd.h>

.macro defconst name, namelen, flags=0, label, value
    defcode \name,\namelen,\flags,\label
    push $\value
    NEXT
.endm

defconst "R0",2,,RZ,return_stack_top
defconst "DOCOL",5,,__DOCOL,DOCOL
defconst "F_IMMED",7,,__F_IMMED,F_IMMED
defconst "F_HIDDEN",8,,__F_HIDDEN,F_HIDDEN
defconst "F_LENMASK",9,,__F_LENMASK,F_LENMASK

defconst "SYS_EXIT",8,,SYS_EXIT,__NR_exit
defconst "SYS_READ",8,,SYS_READ,__NR_read
defconst "SYS_WRITE",9,,SYS_WRITE,__NR_write
defconst "SYS_BRK",7,,SYS_BRK,__NR_brk

defcode "RSP!",4,,RSPSTORE
    pop %ebp
NEXT

_KEY:
    mov (currkey),%ebx
    cmp (bufftop),%ebx
    jge 1f                  // exhausted the input buffer?
    xor %eax,%eax
    mov (%ebx),%al          // get next key from input buffer
    inc %ebx
    mov %ebx,(currkey)      // increment currkey
    ret

    1:      // Out of input; use read(2) to fetch more input from stdin.
        xor %ebx,%ebx           // 1st param: stdin
        mov $buffer,%ecx        // 2nd param: buffer
        mov %ecx,currkey
        mov $BUFFER_SIZE,%edx   // 3rd param: max length
        mov $__NR_read,%eax     // syscall: read
        int $0x80
        test %eax,%eax          // If %eax <= 0, then exit.
        jbe 2f
        addl %eax,%ecx          // buffer+%eax = bufftop
        mov %ecx,bufftop
        jmp _KEY

    2:      // Error or end of input: exit the program.
        xor %ebx,%ebx
        mov $__NR_exit,%eax     // syscall: exit
        int $0x80
// end _KEY

.data
.align 4

currkey:
        .int buffer             // Current place in input buffer (next character to read).
bufftop:
        .int buffer             // Last valid data in input buffer + 1.

_WORD:
    /* Search for first non-blank character.  Also skip \ comments. */
    1:
        call _KEY               // get next key, returned in %eax
        cmpb $'\\',%al          // start of a comment?
        je 3f                   // if so, skip the comment
        cmpb $' ',%al
        jbe 1b                  // if so, keep looking

        /* Search for the end of the word, storing chars as we go. */
        mov $word_buffer,%edi   // pointer to return buffer
    2:
        stosb           // add character to return buffer
        call _KEY       // get next key, returned in %al
        cmpb $' ',%al   // is blank?
        ja 2b           // if not, keep looping

        /* Return the word (well, the static buffer) and length. */
        sub $word_buffer,%edi
        mov %edi,%ecx           // return length of the word
        mov $word_buffer,%edi   // return address of the word
        ret

        /* Code to skip \ comments to end of the current line. */
    3:
        call _KEY
        cmpb $'\n',%al          // end of line yet?
        jne 3b
        jmp 1b
// end _WORD

.data                   // NB: easier to fit in the .data section
// A static buffer where WORD returns.  Subsequent calls
// overwrite this buffer.  Maximum word length is 32 chars.
word_buffer:
        .space 32

_NUMBER:
    xor %eax,%eax
    xor %ebx,%ebx

    test %ecx,%ecx          // trying to parse a zero-length string is an error, but will return 0.
    jz 5f

    movl var_BASE,%edx      // get BASE (in %dl)

    // Check if first character is '-'.
    movb (%edi),%bl         // %bl = first character in string
    inc %edi
    push %eax               // push 0 on stack
    cmpb $'-',%bl           // negative number?
    jnz 2f
    pop %eax
    push %ebx               // push <> 0 on stack, indicating negative
    dec %ecx
    jnz 1f
    pop %ebx                // error: string is only '-'.
    movl $1,%ecx
    ret

    // Loop reading digits.
    1:      
        imull %edx,%eax         // %eax *= BASE
        movb (%edi),%bl         // %bl = next character in string
        inc %edi

            // Convert 0-9, A-Z to a number 0-35.
    2:      
        subb $'0',%bl           // < '0'?
        jb 4f
        cmp $10,%bl             // <= '9'?
        jb 3f
        subb $17,%bl            // < 'A'? (17 is 'A'-'0')
        jb 4f
        addb $10,%bl

    3:      
        cmp %dl,%bl             // >= BASE?
        jge 4f

        // OK, so add it to %eax and loop.
        add %ebx,%eax
        dec %ecx
        jnz 1b

            // Negate the result if first character was '-' (saved on the stack).
    4:      
        pop %ebx
        test %ebx,%ebx
        jz 5f
        neg %eax

    5:      
        ret
// end _NUMBER

_FIND:
    push %esi               // Save %esi so we can use it in string comparison.

    // Now we start searching backwards through the dictionary for this word.
    mov var_LATEST,%edx     // LATEST points to name header of the latest word in the dictionary
    1:      test %edx,%edx          // NULL pointer?  (end of the linked list)
            je 4f

            // Compare the length expected and the length of the word.
            // Note that if the F_HIDDEN flag is set on the word, then by a bit of trickery
            // this won't pick the word (the length will appear to be wrong).
            xor %eax,%eax
            movb 4(%edx),%al        // %al = flags+length field
            andb $(F_HIDDEN|F_LENMASK),%al // %al = name length
            cmpb %cl,%al            // Length is the same?
            jne 2f

            // Compare the strings in detail.
            push %ecx               // Save the length
            push %edi               // Save the address (repe cmpsb will move this pointer)
            lea 5(%edx),%esi        // Dictionary string we are checking against.
            repe cmpsb              // Compare the strings.
            pop %edi
            pop %ecx
            jne 2f                  // Not the same.

            // The strings are the same - return the header pointer in %eax
            pop %esi
            mov %edx,%eax
            ret

    2:      mov (%edx),%edx         // Move back through the link field to the previous word
            jmp 1b                  // .. and loop.

    4:      // Not found.
            pop %esi
            xor %eax,%eax           // Return zero to indicate not found.
ret

_TCFA:
    xor %eax,%eax
    add $4,%edi             // Skip link pointer.
    movb (%edi),%al         // Load flags+len into %al.
    inc %edi                // Skip flags+len byte.
    andb $F_LENMASK,%al     // Just the length, not the flags.
    add %eax,%edi           // Skip the name.
    addl $3,%edi            // The codeword is 4-byte aligned.
    andl $~3,%edi
ret

_COMMA:
    movl var_HERE,%edi      // HERE
    stosl                   // Store it.
    movl %edi,var_HERE      // Update HERE (incremented)
ret

defcode "IMMEDIATE",9,F_IMMED,IMMEDIATE
    movl var_LATEST,%edi    // LATEST word.
    addl $4,%edi            // Point to name/flags byte.
    xorb $F_IMMED,(%edi)    // Toggle the IMMED bit.
NEXT

defcode "BRANCH",6,,BRANCH
    add (%esi),%esi         // add the offset to the instruction pointer
NEXT


// QUIT must not return (ie. must not call EXIT).
defword "QUIT",4,,QUIT
    .int RZ,RSPSTORE        // R0 RSP!, clear the return stack
    .int INTERPRET          // interpret the next word
.int BRANCH,-8          // and loop (indefinitely)

defcode "INTERPRET",9,,INTERPRET
    call _WORD              // Returns %ecx = length, %edi = pointer to word.

    // Is it in the dictionary?
    xor %eax,%eax
    movl %eax,interpret_is_lit // Not a literal number (not yet anyway ...)
    call _FIND                 // Returns %eax = pointer to header or 0 if not found.
    test %eax,%eax             // Found?
    jz 1f

    // In the dictionary.  Is it an IMMEDIATE codeword?
    mov %eax,%edi           // %edi = dictionary entry
    movb 4(%edi),%al        // Get name+flags.
    push %ax                // Just save it for now.
    call _TCFA              // Convert dictionary entry (in %edi) to codeword pointer.
    pop %ax
    andb $F_IMMED,%al       // Is IMMED flag set?
    mov %edi,%eax
    jnz 4f                  // If IMMED, jump straight to executing.

    jmp 2f

    1:      // Not in the dictionary (not a word) so assume it's a literal number.
    incl interpret_is_lit
    call _NUMBER            // Returns the parsed number in %eax, %ecx > 0 if error
    test %ecx,%ecx
    jnz 6f
    mov %eax,%ebx
    mov $LIT,%eax           // The word is LIT

    2:      // Are we compiling or executing?
    movl var_STATE,%edx
    test %edx,%edx
    jz 4f                   // Jump if executing.

    // Compiling - just append the word to the current dictionary definition.
    call _COMMA
    mov interpret_is_lit,%ecx // Was it a literal?
    test %ecx,%ecx
    jz 3f
    mov %ebx,%eax           // Yes, so LIT is followed by a number.
    call _COMMA
    3:
    NEXT

    4:      // Executing - run it!
    mov interpret_is_lit,%ecx // Literal?
    test %ecx,%ecx          // Literal?
    jnz 5f

    // Not a literal, execute it now.  This never returns, but the codeword will
    // eventually call NEXT which will reenter the loop in QUIT.
    jmp *(%eax)

    5:      // Executing a literal, which means push it on the stack.
    push %ebx    // push literal on stack
    NEXT

    6:      // Parse error (not a known word or a number in the current BASE).
    // Print an error message followed by up to 40 characters of context.
    mov $2,%ebx             // 1st param: stderr
    mov $errmsg,%ecx        // 2nd param: error message
    mov $errmsgend-errmsg,%edx // 3rd param: length of string
    mov $__NR_write,%eax    // write syscall
    int $0x80

    mov (currkey),%ecx      // the error occurred just before currkey position
    mov %ecx,%edx
    sub $buffer,%edx        // %edx = currkey - buffer (length in buffer before currkey)
    cmp $40,%edx            // if > 40, then print only 40 characters
    jle 7f
    mov $40,%edx
    7:      sub %edx,%ecx           // %ecx = start of area to print, %edx = length
    mov $__NR_write,%eax    // write syscall
    int $0x80

    mov $errmsgnl,%ecx      // newline
    mov $1,%edx
    mov $__NR_write,%eax    // write syscall
    int $0x80

NEXT

.section .rodata
errmsg: .ascii "PARSE ERROR: "
errmsgend:
errmsgnl: .ascii "\n"

.data                   // NB: easier to fit in the .data section
.align 4
interpret_is_lit:
    .int 0                  // Flag used to record if reading a literal


.text
.set INITIAL_DATA_SEGMENT_SIZE,65536

set_up_data_segment:
    xor %ebx,%ebx           // Call brk(0)
    movl $__NR_brk,%eax
    int $0x80
    movl %eax,var_HERE      // Initialise HERE to point at beginning of data segment.
    addl $INITIAL_DATA_SEGMENT_SIZE,%eax    // Reserve nn bytes of memory for initial data segment.
    movl %eax,%ebx          // Call brk(HERE+INITIAL_DATA_SEGMENT_SIZE)
    movl $__NR_brk,%eax
    int $0x80
ret

.set RETURN_STACK_SIZE,8192
.set BUFFER_SIZE,4096

.bss
/* FORTH return stack. */
.align 4096
return_stack:
.space RETURN_STACK_SIZE
return_stack_top:               // Initial top of return stack.

/* This is used as a temporary input buffer when reading from files or the terminal. */
.align 4096
buffer:
    .space BUFFER_SIZE

.section .rodata
cold_start:                     // High-level code without a codeword.
    .int QUIT

/* Assembler entry point. */
.text
.globl _start
_start:
    cld
    mov %esp,var_S0            // Save the initial data stack pointer in FORTH variable S0.
    mov $return_stack_top,%ebp // Initialise the return stack.
    call set_up_data_segment

    mov $cold_start,%esi    // Initialise interpreter.
NEXT                    // Run interpreter!

// ----------------------------------------------------------------------

#include "add.S"
#include "asm/stack.S"
// ----------------------------------------------------------------------
defcode ",",1,,COMMA
    pop %eax                // Code pointer to store.
    call _COMMA
NEXT
#define HAVE_WORD_COMMA 1
// ----------------------------------------------------------------------
#include "asm/COLON.S"
#include "asm/SEMICOLON.S"
// ----------------------------------------------------------------------

// ----------------------------------------------------------------------
defcode "SYSCALL0",8,,SYSCALL0
    pop %eax                // System call number (see <asm/unistd.h>)
    int $0x80
    push %eax               // Result (negative for -errno)
NEXT
