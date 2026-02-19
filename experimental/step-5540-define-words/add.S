
defcode "+",1,,ADD
    pop %eax                // get top of stack
    addl %eax,(%esp)        // and add it to next word on stack
NEXT
