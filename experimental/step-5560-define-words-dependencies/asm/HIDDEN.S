#ifndef ASM_HIDDEN_S
#define ASM_HIDDEN_S

defcode "HIDDEN",6,,HIDDEN
    pop %edi                // Dictionary entry.
    addl $4,%edi            // Point to name/flags byte.
    xorb $F_HIDDEN,(%edi)   // Toggle the HIDDEN bit.
NEXT

#define HAVE_WORD_HIDDEN 1
#endif
