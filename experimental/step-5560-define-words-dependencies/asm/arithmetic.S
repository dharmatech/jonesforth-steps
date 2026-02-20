
#ifndef ASM_ARITHMETIC_S
#define ASM_ARITHMETIC_S

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

/*      In this FORTH, only /MOD is primitive.  Later we will define the / and MOD words in
        terms of the primitive /MOD.  The design of the i386 assembly instruction idiv which
        leaves both quotient and remainder makes this the obvious choice.
*/

defcode "/MOD",4,,DIVMOD
    xor %edx,%edx
    pop %ebx
    pop %eax
    idivl %ebx
    push %edx               // push remainder
    push %eax               // push quotient
NEXT

#define HAVE_LIB_ARITHMETIC 1
#endif
