.set JONES_VERSION,47

/* NEXT macro. */
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

// -----------------------------------------------------------------------
#region Conditional macros

.macro IF_NOT_ZERO reg, label
    test \reg, \reg
    jnz \label
.endm

// .macro IF_NOT_ZERO_BYTE reg, label
//     test \reg, \reg
//     jnz \label
// .endm

.macro IF_ZERO reg, label
    test \reg, \reg
    jz \label
.endm

.macro IF reg, true_label, false_label
    test \reg, \reg
    jnz \true_label
    jmp \false_label
.endm

.macro IF_FLAG_ELSE mask, reg8, true_label, false_label
    testb \mask, \reg8
    jnz \true_label
    jmp \false_label
.endm

.macro IF_FLAG mask, reg8, label
    testb \mask, \reg8
    jnz \label
.endm

.macro IF_MEM_ZERO mem, label
    cmpl $0, \mem
    je \label
.endm

.macro IF_MEM_NOT_ZERO mem, label
    cmpl $0, \mem
    jne \label
.endm

.macro IF_MEM mem, label
    cmpl $0, \mem
    jz \label
.endm

.macro IF_ABOVE_BYTE op1, op2, label
    cmpb \op2, \op1
    ja \label
.endm

.macro IF_NOT_EQ_BYTE op1, op2, label
    cmpb \op2, \op1
    jne \label
.endm
#endregion
// -----------------------------------------------------------------------
#region system calls
//#include <asm-i386/unistd.h>  // you might need this instead
#include <asm/unistd.h> // sudo apt-get install -y gcc-multilib g++-multilib

.macro syscall_1 nr, a1
    mov \a1, %ebx
    mov \nr, %eax
    int $0x80
.endm

.macro syscall_3 nr, a1, a2, a3
    mov \a1, %ebx
    mov \a2, %ecx
    mov \a3, %edx
    mov \nr, %eax
    int $0x80
.endm

// .macro syscall_read fd, buf, len
//     syscall_3 $__NR_read, \fd, \buf, \len
// .endm

.macro syscall_read fd, buf, len, out=
    syscall_3 $__NR_read, \fd, \buf, \len
    .ifnb \out
        movl %eax, \out
    .endif
.endm


.macro syscall_write fd, buf, len
    syscall_3 $__NR_write, \fd, \buf, \len
.endm

.macro syscall_exit status
    syscall_1 $__NR_exit, \status
.endm
#endregion
// -----------------------------------------------------------------------

/* DOCOL - the interpreter! */
.text
.align 4
DOCOL:
    PUSHRSP %esi            // push %esi on to the return stack
    addl $4,%eax            // %eax points to codeword, so make
    movl %eax,%esi          // %esi point to first data word
NEXT

/* Flags - these are discussed later. */
.set F_IMMED,  0x80     //                0b10000000
.set F_HIDDEN, 0x20     //                0b00100000
.set F_LENMASK,0x1f     // length mask    0b00011111

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
// -----------------------------------------------------------------------
#region variables
.macro defvar name, namelen, flags=0, label, initial=0
    defcode \name,\namelen,\flags,\label
        push $var_\name
    NEXT

    .data
    .align 4
    var_\name :
        .int \initial
.endm

defvar "STATE",5,,STATE // STATE == 0 : executing    STATE != 0 : compiling
defvar "HERE",4,,HERE
defvar "LATEST",6,,LATEST,name_SYSCALL0 // SYSCALL0 must be last in built-in dictionary
defvar "S0",2,,SZ

#endregion
// -----------------------------------------------------------------------
#region constants

.macro defconst name, namelen, flags=0, label, value
    defcode \name,\namelen,\flags,\label
    push $\value
    NEXT
.endm

defconst "VERSION",7,,VERSION,JONES_VERSION
defconst "R0",2,,RZ,return_stack_top
defconst "DOCOL",5,,__DOCOL,DOCOL
defconst "F_IMMED",7,,__F_IMMED,F_IMMED
defconst "F_HIDDEN",8,,__F_HIDDEN,F_HIDDEN
defconst "F_LENMASK",9,,__F_LENMASK,F_LENMASK

