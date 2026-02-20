#ifndef ASM_SYSCALLS_S
#define ASM_SYSCALLS_S

defcode "SYSCALL3",8,,SYSCALL3
    pop %eax                // System call number (see <asm/unistd.h>)
    pop %ebx                // First parameter.
    pop %ecx                // Second parameter
    pop %edx                // Third parameter
    int $0x80
    push %eax               // Result (negative for -errno)
NEXT

defcode "SYSCALL2",8,,SYSCALL2
    pop %eax                // System call number (see <asm/unistd.h>)
    pop %ebx                // First parameter.
    pop %ecx                // Second parameter
    int $0x80
    push %eax               // Result (negative for -errno)
NEXT

defcode "SYSCALL1",8,,SYSCALL1
    pop %eax                // System call number (see <asm/unistd.h>)
    pop %ebx                // First parameter.
    int $0x80
    push %eax               // Result (negative for -errno)
NEXT

defcode "SYSCALL0",8,,SYSCALL0
    pop %eax                // System call number (see <asm/unistd.h>)
    int $0x80
    push %eax               // Result (negative for -errno)
NEXT

#define HAVE_LIB_SYSCALLS 1
#endif
