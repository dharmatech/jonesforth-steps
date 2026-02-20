#ifndef ASM_RUNTIME_S
#define ASM_RUNTIME_S

defcode "CHAR",4,,CHAR
    call _WORD              // Returns %ecx = length, %edi = pointer to word.
    xor %eax,%eax
    movb (%edi),%al         // Get the first character of the word.
    push %eax               // Push it onto the stack.
NEXT

defcode "EXECUTE",7,,EXECUTE
    pop %eax                // Get xt into %eax
    jmp *(%eax)             // and jump to it.
    // After xt runs its NEXT will continue executing the current word.

#define HAVE_LIB_RUNTIME 1
#endif