defconst "SYS_EXIT",8,,SYS_EXIT,__NR_exit
defconst "SYS_OPEN",8,,SYS_OPEN,__NR_open
defconst "SYS_CLOSE",9,,SYS_CLOSE,__NR_close
defconst "SYS_READ",8,,SYS_READ,__NR_read
defconst "SYS_WRITE",9,,SYS_WRITE,__NR_write
defconst "SYS_CREAT",9,,SYS_CREAT,__NR_creat
defconst "SYS_BRK",7,,SYS_BRK,__NR_brk

defconst "O_RDONLY"  , 8,,__O_RDONLY,0
defconst "O_WRONLY"  , 8,,__O_WRONLY,1
defconst "O_RDWR"    , 6,,__O_RDWR,2
defconst "O_CREAT"   , 7,,__O_CREAT,0100
defconst "O_EXCL"    , 6,,__O_EXCL,0200
defconst "O_TRUNC"   , 7,,__O_TRUNC,01000
defconst "O_APPEND"  , 8,,__O_APPEND,02000
defconst "O_NONBLOCK",10,,__O_NONBLOCK,04000

#endregion
// -----------------------------------------------------------------------
#region RETURN STACK

defcode ">R",2,,TOR
    pop %eax                // pop parameter stack into %eax
    PUSHRSP %eax            // push it on to the return stack
NEXT

defcode "R>",2,,FROMR
    POPRSP %eax             // pop return stack on to %eax
    push %eax               // and push on to parameter stack
NEXT

defcode "RSP@",4,,RSPFETCH
    push %ebp
NEXT

defcode "RSP!",4,,RSPSTORE
    pop %ebp
NEXT

defcode "RDROP",5,,RDROP
    addl $4,%ebp            // pop return stack and throw away
NEXT

#endregion
// ----------------------------------------------------------------------
// PARAMETER (DATA) STACK
// ----------------------------------------------------------------------

defcode "DSP@",4,,DSPFETCH
    mov %esp,%eax
    push %eax
NEXT

defcode "DSP!",4,,DSPSTORE
    pop %esp
NEXT


// .macro IF_MEM_GE mem1 mem2 label
//     push %eax
//         mov \mem1,%eax
//         cmp \mem2,%eax
//     pop %eax
//     jge \label
// .endm

// tmp must be a 32-bit register
// .macro IF_MEM_GE mem1, mem2, label, tmp=%eax
//     push \tmp
//         mov \mem1,\tmp
//         cmp \mem2,\tmp
//     pop \tmp
//     jge \label
// .endm

.macro IF_AE lhs, rhs, label
    push %eax
        mov \lhs, %eax
        cmp \rhs, %eax
    pop %eax
    jae \label
.endm

// signed
.macro IF_LE lhs, rhs, label
    push %eax
        mov \lhs, %eax
        cmp \rhs, %eax
    pop %eax
    jle \label
.endm

// unsigned
.macro IF_BE lhs, rhs, label
    push %eax
        mov \lhs, %eax
        cmp \rhs, %eax
    pop %eax
    jbe \label
.endm

.macro get_inc_currkey
    mov $0,%eax
    mov currkey,%ebx
    mov (%ebx),%al          // get next key from input buffer
    incl currkey
.endm

.macro add2 result, op1, op2
    movl \op1, \result
    addl \op2, \result
.endm

.macro add2_any result, op1, op2
    push %eax
        movl \op1, %eax
        addl \op2, %eax
        movl %eax, \result
    pop %eax
.endm

.macro sub2_any result, op1, op2
    push %eax
        movl \op1, %eax
        subl \op2, %eax
        movl %eax, \result
    pop %eax
.endm


// ----------------------------------------------------------------------
#region KEY
defcode "KEY",3,,KEY
    call _KEY
    push %eax               // push return value on stack
NEXT

