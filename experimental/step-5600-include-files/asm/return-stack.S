
defcode ">R",2,,TOR
    pop %eax                // pop parameter stack into %eax
    PUSHRSP %eax            // push it on to the return stack
NEXT

defcode "R>",2,,FROMR
    POPRSP %eax             // pop return stack on to %eax
    push %eax               // and push on to parameter stack
NEXT

defcode "RSP@",4,,RSPFETCH
    push %ebp
NEXT

defcode "RSP!",4,,RSPSTORE
    pop %ebp
NEXT

defcode "RDROP",5,,RDROP
    addl $4,%ebp            // pop return stack and throw away
NEXT
