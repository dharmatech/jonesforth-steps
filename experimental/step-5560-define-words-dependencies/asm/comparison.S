#ifndef ASM_COMPARISON_S
#define ASM_COMPARISON_S

/*      Lots of comparison operations like =, <, >, etc..

        ANS FORTH says that the comparison words should return all (binary) 1's for
        TRUE and all 0's for FALSE.  However this is a bit of a strange convention
        so this FORTH breaks it and returns the more normal (for C programmers ...)
        1 meaning TRUE and 0 meaning FALSE.
*/

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

#define HAVE_LIB_COMPARISON 1
#endif
