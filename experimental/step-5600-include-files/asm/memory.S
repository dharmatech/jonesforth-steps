defcode "!",1,,STORE
    pop %ebx            // address to store at
    pop %eax            // data to store there
    mov %eax,(%ebx)     // store it
NEXT

defcode "@",1,,FETCH
    pop %ebx                // address to fetch
    mov (%ebx),%eax         // fetch it
    push %eax               // push value onto stack
NEXT

defcode "+!",2,,ADDSTORE
    pop %ebx                // address
    pop %eax                // the amount to add
    addl %eax,(%ebx)        // add it
NEXT

defcode "-!",2,,SUBSTORE
    pop %ebx                // address
    pop %eax                // the amount to subtract
    subl %eax,(%ebx)        // add it
NEXT


defcode "C!",2,,STOREBYTE
    pop %ebx                // address to store at
    pop %eax                // data to store there
    movb %al,(%ebx)         // store it
NEXT

defcode "C@",2,,FETCHBYTE
    pop %ebx                // address to fetch
    xor %eax,%eax
    movb (%ebx),%al         // fetch it
    push %eax               // push value onto stack
NEXT

/* C@C! is a useful byte copy primitive. */
defcode "C@C!",4,,CCOPY
    movl 4(%esp),%ebx       // source address
    movb (%ebx),%al         // get source character
    pop %edi                // destination address
    stosb                   // copy to destination
    push %edi               // increment destination address
    incl 4(%esp)            // increment source address
NEXT

/* and CMOVE is a block copy operation. */
defcode "CMOVE",5,,CMOVE
    mov %esi,%edx           // preserve %esi
    pop %ecx                // length
    pop %edi                // destination address
    pop %esi                // source address
    rep movsb               // copy source to destination
    mov %edx,%esi           // restore %esi
NEXT