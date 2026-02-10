# JonesForth Step-0000 GDB Session 
## Help 
### nvim 
``` 
*    Highlight item under cursor 
``` 
### Emacs 
``` 
M-s h .     Highlight item under cursor 
``` 
# Setup 
``` 
Breakpoint 1 at 0x8049020: file jonesforth.S, line 60.

Breakpoint 1, _start () at jonesforth.S:60
60		cld
1: x/i $pc
=> 0x8049020 <_start>:	cld    
2: /x $eax = 0x0
3: /x $esi = 0x0
4: x/4dw $esp
0xffffca70:	1	-13321	0	-13244
``` 

# `info files` 
``` 
Symbols from "/home/dharmatech/docs/jonesforth-on-64/jonesforth-steps/step-0000/jonesforth".
Native process:
	Using the running image of child process 960438.
	While running this, GDB does not access memory from...
Local exec file:
	`/home/dharmatech/docs/jonesforth-on-64/jonesforth-steps/step-0000/jonesforth', file type elf32-i386.
	Entry point: 0x8049020
	0x080480b4 - 0x080480d8 is .note.gnu.build-id
	0x08049000 - 0x08049031 is .text
	0x0804a000 - 0x0804a02c is .rodata
	0xf7ffc0b4 - 0xf7ffc0f4 is .hash in system-supplied DSO at 0xf7ffc000
	0xf7ffc0f4 - 0xf7ffc140 is .gnu.hash in system-supplied DSO at 0xf7ffc000
	0xf7ffc140 - 0xf7ffc1f0 is .dynsym in system-supplied DSO at 0xf7ffc000
	0xf7ffc1f0 - 0xf7ffc2b0 is .dynstr in system-supplied DSO at 0xf7ffc000
	0xf7ffc2b0 - 0xf7ffc2c6 is .gnu.version in system-supplied DSO at 0xf7ffc000
	0xf7ffc2c8 - 0xf7ffc31c is .gnu.version_d in system-supplied DSO at 0xf7ffc000
	0xf7ffc31c - 0xf7ffc3a4 is .dynamic in system-supplied DSO at 0xf7ffc000
	0xf7ffc3a4 - 0xf7ffc3b0 is .rodata in system-supplied DSO at 0xf7ffc000
	0xf7ffc3b0 - 0xf7ffc404 is .note in system-supplied DSO at 0xf7ffc000
	0xf7ffc404 - 0xf7ffc428 is .eh_frame_hdr in system-supplied DSO at 0xf7ffc000
	0xf7ffc428 - 0xf7ffc534 is .eh_frame in system-supplied DSO at 0xf7ffc000
	0xf7ffc540 - 0xf7ffd488 is .text in system-supplied DSO at 0xf7ffc000
	0xf7ffd488 - 0xf7ffd560 is .altinstructions in system-supplied DSO at 0xf7ffc000
	0xf7ffd560 - 0xf7ffd5a8 is .altinstr_replacement in system-supplied DSO at 0xf7ffc000
``` 

# `info proc mappings` 
``` 
process 960438
Mapped address spaces:

	Start Addr   End Addr       Size     Offset  Perms   objfile
	 0x8048000  0x804b000     0x3000        0x0  r-xp   /home/dharmatech/docs/jonesforth-on-64/jonesforth-steps/step-0000/jonesforth
	0xf7ff8000 0xf7ffc000     0x4000        0x0  r--p   [vvar]
	0xf7ffc000 0xf7ffe000     0x2000        0x0  r-xp   [vdso]
	0xfffdc000 0xffffe000    0x22000        0x0  rwxp   [stack]