// return values:
//      %al : character at currkey
_KEY:
    IF_AE (currkey), (bufftop), 1f // if currkey >= bufftop, then exhausted the input buffer
        get_inc_currkey
        ret
    1:  // Out of input; use read(2) to fetch more input from stdin.        
        movl $buffer,currkey        
        
        syscall_read $0, $buffer, $BUFFER_SIZE, out=n_bytes_read

        IF_LE n_bytes_read, $0, 2f
            // bufftop = buffer + n_bytes_read
            add2_any bufftop, $buffer, n_bytes_read

            jmp _KEY
        2:  // Error or end of input: exit the program.
            syscall_exit $0
// end _KEY

.data
.align 4

n_bytes_read:
    .int 0                  // number of bytes read by last read syscall (set by KEY)

currkey: 
    .int buffer             // Current place in input buffer (next character to read).
bufftop: 
    .int buffer             // Last valid data in input buffer + 1.
#endregion
// ------------------------------------------------------------------------
#region EMIT
defcode "EMIT",4,,EMIT
    pop %eax
    call _EMIT
NEXT

_EMIT:
    mov %al,emit_scratch
    syscall_write $1, $emit_scratch, $1
ret

.data                   // NB: easier to fit in the .data section
emit_scratch:
    .space 1                // scratch used by EMIT
#endregion
// ------------------------------------------------------------------------
#region WORD
defcode "WORD",4,,WORD
    call _WORD
    push %edi               // push base address
    push %ecx               // push length
NEXT

#region Helper macros for _WORD
.macro skip_to_newline
    .L\@:
        call _KEY
        cmpb $'\n',%al
        jne .L\@          // end of line yet?
.endm

.macro IS_NON_BLANK op, label
    IF_ABOVE_BYTE \op, $' ', \label
.endm

.macro skip_to_non_blank
    1:
        IS_NON_BLANK %al, 2f
            call _KEY
            jmp 1b
    2:
.endm

.macro IS_NOT_COMMENT op, label
    IF_NOT_EQ_BYTE \op, $'\\' , \label
.endm

.macro check_for_comment
    IS_NOT_COMMENT %al, 1f
        skip_to_newline
        jmp _WORD
    1:    
.endm

.macro get_word
    2:
        stosb                       // add character to return buffer
        call _KEY                   // get next key, returned in %al
        IF_ABOVE_BYTE %al, $' ', 2b // if not blank, keep looping
.endm
#endregion

_WORD:
    call _KEY               // get next key, returned in %eax
    skip_to_non_blank
    check_for_comment

    // Search for the end of the word, storing chars as we go.
    mov $word_buffer,%edi   // pointer to return buffer
    get_word

    // Return the word (well, the static buffer) and length.
    // %ecx = %edi - word_buffer    length of the word
    sub2_any %ecx, %edi, $word_buffer
    mov $word_buffer,%edi   // return address of the word
    ret
// end _WORD

.data                   // NB: easier to fit in the .data section
// A static buffer where WORD returns.  Subsequent calls
// overwrite this buffer.  Maximum word length is 32 chars.
word_buffer:
    .space 32
#endregion
// ------------------------------------------------------------------------
#region NUMBER

defvar "BASE",4,,BASE,10

defcode "NUMBER",6,,NUMBER
    pop %ecx                // length of string
    pop %edi                // start address of string
    call _NUMBER
    push %eax               // parsed number
    push %ecx               // number of unparsed characters (0 = no error)
NEXT

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
    cmpb $'-',%bl; jnz 2f   // negative number?
   
    pop %eax
    push %ebx               // push <> 0 on stack, indicating negative
    dec %ecx; jnz 1f
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
#endregion
// ------------------------------------------------------------------------
#region FIND ( len addr -- addr )

defcode "FIND",4,,FIND
    pop %ecx                // %ecx = length
    pop %edi                // %edi = address
    call _FIND
    push %eax               // %eax = address of dictionary entry (or NULL)
NEXT

//    <--- DICTIONARY ENTRY (HEADER) ----------------------->
//    +------------------------+--------+---------- - - - - +----------- - - - -
//    | LINK POINTER           | LENGTH/| NAME              | DEFINITION
//    |                        | FLAGS  |                   |
//    +--- (4 bytes) ----------+- byte -+- n bytes  - - - - +----------- - - - -

.equiv R_CURRENT_HEADER, %edx // Address of dictionary entry header

