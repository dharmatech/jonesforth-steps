#ifndef ASM_LBRAC_S
#define ASM_LBRAC_S

defcode "[",1,F_IMMED,LBRAC
    xor %eax,%eax
    movl %eax,var_STATE     // Set STATE to 0.
NEXT

#define HAVE_WORD_LBRAC 1
#endif
