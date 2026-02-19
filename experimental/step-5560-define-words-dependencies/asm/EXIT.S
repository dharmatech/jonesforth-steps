#ifndef ASM_EXIT_S
#define ASM_EXIT_S

defcode "EXIT",4,,EXIT
    POPRSP %esi             // pop return stack into %esi
NEXT

#define HAVE_WORD_EXIT 1
#endif
