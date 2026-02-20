
#ifndef ASM_EMIT_S
#define ASM_EMIT_S

defcode "EMIT",4,,EMIT
    pop %eax
    call _EMIT
NEXT

_EMIT:
    mov $1,%ebx             // 1st param: stdout

    // write needs the address of the byte to write
    mov %al,emit_scratch
    mov $emit_scratch,%ecx  // 2nd param: address

    mov $1,%edx             // 3rd param: nbytes = 1

    mov $__NR_write,%eax    // write syscall
    int $0x80
ret

.data                   // NB: easier to fit in the .data section
emit_scratch:
.space 1                // scratch used by EMIT

#define HAVE_WORD_EMIT 1
#endif