.equiv O_LINK,         0
.equiv O_LENGTH_FLAGS, 4
.equiv O_NAME,         5

#region Helper macros for _FIND

.macro check_not_found
    IF_NOT_ZERO R_CURRENT_HEADER, 10f
        // Not found.
        pop %esi
        xor %eax,%eax           // Return zero to indicate not found.
        ret        
    10:
.endm

.macro loop_continue_if_hidden label
    movb O_LENGTH_FLAGS(R_CURRENT_HEADER), %al
    andb $F_HIDDEN, %al
    IF_NOT_ZERO %al, \label
.endm

.macro get_length_field
    xor %eax,%eax
    movb O_LENGTH_FLAGS(R_CURRENT_HEADER), %al // %al = flags+length field
    andb $F_LENMASK,%al            // %al = length
.endm

.macro loop_continue_if_length_mismatch label
    get_length_field
    IF_NOT_EQ_BYTE %al, %cl, \label
.endm

.macro compare_strings
    // Compare the strings in detail.
    push %ecx                   // Save the length
        push %edi               // Save the address (repe cmpsb will move this pointer)
            lea O_NAME(R_CURRENT_HEADER),%esi    // Dictionary string we are checking against.
            repe cmpsb          // Compare the strings. Modifies %esi, %edi and %ecx.
                                // Advances %esi and %edi. Decrements %ecx until zero or mismatch.
        pop %edi
    pop %ecx
.endm

.macro loop_continue_if_string_mismatch label
    compare_strings
    jne \label
.endm

#endregion

// %ecx = length  of word name
// %edi = address of word name string

_FIND:
    push %esi               // Save %esi so we can use it in string comparison.
    
    mov var_LATEST, R_CURRENT_HEADER
    1:     
        check_not_found
        loop_continue_if_hidden 2f
        loop_continue_if_length_mismatch 2f
        loop_continue_if_string_mismatch 2f

            // The strings are the same - return the header pointer in %eax
            pop %esi
            mov %edx,%eax
            ret

        2:      
            // Move back through the link field to the previous word
            mov O_LINK(R_CURRENT_HEADER),R_CURRENT_HEADER         
            jmp 1b                  // .. and loop.

// end _FIND
#endregion
// ----------------------------------------------------------------------
#region >CFA ( addr -- cfa )
defcode ">CFA",4,,TCFA
    pop %edi
    call _TCFA
    push %edi
NEXT

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
#endregion
// ----------------------------------------------------------------------
defword ">DFA",4,,TDFA
    .int TCFA               // >CFA         (get code field address)
    .int INCR4              // 4+           (add 4 to it to get to next word)
    .int EXIT               // EXIT         (return from FORTH word)
// ----------------------------------------------------------------------
defcode "CREATE",6,,CREATE

    // Get the name length and address.
    pop %ecx                // %ecx = length
    pop %ebx                // %ebx = address of name

    // Link pointer.
    movl var_HERE,%edi      // %edi is the address of the header
    movl var_LATEST,%eax    // Get link pointer
    stosl                   // and store it in the header.

    // Length byte and the word itself.
    mov %cl,%al             // Get the length.
    stosb                   // Store the length/flags byte.
    push %esi
    mov %ebx,%esi           // %esi = word
    rep movsb               // Copy the word
    pop %esi
    addl $3,%edi            // Align to next 4 byte boundary.
    andl $~3,%edi

    // Update LATEST and HERE.
    movl var_HERE,%eax
    movl %eax,var_LATEST
    movl %edi,var_HERE
NEXT

defcode ",",1,,COMMA
    pop %eax                // Code pointer to store.
    call _COMMA
NEXT

_COMMA:
    movl var_HERE,%edi      // HERE
    stosl                   // Store it.
    movl %edi,var_HERE      // Update HERE (incremented)
ret

defcode "[",1,F_IMMED,LBRAC
    xor %eax,%eax
    movl %eax,var_STATE     // Set STATE to 0.
NEXT

defcode "]",1,,RBRAC
    movl $1,var_STATE       // Set STATE to 1.
NEXT

