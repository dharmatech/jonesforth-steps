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
Breakpoint 1 at 0x08049020: file jonesforth.S, line 60.

Breakpoint 1, _start () at jonesforth.S:60
60		cld
``` 

# `info files` 
``` 
Symbols from "/home/dharmatech/docs/jonesforth-on-64/jonesforth-steps/step-0000/jonesforth".
Native process:
	Using the running image of child process 1030273.
	While running this, GDB does not access memory from...
Local exec file:
	`/home/dharmatech/docs/jonesforth-on-64/jonesforth-steps/step-0000/jonesforth', file type elf32-i386.
	Entry point: 0x08049020
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
process 1030273
Mapped address spaces:

	Start Addr   End Addr       Size     Offset  Perms   objfile
	 0x08048000  0x0804b000     0x3000        0x0  r-xp   /home/dharmatech/docs/jonesforth-on-64/jonesforth-steps/step-0000/jonesforth
	0xf7ff8000 0xf7ffc000     0x4000        0x0  r--p   [vvar]
	0xf7ffc000 0xf7ffe000     0x2000        0x0  r-xp   [vdso]
	0xfffdc000 0xffffe000    0x22000        0x0  rwxp   [stack]
``` 

# Memory Map Visualization 




``` 
.text
code_LIT    0x08049000 ad             lods   %ds:(%esi),%eax
            0x08049001 50             push   %eax
            0x08049002 ad             lods   %ds:(%esi),%eax
            0x08049003 ff 20          jmp    *(%eax)
code_DUP    0x08049005 8b 04 24       mov    (%esp),%eax
            0x08049008 50             push   %eax
            0x08049009 ad             lods   %ds:(%esi),%eax
            0x0804900a ff 20          jmp    *(%eax)
code_DROP   0x0804900c 58             pop    %eax
            0x0804900d ad             lods   %ds:(%esi),%eax
            0x0804900e ff 20          jmp    *(%eax)
code_ADD    0x08049010 58             pop    %eax
            0x08049011 01 04 24       add    %eax,(%esp)
            0x08049014 ad             lods   %ds:(%esi),%eax
            0x08049015 ff 20          jmp    *(%eax)
code_BYE    0x08049017 31 db          xor    %ebx,%ebx
            0x08049019 b8 01 00 00 00 mov    $0x1,%eax
            0x0804901e cd 80          int    $0x80
_start      0x08049020 fc             cld
            0x08049021 6a 00          push   $0x0
            0x08049023 6a 00          push   $0x0
            0x08049025 6a 00          push   $0x0
            0x08049027 6a 00          push   $0x0
            0x08049029 be 14 a0 04 08 mov    $0x0804a014,%esi
            0x0804902e ad             lods   %ds:(%esi),%eax
            0x0804902f ff 20          jmp    *(%eax)

.rodata
LIT         0x0804a000 0x08049000      code_LIT
DUP         0x0804a004 0x08049005      code_DUP
DROP        0x0804a008 0x0804900c      code_DROP
ADD         0x0804a00c 0x08049010      code_ADD
BYE         0x0804a010 0x08049017      code_BYE
cold_start  0x0804a014 0x0804a000      LIT
            0x0804a018 0x00000002
            0x0804a01c 0x0804a000      LIT
            0x0804a020 0x00000003
            0x0804a024 0x0804a00c      ADD
            0x0804a028 0x0804a010      BYE

# Single Stepping 
``` 
--------------------
62		push $0

$pc => 0x08049021 <_start+1>:	push   $0x0
$eax 0x00000000
$esi 0x00000000
$esp 0xffffca40:	1	-13361	0	-13284
--------------------
63		push $0

$pc => 0x08049023 <_start+3>:	push   $0x0
$eax 0x00000000
$esi 0x00000000
$esp 0xffffca3c:	0	1	-13361	0
--------------------
64		push $0

$pc => 0x08049025 <_start+5>:	push   $0x0
$eax 0x00000000
$esi 0x00000000
$esp 0xffffca38:	0	0	1	-13361
--------------------
65		push $0

$pc => 0x08049027 <_start+7>:	push   $0x0
$eax 0x00000000
$esi 0x00000000
$esp 0xffffca34:	0	0	0	1
--------------------
67		mov $cold_start,%esi

$pc => 0x08049029 <_start+9>:	mov    $0x0804a014,%esi
$eax 0x00000000
$esi 0x00000000
$esp 0xffffca30:	0	0	0	0
--------------------
68		NEXT