``` 

# Memory Map Visualization 

## .text (disassemble with opcode bytes) 
``` 
Dump of assembler code from 0x8049000 to 0x8049032:
   0x08049000 <code_LIT+0>:	ad	lods   %ds:(%esi),%eax
   0x08049001 <code_LIT+1>:	50	push   %eax
   0x08049002 <code_LIT+2>:	ad	lods   %ds:(%esi),%eax
   0x08049003 <code_LIT+3>:	ff 20	jmp    *(%eax)
   0x08049005 <code_DUP+0>:	8b 04 24	mov    (%esp),%eax
   0x08049008 <code_DUP+3>:	50	push   %eax
   0x08049009 <code_DUP+4>:	ad	lods   %ds:(%esi),%eax
   0x0804900a <code_DUP+5>:	ff 20	jmp    *(%eax)
   0x0804900c <code_DROP+0>:	58	pop    %eax
   0x0804900d <code_DROP+1>:	ad	lods   %ds:(%esi),%eax
   0x0804900e <code_DROP+2>:	ff 20	jmp    *(%eax)
   0x08049010 <code_ADD+0>:	58	pop    %eax
   0x08049011 <code_ADD+1>:	01 04 24	add    %eax,(%esp)
   0x08049014 <code_ADD+4>:	ad	lods   %ds:(%esi),%eax
   0x08049015 <code_ADD+5>:	ff 20	jmp    *(%eax)
   0x08049017 <code_BYE+0>:	31 db	xor    %ebx,%ebx
   0x08049019 <code_BYE+2>:	b8 01 00 00 00	mov    $0x1,%eax
   0x0804901e <code_BYE+7>:	cd 80	int    $0x80
=> 0x08049020 <_start+0>:	fc	cld    
   0x08049021 <_start+1>:	6a 00	push   $0x0
   0x08049023 <_start+3>:	6a 00	push   $0x0
   0x08049025 <_start+5>:	6a 00	push   $0x0
   0x08049027 <_start+7>:	6a 00	push   $0x0
   0x08049029 <_start+9>:	be 14 a0 04 08	mov    $0x804a014,%esi
   0x0804902e <_start+14>:	ad	lods   %ds:(%esi),%eax
   0x0804902f <_start+15>:	ff 20	jmp    *(%eax)
   0x08049031:	00 00	add    %al,(%eax)
End of assembler dump.
``` 

## .rodata 
``` 
LIT   0x0804a000   0x08049000
DUP   0x0804a004   0x08049005
DROP  0x0804a008   0x0804900c
ADD   0x0804a00c   0x08049010
BYE   0x0804a010   0x08049017

cold_start 0x0804a014   0x0804a000
           0x0804a018   0x00000002

0x804a014:	0x0804a000
0x804a018:	0x00000002
0x804a01c:	0x0804a000
0x804a020:	0x00000003
0x804a024:	0x0804a00c
0x804a028:	0x0804a010
``` 

# Single Stepping 
``` 

62		push $0
1: x/i $pc
=> 0x8049021 <_start+1>:	push   $0x0
2: /x $eax = 0x0
3: /x $esi = 0x0
4: x/4dw $esp
0xffffca70:	1	-13321	0	-13244

63		push $0
1: x/i $pc
=> 0x8049023 <_start+3>:	push   $0x0
2: /x $eax = 0x0
3: /x $esi = 0x0
4: x/4dw $esp
0xffffca6c:	0	1	-13321	0

64		push $0
1: x/i $pc
=> 0x8049025 <_start+5>:	push   $0x0
2: /x $eax = 0x0
3: /x $esi = 0x0
4: x/4dw $esp
0xffffca68:	0	0	1	-13321

65		push $0
1: x/i $pc
=> 0x8049027 <_start+7>:	push   $0x0
2: /x $eax = 0x0
3: /x $esi = 0x0
4: x/4dw $esp
0xffffca64:	0	0	0	1

67		mov $cold_start,%esi
1: x/i $pc
=> 0x8049029 <_start+9>:	mov    $0x804a014,%esi
2: /x $eax = 0x0
3: /x $esi = 0x0
4: x/4dw $esp
0xffffca60:	0	0	0	0

68		NEXT
1: x/i $pc
=> 0x804902e <_start+14>:	lods   %ds:(%esi),%eax
2: /x $eax = 0x0
3: /x $esi = 0x804a014
4: x/4dw $esp
0xffffca60:	0	0	0	0

0x0804902f	68		NEXT
1: x/i $pc
=> 0x804902f <_start+15>:	jmp    *(%eax)
2: /x $eax = 0x804a000
3: /x $esi = 0x804a018
4: x/4dw $esp
0xffffca60:	0	0	0	0