defword ":",1,,COLON
    .int WORD               // Get the name of the new word
    .int CREATE             // CREATE the dictionary entry / header
    .int LIT, DOCOL, COMMA  // Append DOCOL  (the codeword).
    .int LATEST, FETCH, HIDDEN // Make the word hidden (see below for definition).
    .int RBRAC              // Go into compile mode.
.int EXIT                   // Return from the function.

defword ";",1,F_IMMED,SEMICOLON
    .int LIT, EXIT, COMMA      // Append EXIT (so the word will return).
    .int LATEST, FETCH, HIDDEN // Toggle hidden flag -- unhide the word (see below for definition).
    .int LBRAC                 // Go back to IMMEDIATE mode.
.int EXIT                      // Return from the function.

defcode "IMMEDIATE",9,F_IMMED,IMMEDIATE
    movl var_LATEST,%edi    // LATEST word.
    addl $4,%edi            // Point to name/flags byte.
    xorb $F_IMMED,(%edi)    // Toggle the IMMED bit.
NEXT

defcode "HIDDEN",6,,HIDDEN
    pop %edi                // Dictionary entry.
    addl $4,%edi            // Point to name/flags byte.
    xorb $F_HIDDEN,(%edi)   // Toggle the HIDDEN bit.
NEXT

defword "HIDE",4,,HIDE
    .int WORD               // Get the word (after HIDE).
    .int FIND               // Look up in the dictionary.
    .int HIDDEN             // Set F_HIDDEN flag.
.int EXIT               // Return.


defcode "BRANCH",6,,BRANCH
    add (%esi),%esi         // add the offset to the instruction pointer
NEXT

defcode "0BRANCH",7,,ZBRANCH
    pop %eax
    test %eax,%eax          // top of stack is zero?
    jz code_BRANCH          // if so, jump back to the branch function above
    lodsl                   // otherwise we need to skip the offset
NEXT




// QUIT must not return (ie. must not call EXIT).
defword "QUIT",4,,QUIT
    .int RZ,RSPSTORE        // R0 RSP!, clear the return stack
    .int INTERPRET          // interpret the next word
    .int BRANCH,-8          // and loop (indefinitely)

// ----------------------------------------------------------------------
#region INTERPRET

#region Helper macros for INTERPRET

// execute expects:
//     eax=xt (or LIT)
//     ebx=literal if interpret_is_lit!=0
.macro execute // Executing - run it!
    IF_MEM_NOT_ZERO interpret_is_lit, .L_execute_literal_\@
        // Not a literal, execute it now.  This never returns, but the codeword will
        // eventually call NEXT which will reenter the loop in QUIT.
        jmp *(%eax)
    .L_execute_literal_\@: // Executing a literal, which means push it on the stack.
        push %ebx    // push literal on stack
        NEXT
.endm

// check_state is terminal:
//     always ends in NEXT or tail-jumps via execute
.macro check_state // 2:
    // Are we compiling or executing?        
    IF_MEM_ZERO var_STATE, 40f // STATE == 0 : executing    STATE != 0 : compiling

        // Compiling - just append the word to the current dictionary definition.
        call _COMMA

        IF_MEM_ZERO interpret_is_lit, 3f
            mov %ebx,%eax           // Yes, so LIT is followed by a number.
            call _COMMA
        3:
            NEXT
    40:
        execute
.endm
#endregion

