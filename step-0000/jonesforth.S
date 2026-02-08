/*
 * step-0000: debugger-first threaded VM seed
 *
 * This is intentionally not a full Forth yet. It only demonstrates:
 * - indirect threaded execution (NEXT)
 * - a tiny data stack on %esp
 * - a fixed threaded program in cold_start
 */

	#include <asm/unistd.h>

	.text

/* NEXT: fetch next cell pointed by %esi, then jump via its codeword. */
	.macro NEXT
	lodsl
	jmp *(%eax)
	.endm

/*
 * Primitive layout expected by NEXT:
 *
 *   WORD:
 *     .int code_WORD
 *   code_WORD:
 *     ...
 *     NEXT
 */

	.section .rodata
	.align 4
LIT:
	.int code_LIT
	.text
code_LIT:
	lodsl            // read literal cell following LIT
	push %eax        // push literal to data stack
	NEXT

	.section .rodata
	.align 4
DUP:
	.int code_DUP
	.text
code_DUP:
	mov (%esp),%eax
	push %eax
	NEXT

	.section .rodata
	.align 4
DROP:
	.int code_DROP
	.text
code_DROP:
	pop %eax
	NEXT

	.section .rodata
	.align 4
ADD:
	.int code_ADD
	.text
code_ADD:
	pop %eax
	addl %eax,(%esp)
	NEXT

	.section .rodata
	.align 4
BYE:
	.int code_BYE
	.text
code_BYE:
	xor %ebx,%ebx        // status = 0
	mov $__NR_exit,%eax
	int $0x80

/* Assembler entry point. */
	.globl _start
_start:
	cld
	mov $cold_start,%esi
	NEXT

/*
 * Fixed threaded program for step-0000:
 *
 *   LIT 2
 *   LIT 3
 *   ADD
 *   BYE
 *
 * After ADD, top of data stack is 5, visible in gdb before BYE executes.
 */
	.section .rodata
	.align 4
cold_start:
	.int LIT
	.int 2
	.int LIT
	.int 3
	.int ADD
	.int BYE
