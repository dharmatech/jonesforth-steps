#ifndef ASM_FETCH_S
#define ASM_FETCH_S

defcode "@",1,,FETCH
    pop %ebx                // address to fetch
    mov (%ebx),%eax         // fetch it
    push %eax               // push value onto stack
NEXT

#define HAVE_WORD_FETCH 1
#endif
