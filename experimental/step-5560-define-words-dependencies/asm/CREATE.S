#ifndef ASM_CREATE_S
#define ASM_CREATE_S

defcode "CREATE",6,,CREATE

    // Get the name length and address.
    pop %ecx                // %ecx = length
    pop %ebx                // %ebx = address of name

    // Link pointer.
    movl var_HERE,%edi      // %edi is the address of the header
    movl var_LATEST,%eax    // Get link pointer
    stosl                   // and store it in the header.

    // Length byte and the word itself.
    mov %cl,%al             // Get the length.
    stosb                   // Store the length/flags byte.
    push %esi
    mov %ebx,%esi           // %esi = word
    rep movsb               // Copy the word
    pop %esi
    addl $3,%edi            // Align to next 4 byte boundary.
    andl $~3,%edi

    // Update LATEST and HERE.
    movl var_HERE,%eax
    movl %eax,var_LATEST
    movl %edi,var_HERE
NEXT

#define HAVE_WORD_CREATE 1
#endif
