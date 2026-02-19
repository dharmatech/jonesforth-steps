
defcode "DROP",4,,DROP
    pop %eax                // drop top of stack
NEXT

defcode "SWAP",4,,SWAP
    pop %eax                // swap top two elements on stack
    pop %ebx
    push %eax
    push %ebx
NEXT

defcode "DUP",3,,DUP
    mov (%esp),%eax         // duplicate top of stack
    push %eax
NEXT

defcode "OVER",4,,OVER
    mov 4(%esp),%eax        // get the second element of stack
    push %eax               // and push it on top
NEXT

defcode "ROT",3,,ROT
    pop %eax
    pop %ebx
    pop %ecx
    push %ebx
    push %eax
    push %ecx
NEXT

defcode "-ROT",4,,NROT
    pop %eax
    pop %ebx
    pop %ecx
    push %eax
    push %ecx
    push %ebx
NEXT

defcode "2DROP",5,,TWODROP // drop top two elements of stack
    pop %eax
    pop %eax
NEXT

defcode "2DUP",4,,TWODUP // duplicate top two elements of stack
    mov (%esp),%eax
    mov 4(%esp),%ebx
    push %ebx
    push %eax
NEXT

defcode "2SWAP",5,,TWOSWAP // swap top two pairs of elements of stack
    pop %eax
    pop %ebx
    pop %ecx
    pop %edx
    push %ebx
    push %eax
    push %edx
    push %ecx
NEXT

defcode "?DUP",4,,QDUP  // duplicate top of stack if non-zero
    movl (%esp),%eax
    test %eax,%eax
    jz 1f
    push %eax
    1:
NEXT