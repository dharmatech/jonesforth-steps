defcode "AND",3,,AND    // bitwise AND
    pop %eax
    andl %eax,(%esp)
NEXT

defcode "OR",2,,OR      // bitwise OR
    pop %eax
    orl %eax,(%esp)
NEXT

defcode "XOR",3,,XOR    // bitwise XOR
    pop %eax
    xorl %eax,(%esp)
NEXT

defcode "INVERT",6,,INVERT // this is the FORTH bitwise "NOT" function (cf. NEGATE and NOT)
    notl (%esp)
NEXT