defcode "INTERPRET",9,,INTERPRET
    call _WORD              // Returns %ecx = length, %edi = pointer to word.

    // Is it in the dictionary?
    movl $0, interpret_is_lit // Not a literal number (not yet anyway ...)
    call _FIND                 // Returns %eax = pointer to header or 0 if not found.
    IF_ZERO %eax, .L_not_found
        // In the dictionary.  Is it an IMMEDIATE codeword?
        mov %eax,%edi           // %edi = dictionary entry
        movb 4(%edi),%bl        // Get name+flags.
        call _TCFA              // Convert dictionary entry (in %edi) to codeword pointer.
        mov %edi,%eax

        IF_FLAG_ELSE $F_IMMED, %bl, 10f, 20f
        10:
            execute
        20:
            check_state        

    .L_not_found:
        // Not in the dictionary (not a word) so assume it's a literal number.
        incl interpret_is_lit
        call _NUMBER            // Returns the parsed number in %eax, %ecx > 0 if error                
        IF_NOT_ZERO %ecx, .L_parse_error        
            mov %eax,%ebx
            mov $LIT,%eax           // The word is LIT
            check_state            
        .L_parse_error:
            // Parse error (not a known word or a number in the current BASE).
            // Print an error message followed by up to 40 characters of context.
        
            syscall_write $2, $errmsg, $errmsgend-errmsg

            mov (currkey),%ecx      // the error occurred just before currkey position
            mov %ecx,%edx
            sub $buffer,%edx        // %edx = currkey - buffer (length in buffer before currkey)
            cmp $40,%edx; jle 7f    // if > 40, then print only 40 characters
                mov $40,%edx
            7:      
                sub %edx,%ecx           // %ecx = start of area to print, %edx = length
                syscall_write $2, %ecx,      %edx
                syscall_write $2, $errmsgnl, $1 // newline

NEXT

.section .rodata
errmsg: .ascii "PARSE ERROR: "
errmsgend:
errmsgnl: .ascii "\n"

.data                   // NB: easier to fit in the .data section
.align 4
interpret_is_lit:
    .int 0                  // Flag used to record if reading a literal
#endregion
// -----------------------------------------------------------------------

defcode "EXECUTE",7,,EXECUTE
    pop %eax                // Get xt into %eax
    jmp *(%eax)             // and jump to it.
    // After xt runs its NEXT will continue executing the current word.

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

// ----------------------------------------------------------------------
// Assembler entry point
.text
.globl _start
_start:
    cld
    mov %esp,var_S0         // Save the initial data stack pointer in FORTH variable S0.
    mov $return_stack_top,%ebp // Initialise the return stack.
    call set_up_data_segment

    mov $cold_start,%esi    // Initialise interpreter.
NEXT                        // Run interpreter!

.section .rodata
cold_start:                     // High-level code without a codeword.
    .int QUIT
// ----------------------------------------------------------------------
#region FORTH primitives defined in assembly
// Nothing above here depends on these.

// ----------------------------------------------------------------------
// STACK MANIPULATION 
// ----------------------------------------------------------------------

defcode "DROP",4,,DROP
    pop %eax                // drop top of stack
NEXT

defcode "SWAP",4,,SWAP
    pop %eax                // swap top two elements on stack
    pop %ebx
    push %eax
    push %ebx
NEXT

defcode "DUP",3,,DUP
    mov (%esp),%eax         // duplicate top of stack
    push %eax
NEXT

defcode "OVER",4,,OVER
    mov 4(%esp),%eax        // get the second element of stack
    push %eax               // and push it on top
NEXT

defcode "ROT",3,,ROT
    pop %eax
    pop %ebx
    pop %ecx
    push %ebx
    push %eax
    push %ecx
NEXT

defcode "-ROT",4,,NROT
    pop %eax
    pop %ebx
    pop %ecx
    push %eax
    push %ecx
    push %ebx
NEXT

defcode "2DROP",5,,TWODROP // drop top two elements of stack
    pop %eax
    pop %eax
NEXT

defcode "2DUP",4,,TWODUP // duplicate top two elements of stack
    mov (%esp),%eax
    mov 4(%esp),%ebx
    push %ebx
    push %eax
NEXT

defcode "2SWAP",5,,TWOSWAP // swap top two pairs of elements of stack
    pop %eax
    pop %ebx
    pop %ecx
    pop %edx
    push %ebx
    push %eax
    push %edx
    push %ecx
NEXT

defcode "?DUP",4,,QDUP  // duplicate top of stack if non-zero
    movl (%esp),%eax
    test %eax,%eax
    jz 1f
    push %eax
    1:
NEXT

// ----------------------------------------------------------------------
// ARITHMETIC
// ----------------------------------------------------------------------

defcode "1+",2,,INCR
    incl (%esp)             // increment top of stack
NEXT

defcode "1-",2,,DECR
    decl (%esp)             // decrement top of stack
NEXT

