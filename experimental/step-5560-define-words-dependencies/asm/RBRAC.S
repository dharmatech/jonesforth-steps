#ifndef ASM_RBRAC_S
#define ASM_RBRAC_S

defcode "]",1,,RBRAC
    movl $1,var_STATE       // Set STATE to 1.
NEXT

#define HAVE_WORD_RBRAC 1
#endif