34		lodsl            // read literal cell following LIT
1: x/i $pc
=> 0x8049000 <code_LIT>:	lods   %ds:(%esi),%eax
2: /x $eax = 0x804a000
3: /x $esi = 0x804a018
4: x/4dw $esp
0xffffca60:	0	0	0	0

35		push %eax        // push literal to data stack
1: x/i $pc
=> 0x8049001 <code_LIT+1>:	push   %eax
2: /x $eax = 0x2
3: /x $esi = 0x804a01c
4: x/4dw $esp
0xffffca60:	0	0	0	0

36		NEXT
1: x/i $pc
=> 0x8049002 <code_LIT+2>:	lods   %ds:(%esi),%eax
2: /x $eax = 0x2
3: /x $esi = 0x804a01c
4: x/4dw $esp
0xffffca5c:	2	0	0	0

0x08049003	36		NEXT
1: x/i $pc
=> 0x8049003 <code_LIT+3>:	jmp    *(%eax)
2: /x $eax = 0x804a000
3: /x $esi = 0x804a020
4: x/4dw $esp
0xffffca5c:	2	0	0	0

34		lodsl            // read literal cell following LIT
1: x/i $pc
=> 0x8049000 <code_LIT>:	lods   %ds:(%esi),%eax
2: /x $eax = 0x804a000
3: /x $esi = 0x804a020
4: x/4dw $esp
0xffffca5c:	2	0	0	0

35		push %eax        // push literal to data stack
1: x/i $pc
=> 0x8049001 <code_LIT+1>:	push   %eax
2: /x $eax = 0x3
3: /x $esi = 0x804a024
4: x/4dw $esp
0xffffca5c:	2	0	0	0

36		NEXT
1: x/i $pc
=> 0x8049002 <code_LIT+2>:	lods   %ds:(%esi),%eax
2: /x $eax = 0x3
3: /x $esi = 0x804a024
4: x/4dw $esp
0xffffca58:	3	2	0	0

0x08049003	36		NEXT
1: x/i $pc
=> 0x8049003 <code_LIT+3>:	jmp    *(%eax)
2: /x $eax = 0x804a00c
3: /x $esi = 0x804a028
4: x/4dw $esp
0xffffca58:	3	2	0	0

48		pop %eax
1: x/i $pc
=> 0x8049010 <code_ADD>:	pop    %eax
2: /x $eax = 0x804a00c
3: /x $esi = 0x804a028
4: x/4dw $esp
0xffffca58:	3	2	0	0

49		addl %eax,(%esp)
1: x/i $pc
=> 0x8049011 <code_ADD+1>:	add    %eax,(%esp)
2: /x $eax = 0x3
3: /x $esi = 0x804a028
4: x/4dw $esp
0xffffca5c:	2	0	0	0

50		NEXT
1: x/i $pc
=> 0x8049014 <code_ADD+4>:	lods   %ds:(%esi),%eax
2: /x $eax = 0x3
3: /x $esi = 0x804a028
4: x/4dw $esp
0xffffca5c:	5	0	0	0

0x08049015	50		NEXT
1: x/i $pc
=> 0x8049015 <code_ADD+5>:	jmp    *(%eax)
2: /x $eax = 0x804a010
3: /x $esi = 0x804a02c
4: x/4dw $esp
0xffffca5c:	5	0	0	0

53		xor %ebx,%ebx        // status = 0
1: x/i $pc
=> 0x8049017 <code_BYE>:	xor    %ebx,%ebx
2: /x $eax = 0x804a010
3: /x $esi = 0x804a02c
4: x/4dw $esp
0xffffca5c:	5	0	0	0

54		mov $__NR_exit,%eax
1: x/i $pc
=> 0x8049019 <code_BYE+2>:	mov    $0x1,%eax
2: /x $eax = 0x804a010
3: /x $esi = 0x804a02c
4: x/4dw $esp
0xffffca5c:	5	0	0	0

55		int $0x80
1: x/i $pc
=> 0x804901e <code_BYE+7>:	int    $0x80
2: /x $eax = 0x1
3: /x $esi = 0x804a02c
4: x/4dw $esp
0xffffca5c:	5	0	0	0

[Inferior 1 (process 960438) exited normally]
``` 