defcode "4+",2,,INCR4
    addl $4,(%esp)          // add 4 to top of stack
NEXT

defcode "4-",2,,DECR4
    subl $4,(%esp)          // subtract 4 from top of stack
NEXT

defcode "+",1,,ADD
    pop %eax                // get top of stack
    addl %eax,(%esp)        // and add it to next word on stack
NEXT

defcode "-",1,,SUB
    pop %eax                // get top of stack
    subl %eax,(%esp)        // and subtract it from next word on stack
NEXT

defcode "*",1,,MUL
    pop %eax
    pop %ebx
    imull %ebx,%eax
    push %eax               // ignore overflow
NEXT

defcode "/MOD",4,,DIVMOD
    xor %edx,%edx
    pop %ebx
    pop %eax
    idivl %ebx
    push %edx               // push remainder
    push %eax               // push quotient
NEXT

// ----------------------------------------------------------------------
// COMPARISON
// ----------------------------------------------------------------------

defcode "=",1,,EQU      // top two words are equal?
    pop %eax
    pop %ebx
    cmp %ebx,%eax
    sete %al
    movzbl %al,%eax
    pushl %eax
NEXT

defcode "<>",2,,NEQU    // top two words are not equal?
    pop %eax
    pop %ebx
    cmp %ebx,%eax
    setne %al
    movzbl %al,%eax
    pushl %eax
NEXT

defcode "<",1,,LT
    pop %eax
    pop %ebx
    cmp %eax,%ebx
    setl %al
    movzbl %al,%eax
    pushl %eax
NEXT

defcode ">",1,,GT
    pop %eax
    pop %ebx
    cmp %eax,%ebx
    setg %al
    movzbl %al,%eax
    pushl %eax
NEXT

defcode "<=",2,,LE
    pop %eax
    pop %ebx
    cmp %eax,%ebx
    setle %al
    movzbl %al,%eax
    pushl %eax
NEXT

defcode ">=",2,,GE
    pop %eax
    pop %ebx
    cmp %eax,%ebx
    setge %al
    movzbl %al,%eax
    pushl %eax
NEXT

defcode "0=",2,,ZEQU    // top of stack equals 0?
    pop %eax
    test %eax,%eax
    setz %al
    movzbl %al,%eax
    pushl %eax
NEXT

defcode "0<>",3,,ZNEQU  // top of stack not 0?
    pop %eax
    test %eax,%eax
    setnz %al
    movzbl %al,%eax
    pushl %eax
NEXT

defcode "0<",2,,ZLT     // comparisons with 0
    pop %eax
    test %eax,%eax
    setl %al
    movzbl %al,%eax
    pushl %eax
NEXT

defcode "0>",2,,ZGT
    pop %eax
    test %eax,%eax
    setg %al
    movzbl %al,%eax
    pushl %eax
NEXT

defcode "0<=",3,,ZLE
    pop %eax
    test %eax,%eax
    setle %al
    movzbl %al,%eax
    pushl %eax
NEXT

defcode "0>=",3,,ZGE
    pop %eax
    test %eax,%eax
    setge %al
    movzbl %al,%eax
    pushl %eax
NEXT

// ----------------------------------------------------------------------
// BITWISE 
// ----------------------------------------------------------------------

defcode "AND",3,,AND    // bitwise AND
    pop %eax
    andl %eax,(%esp)
NEXT

defcode "OR",2,,OR      // bitwise OR
    pop %eax
    orl %eax,(%esp)
NEXT

defcode "XOR",3,,XOR    // bitwise XOR
    pop %eax
    xorl %eax,(%esp)
NEXT

defcode "INVERT",6,,INVERT // this is the FORTH bitwise "NOT" function (cf. NEGATE and NOT)
    notl (%esp)
NEXT

// ----------------------------------------------------------------------
// MISC     
// ----------------------------------------------------------------------

defcode "EXIT",4,,EXIT
    POPRSP %esi             // pop return stack into %esi
NEXT

defcode "LIT",3,,LIT
    // %esi points to the next command, but in this case it points to the next
    // literal 32 bit integer.  Get that literal into %eax and increment %esi.
    // On x86, it's a convenient single byte instruction!  (cf. NEXT macro)
    lodsl
    push %eax               // push the literal number on to stack
