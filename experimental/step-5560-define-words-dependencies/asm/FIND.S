#ifndef ASM_FIND_S
#define ASM_FIND_S

defcode "FIND",4,,FIND
    pop %ecx                // %ecx = length
    pop %edi                // %edi = address
    call _FIND
    push %eax               // %eax = address of dictionary entry (or NULL)
NEXT

#define HAVE_WORD_FIND 1
#endif