$pc => 0x0804902e <_start+14>:	lods   %ds:(%esi),%eax
$eax 0x00000000
$esi 0x0804a014  cold_start
$esp 0xffffca30:	0	0	0	0
--------------------
0x0804902f	68		NEXT

$pc => 0x0804902f <_start+15>:	jmp    *(%eax)
$eax 0x0804a000  LIT
$esi 0x0804a018  cold_start + 4
$esp 0xffffca30:	0	0	0	0
--------------------
34		lodsl            // read literal cell following LIT

$pc => 0x08049000 <code_LIT>:	lods   %ds:(%esi),%eax
$eax 0x0804a000  LIT
$esi 0x0804a018  cold_start + 4
$esp 0xffffca30:	0	0	0	0
--------------------
35		push %eax        // push literal to data stack

$pc => 0x08049001 <code_LIT+1>:	push   %eax
$eax 0x00000002
$esi 0x0804a01c  cold_start + 8
$esp 0xffffca30:	0	0	0	0
--------------------
36		NEXT

$pc => 0x08049002 <code_LIT+2>:	lods   %ds:(%esi),%eax
$eax 0x00000002
$esi 0x0804a01c  cold_start + 8
$esp 0xffffca2c:	2	0	0	0
--------------------
0x08049003	36		NEXT

$pc => 0x08049003 <code_LIT+3>:	jmp    *(%eax)
$eax 0x0804a000  LIT
$esi 0x0804a020  cold_start + 12
$esp 0xffffca2c:	2	0	0	0
--------------------
34		lodsl            // read literal cell following LIT

$pc => 0x08049000 <code_LIT>:	lods   %ds:(%esi),%eax
$eax 0x0804a000  LIT
$esi 0x0804a020  cold_start + 12
$esp 0xffffca2c:	2	0	0	0
--------------------
35		push %eax        // push literal to data stack

$pc => 0x08049001 <code_LIT+1>:	push   %eax
$eax 0x00000003
$esi 0x0804a024  cold_start + 16
$esp 0xffffca2c:	2	0	0	0
--------------------
36		NEXT

$pc => 0x08049002 <code_LIT+2>:	lods   %ds:(%esi),%eax
$eax 0x00000003
$esi 0x0804a024  cold_start + 16
$esp 0xffffca28:	3	2	0	0
--------------------
0x08049003	36		NEXT

$pc => 0x08049003 <code_LIT+3>:	jmp    *(%eax)
$eax 0x0804a00c  ADD
$esi 0x0804a028  cold_start + 20
$esp 0xffffca28:	3	2	0	0
--------------------
48		pop %eax

$pc => 0x08049010 <code_ADD>:	pop    %eax
$eax 0x0804a00c  ADD
$esi 0x0804a028  cold_start + 20
$esp 0xffffca28:	3	2	0	0
--------------------
49		addl %eax,(%esp)

$pc => 0x08049011 <code_ADD+1>:	add    %eax,(%esp)
$eax 0x00000003
$esi 0x0804a028  cold_start + 20
$esp 0xffffca2c:	2	0	0	0
--------------------
50		NEXT

$pc => 0x08049014 <code_ADD+4>:	lods   %ds:(%esi),%eax
$eax 0x00000003
$esi 0x0804a028  cold_start + 20
$esp 0xffffca2c:	5	0	0	0
--------------------
0x08049015	50		NEXT

$pc => 0x08049015 <code_ADD+5>:	jmp    *(%eax)
$eax 0x0804a010  BYE
$esi 0x0804a02c
$esp 0xffffca2c:	5	0	0	0
--------------------
53		xor %ebx,%ebx        // status = 0

$pc => 0x08049017 <code_BYE>:	xor    %ebx,%ebx
$eax 0x0804a010  BYE
$esi 0x0804a02c
$esp 0xffffca2c:	5	0	0	0
--------------------
54		mov $__NR_exit,%eax

$pc => 0x08049019 <code_BYE+2>:	mov    $0x1,%eax
$eax 0x0804a010  BYE
$esi 0x0804a02c
$esp 0xffffca2c:	5	0	0	0
--------------------
55		int $0x80

$pc => 0x0804901e <code_BYE+7>:	int    $0x80
$eax 0x00000001
$esi 0x0804a02c
$esp 0xffffca2c:	5	0	0	0
--------------------
[Inferior 1 (process 1030273) exited normally]

``` 