NEXT

defcode "TELL",4,,TELL
    mov $1,%ebx             // 1st param: stdout
    pop %edx                // 3rd param: length of string
    pop %ecx                // 2nd param: address of string
    mov $__NR_write,%eax    // write syscall
    int $0x80
NEXT

defcode "CHAR",4,,CHAR
    call _WORD              // Returns %ecx = length, %edi = pointer to word.
    xor %eax,%eax
    movb (%edi),%al         // Get the first character of the word.
    push %eax               // Push it onto the stack.
NEXT

defcode "LITSTRING",9,,LITSTRING
    lodsl                   // get the length of the string
    push %esi               // push the address of the start of the string
    push %eax               // push it on the stack
    addl %eax,%esi          // skip past the string
    addl $3,%esi            // but round up to next 4 byte boundary
    andl $~3,%esi
NEXT

defcode "'",1,,TICK
    lodsl                   // Get the address of the next word and skip it.
    pushl %eax              // Push it on the stack.
NEXT


// ----------------------------------------------------------------------
#region MEMORY

defcode "!",1,,STORE
    pop %ebx            // address to store at
    pop %eax            // data to store there
    mov %eax,(%ebx)     // store it
NEXT

defcode "@",1,,FETCH
    pop %ebx                // address to fetch
    mov (%ebx),%eax         // fetch it
    push %eax               // push value onto stack
NEXT

defcode "+!",2,,ADDSTORE
    pop %ebx                // address
    pop %eax                // the amount to add
    addl %eax,(%ebx)        // add it
NEXT

defcode "-!",2,,SUBSTORE
    pop %ebx                // address
    pop %eax                // the amount to subtract
    subl %eax,(%ebx)        // add it
NEXT


defcode "C!",2,,STOREBYTE
    pop %ebx                // address to store at
    pop %eax                // data to store there
    movb %al,(%ebx)         // store it
NEXT

defcode "C@",2,,FETCHBYTE
    pop %ebx                // address to fetch
    xor %eax,%eax
    movb (%ebx),%al         // fetch it
    push %eax               // push value onto stack
NEXT

/* C@C! is a useful byte copy primitive. */
defcode "C@C!",4,,CCOPY
    movl 4(%esp),%ebx       // source address
    movb (%ebx),%al         // get source character
    pop %edi                // destination address
    stosb                   // copy to destination
    push %edi               // increment destination address
    incl 4(%esp)            // increment source address
NEXT

/* and CMOVE is a block copy operation. */
defcode "CMOVE",5,,CMOVE
    mov %esi,%edx           // preserve %esi
    pop %ecx                // length
    pop %edi                // destination address
    pop %esi                // source address
    rep movsb               // copy source to destination
    mov %edx,%esi           // restore %esi
NEXT

#endregion
// ----------------------------------------------------------------------
#region SYSTEM CALLS

defcode "SYSCALL3",8,,SYSCALL3
    pop %eax                // System call number (see <asm/unistd.h>)
    pop %ebx                // First parameter.
    pop %ecx                // Second parameter
    pop %edx                // Third parameter
    int $0x80
    push %eax               // Result (negative for -errno)
NEXT

defcode "SYSCALL2",8,,SYSCALL2
    pop %eax                // System call number (see <asm/unistd.h>)
    pop %ebx                // First parameter.
    pop %ecx                // Second parameter
    int $0x80
    push %eax               // Result (negative for -errno)
NEXT

defcode "SYSCALL1",8,,SYSCALL1
    pop %eax                // System call number (see <asm/unistd.h>)
    pop %ebx                // First parameter.
    int $0x80
    push %eax               // Result (negative for -errno)
NEXT

defcode "SYSCALL0",8,,SYSCALL0
    pop %eax                // System call number (see <asm/unistd.h>)
    int $0x80
    push %eax               // Result (negative for -errno)
NEXT

#endregion
// ----------------------------------------------------------------------

#endregion
// ----------------------------------------------------------------------
/* END OF jonesforth.S */
