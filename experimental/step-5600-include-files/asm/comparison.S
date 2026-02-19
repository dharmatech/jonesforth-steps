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