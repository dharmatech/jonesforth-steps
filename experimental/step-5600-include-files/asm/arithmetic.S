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


defcode "/MOD",4,,DIVMOD
    xor %edx,%edx
    pop %ebx
    pop %eax
    idivl %ebx
    push %edx               // push remainder
    push %eax               // push quotient
NEXT