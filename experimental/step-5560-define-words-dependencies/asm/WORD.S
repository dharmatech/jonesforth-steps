#ifndef ASM_WORD_S
#define ASM_WORD_S

defcode "WORD",4,,WORD
    call _WORD
    push %edi               // push base address
    push %ecx               // push length
NEXT

#define HAVE_WORD_WORD 1
#endif
