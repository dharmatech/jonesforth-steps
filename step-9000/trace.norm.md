# JonesForth Step-9000 GDB Session 
# Setup 
``` 
Breakpoint 1 at 0x0804900e: file jonesforth.S, line 565.

Breakpoint 1, _start () at jonesforth.S:565
565		cld
``` 

# `info files` 
``` 
Symbols from "/home/dharmatech/docs/jonesforth-on-64/jonesforth-steps/step-9000/jonesforth".
Native process:
	Using the running image of child process 1029158.
	While running this, GDB does not access memory from...
Local exec file:
	`/home/dharmatech/docs/jonesforth-on-64/jonesforth-steps/step-9000/jonesforth', file type elf32-i386.
	Entry point: 0x0804900e
	0x080480d4 - 0x080480f8 is .note.gnu.build-id
	0x08049000 - 0x080495b6 is .text
	0x0804a000 - 0x0804a6d0 is .rodata
	0x0804b6d0 - 0x0804b714 is .data
	0x0804c000 - 0x0804f000 is .bss
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
process 1029158
Mapped address spaces:

	Start Addr   End Addr       Size     Offset  Perms   objfile
	 0x08048000  0x0804b000     0x3000        0x0  r-xp   /home/dharmatech/docs/jonesforth-on-64/jonesforth-steps/step-9000/jonesforth
	 0x0804b000  0x0804c000     0x1000     0x2000  rwxp   /home/dharmatech/docs/jonesforth-on-64/jonesforth-steps/step-9000/jonesforth
	 0x0804c000  0x0804f000     0x3000        0x0  rwxp   [heap]
	0xf7ff8000 0xf7ffc000     0x4000        0x0  r--p   [vvar]
	0xf7ffc000 0xf7ffe000     0x2000        0x0  r-xp   [vdso]
	0xfffdc000 0xffffe000    0x22000        0x0  rwxp   [stack]
``` 
.text
DOCOL                0x08049000 8d 6d fc                      lea    -0x4(%ebp),%ebp
                     0x08049003 89 75 00                      mov    %esi,0x0(%ebp)
                     0x08049006 83 c0 04                      add    $0x4,%eax
                     0x08049009 89 c6                         mov    %eax,%esi
                     0x0804900b ad                            lods   %ds:(%esi),%eax
                     0x0804900c ff 20                         jmp    *(%eax)
_start               0x0804900e fc                            cld
                     0x0804900f 89 25 dc b6 04 08             mov    %esp,0x0804b6dc
                     0x08049015 bd 00 e0 04 08                mov    $0x0804e000,%ebp
                     0x0804901a e8 7a 05 00 00                call   0x08049599 <set_up_data_segment>
                     0x0804901f be 00 a0 04 08                mov    $0x0804a000,%esi
                     0x08049024 ad                            lods   %ds:(%esi),%eax
                     0x08049025 ff 20                         jmp    *(%eax)
code_DROP            0x08049027 58                            pop    %eax
                     0x08049028 ad                            lods   %ds:(%esi),%eax
                     0x08049029 ff 20                         jmp    *(%eax)
code_SWAP            0x0804902b 58                            pop    %eax
                     0x0804902c 5b                            pop    %ebx
                     0x0804902d 50                            push   %eax
                     0x0804902e 53                            push   %ebx
                     0x0804902f ad                            lods   %ds:(%esi),%eax
                     0x08049030 ff 20                         jmp    *(%eax)
code_DUP             0x08049032 8b 04 24                      mov    (%esp),%eax
                     0x08049035 50                            push   %eax
                     0x08049036 ad                            lods   %ds:(%esi),%eax
                     0x08049037 ff 20                         jmp    *(%eax)
code_OVER            0x08049039 8b 44 24 04                   mov    0x4(%esp),%eax
                     0x0804903d 50                            push   %eax
                     0x0804903e ad                            lods   %ds:(%esi),%eax
                     0x0804903f ff 20                         jmp    *(%eax)
code_ROT             0x08049041 58                            pop    %eax
                     0x08049042 5b                            pop    %ebx
                     0x08049043 59                            pop    %ecx
                     0x08049044 53                            push   %ebx
                     0x08049045 50                            push   %eax
                     0x08049046 51                            push   %ecx
                     0x08049047 ad                            lods   %ds:(%esi),%eax
                     0x08049048 ff 20                         jmp    *(%eax)
code_NROT            0x0804904a 58                            pop    %eax
                     0x0804904b 5b                            pop    %ebx
                     0x0804904c 59                            pop    %ecx
                     0x0804904d 50                            push   %eax
                     0x0804904e 51                            push   %ecx
                     0x0804904f 53                            push   %ebx
                     0x08049050 ad                            lods   %ds:(%esi),%eax
                     0x08049051 ff 20                         jmp    *(%eax)
code_TWODROP         0x08049053 58                            pop    %eax
                     0x08049054 58                            pop    %eax
                     0x08049055 ad                            lods   %ds:(%esi),%eax
                     0x08049056 ff 20                         jmp    *(%eax)
code_TWODUP          0x08049058 8b 04 24                      mov    (%esp),%eax
                     0x0804905b 8b 5c 24 04                   mov    0x4(%esp),%ebx
                     0x0804905f 53                            push   %ebx
                     0x08049060 50                            push   %eax
                     0x08049061 ad                            lods   %ds:(%esi),%eax
                     0x08049062 ff 20                         jmp    *(%eax)
code_TWOSWAP         0x08049064 58                            pop    %eax
                     0x08049065 5b                            pop    %ebx
                     0x08049066 59                            pop    %ecx
                     0x08049067 5a                            pop    %edx
                     0x08049068 53                            push   %ebx
                     0x08049069 50                            push   %eax
                     0x0804906a 52                            push   %edx
                     0x0804906b 51                            push   %ecx
                     0x0804906c ad                            lods   %ds:(%esi),%eax
                     0x0804906d ff 20                         jmp    *(%eax)
code_QDUP            0x0804906f 8b 04 24                      mov    (%esp),%eax
                     0x08049072 85 c0                         test   %eax,%eax
                     0x08049074 74 01                         je     0x08049077 <code_QDUP+8>
                     0x08049076 50                            push   %eax
                     0x08049077 ad                            lods   %ds:(%esi),%eax
                     0x08049078 ff 20                         jmp    *(%eax)
code_INCR            0x0804907a ff 04 24                      incl   (%esp)
                     0x0804907d ad                            lods   %ds:(%esi),%eax
                     0x0804907e ff 20                         jmp    *(%eax)
code_DECR            0x08049080 ff 0c 24                      decl   (%esp)
                     0x08049083 ad                            lods   %ds:(%esi),%eax
                     0x08049084 ff 20                         jmp    *(%eax)
code_INCR4           0x08049086 83 04 24 04                   addl   $0x4,(%esp)
                     0x0804908a ad                            lods   %ds:(%esi),%eax
                     0x0804908b ff 20                         jmp    *(%eax)
code_DECR4           0x0804908d 83 2c 24 04                   subl   $0x4,(%esp)
                     0x08049091 ad                            lods   %ds:(%esi),%eax
                     0x08049092 ff 20                         jmp    *(%eax)
code_ADD             0x08049094 58                            pop    %eax
                     0x08049095 01 04 24                      add    %eax,(%esp)
                     0x08049098 ad                            lods   %ds:(%esi),%eax
                     0x08049099 ff 20                         jmp    *(%eax)
code_SUB             0x0804909b 58                            pop    %eax
                     0x0804909c 29 04 24                      sub    %eax,(%esp)
                     0x0804909f ad                            lods   %ds:(%esi),%eax
                     0x080490a0 ff 20                         jmp    *(%eax)
code_MUL             0x080490a2 58                            pop    %eax
                     0x080490a3 5b                            pop    %ebx
                     0x080490a4 0f af c3                      imul   %ebx,%eax
                     0x080490a7 50                            push   %eax
                     0x080490a8 ad                            lods   %ds:(%esi),%eax
                     0x080490a9 ff 20                         jmp    *(%eax)
code_DIVMOD          0x080490ab 31 d2                         xor    %edx,%edx
                     0x080490ad 5b                            pop    %ebx
                     0x080490ae 58                            pop    %eax
                     0x080490af f7 fb                         idiv   %ebx
                     0x080490b1 52                            push   %edx
                     0x080490b2 50                            push   %eax
                     0x080490b3 ad                            lods   %ds:(%esi),%eax
                     0x080490b4 ff 20                         jmp    *(%eax)
code_EQU             0x080490b6 58                            pop    %eax
                     0x080490b7 5b                            pop    %ebx
                     0x080490b8 39 d8                         cmp    %ebx,%eax
                     0x080490ba 0f 94 c0                      sete   %al
                     0x080490bd 0f b6 c0                      movzbl %al,%eax
                     0x080490c0 50                            push   %eax
                     0x080490c1 ad                            lods   %ds:(%esi),%eax
                     0x080490c2 ff 20                         jmp    *(%eax)
code_NEQU            0x080490c4 58                            pop    %eax
                     0x080490c5 5b                            pop    %ebx
                     0x080490c6 39 d8                         cmp    %ebx,%eax
                     0x080490c8 0f 95 c0                      setne  %al
                     0x080490cb 0f b6 c0                      movzbl %al,%eax
                     0x080490ce 50                            push   %eax
                     0x080490cf ad                            lods   %ds:(%esi),%eax
                     0x080490d0 ff 20                         jmp    *(%eax)
code_LT              0x080490d2 58                            pop    %eax
                     0x080490d3 5b                            pop    %ebx
                     0x080490d4 39 c3                         cmp    %eax,%ebx
                     0x080490d6 0f 9c c0                      setl   %al
                     0x080490d9 0f b6 c0                      movzbl %al,%eax
                     0x080490dc 50                            push   %eax
                     0x080490dd ad                            lods   %ds:(%esi),%eax
                     0x080490de ff 20                         jmp    *(%eax)
code_GT              0x080490e0 58                            pop    %eax
                     0x080490e1 5b                            pop    %ebx
                     0x080490e2 39 c3                         cmp    %eax,%ebx
                     0x080490e4 0f 9f c0                      setg   %al
                     0x080490e7 0f b6 c0                      movzbl %al,%eax
                     0x080490ea 50                            push   %eax
                     0x080490eb ad                            lods   %ds:(%esi),%eax
                     0x080490ec ff 20                         jmp    *(%eax)
code_LE              0x080490ee 58                            pop    %eax
                     0x080490ef 5b                            pop    %ebx
                     0x080490f0 39 c3                         cmp    %eax,%ebx
                     0x080490f2 0f 9e c0                      setle  %al
                     0x080490f5 0f b6 c0                      movzbl %al,%eax
                     0x080490f8 50                            push   %eax
                     0x080490f9 ad                            lods   %ds:(%esi),%eax
                     0x080490fa ff 20                         jmp    *(%eax)
code_GE              0x080490fc 58                            pop    %eax
                     0x080490fd 5b                            pop    %ebx
                     0x080490fe 39 c3                         cmp    %eax,%ebx
                     0x08049100 0f 9d c0                      setge  %al
                     0x08049103 0f b6 c0                      movzbl %al,%eax
                     0x08049106 50                            push   %eax
                     0x08049107 ad                            lods   %ds:(%esi),%eax
                     0x08049108 ff 20                         jmp    *(%eax)
code_ZEQU            0x0804910a 58                            pop    %eax
                     0x0804910b 85 c0                         test   %eax,%eax
                     0x0804910d 0f 94 c0                      sete   %al
                     0x08049110 0f b6 c0                      movzbl %al,%eax
                     0x08049113 50                            push   %eax
                     0x08049114 ad                            lods   %ds:(%esi),%eax
                     0x08049115 ff 20                         jmp    *(%eax)
code_ZNEQU           0x08049117 58                            pop    %eax
                     0x08049118 85 c0                         test   %eax,%eax
                     0x0804911a 0f 95 c0                      setne  %al
                     0x0804911d 0f b6 c0                      movzbl %al,%eax
                     0x08049120 50                            push   %eax
                     0x08049121 ad                            lods   %ds:(%esi),%eax
                     0x08049122 ff 20                         jmp    *(%eax)
code_ZLT             0x08049124 58                            pop    %eax
                     0x08049125 85 c0                         test   %eax,%eax
                     0x08049127 0f 9c c0                      setl   %al
                     0x0804912a 0f b6 c0                      movzbl %al,%eax
                     0x0804912d 50                            push   %eax
                     0x0804912e ad                            lods   %ds:(%esi),%eax
                     0x0804912f ff 20                         jmp    *(%eax)
code_ZGT             0x08049131 58                            pop    %eax
                     0x08049132 85 c0                         test   %eax,%eax
                     0x08049134 0f 9f c0                      setg   %al
                     0x08049137 0f b6 c0                      movzbl %al,%eax
                     0x0804913a 50                            push   %eax
                     0x0804913b ad                            lods   %ds:(%esi),%eax
                     0x0804913c ff 20                         jmp    *(%eax)
code_ZLE             0x0804913e 58                            pop    %eax
                     0x0804913f 85 c0                         test   %eax,%eax
                     0x08049141 0f 9e c0                      setle  %al
                     0x08049144 0f b6 c0                      movzbl %al,%eax
                     0x08049147 50                            push   %eax
                     0x08049148 ad                            lods   %ds:(%esi),%eax
                     0x08049149 ff 20                         jmp    *(%eax)
code_ZGE             0x0804914b 58                            pop    %eax
                     0x0804914c 85 c0                         test   %eax,%eax
                     0x0804914e 0f 9d c0                      setge  %al
                     0x08049151 0f b6 c0                      movzbl %al,%eax
                     0x08049154 50                            push   %eax
                     0x08049155 ad                            lods   %ds:(%esi),%eax
                     0x08049156 ff 20                         jmp    *(%eax)
code_AND             0x08049158 58                            pop    %eax
                     0x08049159 21 04 24                      and    %eax,(%esp)
                     0x0804915c ad                            lods   %ds:(%esi),%eax
                     0x0804915d ff 20                         jmp    *(%eax)
code_OR              0x0804915f 58                            pop    %eax
                     0x08049160 09 04 24                      or     %eax,(%esp)
                     0x08049163 ad                            lods   %ds:(%esi),%eax
                     0x08049164 ff 20                         jmp    *(%eax)
code_XOR             0x08049166 58                            pop    %eax
                     0x08049167 31 04 24                      xor    %eax,(%esp)
                     0x0804916a ad                            lods   %ds:(%esi),%eax
                     0x0804916b ff 20                         jmp    *(%eax)
code_INVERT          0x0804916d f7 14 24                      notl   (%esp)
                     0x08049170 ad                            lods   %ds:(%esi),%eax
                     0x08049171 ff 20                         jmp    *(%eax)
code_EXIT            0x08049173 8b 75 00                      mov    0x0(%ebp),%esi
                     0x08049176 8d 6d 04                      lea    0x4(%ebp),%ebp
                     0x08049179 ad                            lods   %ds:(%esi),%eax
                     0x0804917a ff 20                         jmp    *(%eax)
code_LIT             0x0804917c ad                            lods   %ds:(%esi),%eax
                     0x0804917d 50                            push   %eax
                     0x0804917e ad                            lods   %ds:(%esi),%eax
                     0x0804917f ff 20                         jmp    *(%eax)
code_STORE           0x08049181 5b                            pop    %ebx
                     0x08049182 58                            pop    %eax
                     0x08049183 89 03                         mov    %eax,(%ebx)
                     0x08049185 ad                            lods   %ds:(%esi),%eax
                     0x08049186 ff 20                         jmp    *(%eax)
code_FETCH           0x08049188 5b                            pop    %ebx
                     0x08049189 8b 03                         mov    (%ebx),%eax
                     0x0804918b 50                            push   %eax
                     0x0804918c ad                            lods   %ds:(%esi),%eax
                     0x0804918d ff 20                         jmp    *(%eax)
code_ADDSTORE        0x0804918f 5b                            pop    %ebx
                     0x08049190 58                            pop    %eax
                     0x08049191 01 03                         add    %eax,(%ebx)
                     0x08049193 ad                            lods   %ds:(%esi),%eax
                     0x08049194 ff 20                         jmp    *(%eax)
code_SUBSTORE        0x08049196 5b                            pop    %ebx
                     0x08049197 58                            pop    %eax
                     0x08049198 29 03                         sub    %eax,(%ebx)
                     0x0804919a ad                            lods   %ds:(%esi),%eax
                     0x0804919b ff 20                         jmp    *(%eax)
code_STOREBYTE       0x0804919d 5b                            pop    %ebx
                     0x0804919e 58                            pop    %eax
                     0x0804919f 88 03                         mov    %al,(%ebx)
                     0x080491a1 ad                            lods   %ds:(%esi),%eax
                     0x080491a2 ff 20                         jmp    *(%eax)
code_FETCHBYTE       0x080491a4 5b                            pop    %ebx
                     0x080491a5 31 c0                         xor    %eax,%eax
                     0x080491a7 8a 03                         mov    (%ebx),%al
                     0x080491a9 50                            push   %eax
                     0x080491aa ad                            lods   %ds:(%esi),%eax
                     0x080491ab ff 20                         jmp    *(%eax)
code_CCOPY           0x080491ad 8b 5c 24 04                   mov    0x4(%esp),%ebx
                     0x080491b1 8a 03                         mov    (%ebx),%al
                     0x080491b3 5f                            pop    %edi
                     0x080491b4 aa                            stos   %al,%es:(%edi)
                     0x080491b5 57                            push   %edi
                     0x080491b6 ff 44 24 04                   incl   0x4(%esp)
                     0x080491ba ad                            lods   %ds:(%esi),%eax
                     0x080491bb ff 20                         jmp    *(%eax)
code_CMOVE           0x080491bd 89 f2                         mov    %esi,%edx
                     0x080491bf 59                            pop    %ecx
                     0x080491c0 5f                            pop    %edi
                     0x080491c1 5e                            pop    %esi
                     0x080491c2 f3 a4                         rep movsb %ds:(%esi),%es:(%edi)
                     0x080491c4 89 d6                         mov    %edx,%esi
                     0x080491c6 ad                            lods   %ds:(%esi),%eax
                     0x080491c7 ff 20                         jmp    *(%eax)
code_STATE           0x080491c9 68 d0 b6 04 08                push   $0x0804b6d0
                     0x080491ce ad                            lods   %ds:(%esi),%eax
                     0x080491cf ff 20                         jmp    *(%eax)
code_HERE            0x080491d1 68 d4 b6 04 08                push   $0x0804b6d4
                     0x080491d6 ad                            lods   %ds:(%esi),%eax
                     0x080491d7 ff 20                         jmp    *(%eax)
code_LATEST          0x080491d9 68 d8 b6 04 08                push   $0x0804b6d8
                     0x080491de ad                            lods   %ds:(%esi),%eax
                     0x080491df ff 20                         jmp    *(%eax)
code_SZ              0x080491e1 68 dc b6 04 08                push   $0x0804b6dc
                     0x080491e6 ad                            lods   %ds:(%esi),%eax
                     0x080491e7 ff 20                         jmp    *(%eax)
code_BASE            0x080491e9 68 e0 b6 04 08                push   $0x0804b6e0
                     0x080491ee ad                            lods   %ds:(%esi),%eax
                     0x080491ef ff 20                         jmp    *(%eax)
code_VERSION         0x080491f1 6a 2f                         push   $0x2f
                     0x080491f3 ad                            lods   %ds:(%esi),%eax
                     0x080491f4 ff 20                         jmp    *(%eax)
code_RZ              0x080491f6 68 00 e0 04 08                push   $0x0804e000
                     0x080491fb ad                            lods   %ds:(%esi),%eax
                     0x080491fc ff 20                         jmp    *(%eax)
code___DOCOL         0x080491fe 68 00 90 04 08                push   $0x08049000
                     0x08049203 ad                            lods   %ds:(%esi),%eax
                     0x08049204 ff 20                         jmp    *(%eax)
code___F_IMMED       0x08049206 68 80 00 00 00                push   $0x80
                     0x0804920b ad                            lods   %ds:(%esi),%eax
                     0x0804920c ff 20                         jmp    *(%eax)
code___F_HIDDEN      0x0804920e 6a 20                         push   $0x20
                     0x08049210 ad                            lods   %ds:(%esi),%eax
                     0x08049211 ff 20                         jmp    *(%eax)
code___F_LENMASK     0x08049213 6a 1f                         push   $0x1f
                     0x08049215 ad                            lods   %ds:(%esi),%eax
                     0x08049216 ff 20                         jmp    *(%eax)
code_SYS_EXIT        0x08049218 6a 01                         push   $0x1
                     0x0804921a ad                            lods   %ds:(%esi),%eax
                     0x0804921b ff 20                         jmp    *(%eax)
code_SYS_OPEN        0x0804921d 6a 05                         push   $0x5
                     0x0804921f ad                            lods   %ds:(%esi),%eax
                     0x08049220 ff 20                         jmp    *(%eax)
code_SYS_CLOSE       0x08049222 6a 06                         push   $0x6
                     0x08049224 ad                            lods   %ds:(%esi),%eax
                     0x08049225 ff 20                         jmp    *(%eax)
code_SYS_READ        0x08049227 6a 03                         push   $0x3
                     0x08049229 ad                            lods   %ds:(%esi),%eax
                     0x0804922a ff 20                         jmp    *(%eax)
code_SYS_WRITE       0x0804922c 6a 04                         push   $0x4
                     0x0804922e ad                            lods   %ds:(%esi),%eax
                     0x0804922f ff 20                         jmp    *(%eax)
code_SYS_CREAT       0x08049231 6a 08                         push   $0x8
                     0x08049233 ad                            lods   %ds:(%esi),%eax
                     0x08049234 ff 20                         jmp    *(%eax)
code_SYS_BRK         0x08049236 6a 2d                         push   $0x2d
                     0x08049238 ad                            lods   %ds:(%esi),%eax
                     0x08049239 ff 20                         jmp    *(%eax)
code___O_RDONLY      0x0804923b 6a 00                         push   $0x0
                     0x0804923d ad                            lods   %ds:(%esi),%eax
                     0x0804923e ff 20                         jmp    *(%eax)
code___O_WRONLY      0x08049240 6a 01                         push   $0x1
                     0x08049242 ad                            lods   %ds:(%esi),%eax
                     0x08049243 ff 20                         jmp    *(%eax)
code___O_RDWR        0x08049245 6a 02                         push   $0x2
                     0x08049247 ad                            lods   %ds:(%esi),%eax
                     0x08049248 ff 20                         jmp    *(%eax)
code___O_CREAT       0x0804924a 6a 40                         push   $0x40
                     0x0804924c ad                            lods   %ds:(%esi),%eax
                     0x0804924d ff 20                         jmp    *(%eax)
code___O_EXCL        0x0804924f 68 80 00 00 00                push   $0x80
                     0x08049254 ad                            lods   %ds:(%esi),%eax
                     0x08049255 ff 20                         jmp    *(%eax)
code___O_TRUNC       0x08049257 68 00 02 00 00                push   $0x200
                     0x0804925c ad                            lods   %ds:(%esi),%eax
                     0x0804925d ff 20                         jmp    *(%eax)
code___O_APPEND      0x0804925f 68 00 04 00 00                push   $0x400
                     0x08049264 ad                            lods   %ds:(%esi),%eax
                     0x08049265 ff 20                         jmp    *(%eax)
code___O_NONBLOCK    0x08049267 68 00 08 00 00                push   $0x800
                     0x0804926c ad                            lods   %ds:(%esi),%eax
                     0x0804926d ff 20                         jmp    *(%eax)
code_TOR             0x0804926f 58                            pop    %eax
                     0x08049270 8d 6d fc                      lea    -0x4(%ebp),%ebp
                     0x08049273 89 45 00                      mov    %eax,0x0(%ebp)
                     0x08049276 ad                            lods   %ds:(%esi),%eax
                     0x08049277 ff 20                         jmp    *(%eax)
code_FROMR           0x08049279 8b 45 00                      mov    0x0(%ebp),%eax
                     0x0804927c 8d 6d 04                      lea    0x4(%ebp),%ebp
                     0x0804927f 50                            push   %eax
                     0x08049280 ad                            lods   %ds:(%esi),%eax
                     0x08049281 ff 20                         jmp    *(%eax)
code_RSPFETCH        0x08049283 55                            push   %ebp
                     0x08049284 ad                            lods   %ds:(%esi),%eax
                     0x08049285 ff 20                         jmp    *(%eax)
code_RSPSTORE        0x08049287 5d                            pop    %ebp
                     0x08049288 ad                            lods   %ds:(%esi),%eax
                     0x08049289 ff 20                         jmp    *(%eax)
code_RDROP           0x0804928b 83 c5 04                      add    $0x4,%ebp
                     0x0804928e ad                            lods   %ds:(%esi),%eax
                     0x0804928f ff 20                         jmp    *(%eax)
code_DSPFETCH        0x08049291 89 e0                         mov    %esp,%eax
                     0x08049293 50                            push   %eax
                     0x08049294 ad                            lods   %ds:(%esi),%eax
                     0x08049295 ff 20                         jmp    *(%eax)
code_DSPSTORE        0x08049297 5c                            pop    %esp
                     0x08049298 ad                            lods   %ds:(%esi),%eax
                     0x08049299 ff 20                         jmp    *(%eax)
code_KEY             0x0804929b e8 04 00 00 00                call   0x080492a4 <_KEY>
                     0x080492a0 50                            push   %eax
                     0x080492a1 ad                            lods   %ds:(%esi),%eax
                     0x080492a2 ff 20                         jmp    *(%eax)
_KEY                 0x080492a4 8b 1d e4 b6 04 08             mov    0x0804b6e4,%ebx
                     0x080492aa 3b 1d e8 b6 04 08             cmp    0x0804b6e8,%ebx
                     0x080492b0 7d 0c                         jge    0x080492be <_KEY+26>
                     0x080492b2 31 c0                         xor    %eax,%eax
                     0x080492b4 8a 03                         mov    (%ebx),%al
                     0x080492b6 43                            inc    %ebx
                     0x080492b7 89 1d e4 b6 04 08             mov    %ebx,0x0804b6e4
                     0x080492bd c3                            ret
                     0x080492be 31 db                         xor    %ebx,%ebx
                     0x080492c0 b9 00 e0 04 08                mov    $0x0804e000,%ecx
                     0x080492c5 89 0d e4 b6 04 08             mov    %ecx,0x0804b6e4
                     0x080492cb ba 00 10 00 00                mov    $0x1000,%edx
                     0x080492d0 b8 03 00 00 00                mov    $0x3,%eax
                     0x080492d5 cd 80                         int    $0x80
                     0x080492d7 85 c0                         test   %eax,%eax
                     0x080492d9 76 0a                         jbe    0x080492e5 <_KEY+65>
                     0x080492db 01 c1                         add    %eax,%ecx
                     0x080492dd 89 0d e8 b6 04 08             mov    %ecx,0x0804b6e8
                     0x080492e3 eb bf                         jmp    0x080492a4 <_KEY>
                     0x080492e5 31 db                         xor    %ebx,%ebx
                     0x080492e7 b8 01 00 00 00                mov    $0x1,%eax
                     0x080492ec cd 80                         int    $0x80
code_EMIT            0x080492ee 58                            pop    %eax
                     0x080492ef e8 03 00 00 00                call   0x080492f7 <_EMIT>
                     0x080492f4 ad                            lods   %ds:(%esi),%eax
                     0x080492f5 ff 20                         jmp    *(%eax)
_EMIT                0x080492f7 bb 01 00 00 00                mov    $0x1,%ebx
                     0x080492fc a2 ec b6 04 08                mov    %al,0x0804b6ec
                     0x08049301 b9 ec b6 04 08                mov    $0x0804b6ec,%ecx
                     0x08049306 ba 01 00 00 00                mov    $0x1,%edx
                     0x0804930b b8 04 00 00 00                mov    $0x4,%eax
                     0x08049310 cd 80                         int    $0x80
                     0x08049312 c3                            ret
code_WORD            0x08049313 e8 05 00 00 00                call   0x0804931d <_WORD>
                     0x08049318 57                            push   %edi
                     0x08049319 51                            push   %ecx
                     0x0804931a ad                            lods   %ds:(%esi),%eax
                     0x0804931b ff 20                         jmp    *(%eax)
_WORD                0x0804931d e8 82 ff ff ff                call   0x080492a4 <_KEY>
                     0x08049322 3c 5c                         cmp    $0x5c,%al
                     0x08049324 74 21                         je     0x08049347 <_WORD+42>
                     0x08049326 3c 20                         cmp    $0x20,%al
                     0x08049328 76 f3                         jbe    0x0804931d <_WORD>
                     0x0804932a bf ed b6 04 08                mov    $0x0804b6ed,%edi
                     0x0804932f aa                            stos   %al,%es:(%edi)
                     0x08049330 e8 6f ff ff ff                call   0x080492a4 <_KEY>
                     0x08049335 3c 20                         cmp    $0x20,%al
                     0x08049337 77 f6                         ja     0x0804932f <_WORD+18>
                     0x08049339 81 ef ed b6 04 08             sub    $0x0804b6ed,%edi
                     0x0804933f 89 f9                         mov    %edi,%ecx
                     0x08049341 bf ed b6 04 08                mov    $0x0804b6ed,%edi
                     0x08049346 c3                            ret
                     0x08049347 e8 58 ff ff ff                call   0x080492a4 <_KEY>
                     0x0804934c 3c 0a                         cmp    $0xa,%al
                     0x0804934e 75 f7                         jne    0x08049347 <_WORD+42>
                     0x08049350 eb cb                         jmp    0x0804931d <_WORD>
code_NUMBER          0x08049352 59                            pop    %ecx
                     0x08049353 5f                            pop    %edi
                     0x08049354 e8 05 00 00 00                call   0x0804935e <_NUMBER>
                     0x08049359 50                            push   %eax
                     0x0804935a 51                            push   %ecx
                     0x0804935b ad                            lods   %ds:(%esi),%eax
                     0x0804935c ff 20                         jmp    *(%eax)
_NUMBER              0x0804935e 31 c0                         xor    %eax,%eax
                     0x08049360 31 db                         xor    %ebx,%ebx
                     0x08049362 85 c9                         test   %ecx,%ecx
                     0x08049364 74 43                         je     0x080493a9 <_NUMBER+75>
                     0x08049366 8b 15 e0 b6 04 08             mov    0x0804b6e0,%edx
                     0x0804936c 8a 1f                         mov    (%edi),%bl
                     0x0804936e 47                            inc    %edi
                     0x0804936f 50                            push   %eax
                     0x08049370 80 fb 2d                      cmp    $0x2d,%bl
                     0x08049373 75 12                         jne    0x08049387 <_NUMBER+41>
                     0x08049375 58                            pop    %eax
                     0x08049376 53                            push   %ebx
                     0x08049377 49                            dec    %ecx
                     0x08049378 75 07                         jne    0x08049381 <_NUMBER+35>
                     0x0804937a 5b                            pop    %ebx
                     0x0804937b b9 01 00 00 00                mov    $0x1,%ecx
                     0x08049380 c3                            ret
                     0x08049381 0f af c2                      imul   %edx,%eax
                     0x08049384 8a 1f                         mov    (%edi),%bl
                     0x08049386 47                            inc    %edi
                     0x08049387 80 eb 30                      sub    $0x30,%bl
                     0x0804938a 72 16                         jb     0x080493a2 <_NUMBER+68>
                     0x0804938c 80 fb 0a                      cmp    $0xa,%bl
                     0x0804938f 72 08                         jb     0x08049399 <_NUMBER+59>
                     0x08049391 80 eb 11                      sub    $0x11,%bl
                     0x08049394 72 0c                         jb     0x080493a2 <_NUMBER+68>
                     0x08049396 80 c3 0a                      add    $0xa,%bl
                     0x08049399 38 d3                         cmp    %dl,%bl
                     0x0804939b 7d 05                         jge    0x080493a2 <_NUMBER+68>
                     0x0804939d 01 d8                         add    %ebx,%eax
                     0x0804939f 49                            dec    %ecx
                     0x080493a0 75 df                         jne    0x08049381 <_NUMBER+35>
                     0x080493a2 5b                            pop    %ebx
                     0x080493a3 85 db                         test   %ebx,%ebx
                     0x080493a5 74 02                         je     0x080493a9 <_NUMBER+75>
                     0x080493a7 f7 d8                         neg    %eax
                     0x080493a9 c3                            ret
code_FIND            0x080493aa 59                            pop    %ecx
                     0x080493ab 5f                            pop    %edi
                     0x080493ac e8 04 00 00 00                call   0x080493b5 <_FIND>
                     0x080493b1 50                            push   %eax
                     0x080493b2 ad                            lods   %ds:(%esi),%eax
                     0x080493b3 ff 20                         jmp    *(%eax)
_FIND                0x080493b5 56                            push   %esi
                     0x080493b6 8b 15 d8 b6 04 08             mov    0x0804b6d8,%edx
                     0x080493bc 85 d2                         test   %edx,%edx
                     0x080493be 74 1e                         je     0x080493de <_FIND+41>
                     0x080493c0 31 c0                         xor    %eax,%eax
                     0x080493c2 8a 42 04                      mov    0x4(%edx),%al
                     0x080493c5 24 3f                         and    $0x3f,%al
                     0x080493c7 38 c8                         cmp    %cl,%al
                     0x080493c9 75 0f                         jne    0x080493da <_FIND+37>
                     0x080493cb 51                            push   %ecx
                     0x080493cc 57                            push   %edi
                     0x080493cd 8d 72 05                      lea    0x5(%edx),%esi
                     0x080493d0 f3 a6                         repz cmpsb %es:(%edi),%ds:(%esi)
                     0x080493d2 5f                            pop    %edi
                     0x080493d3 59                            pop    %ecx
                     0x080493d4 75 04                         jne    0x080493da <_FIND+37>
                     0x080493d6 5e                            pop    %esi
                     0x080493d7 89 d0                         mov    %edx,%eax
                     0x080493d9 c3                            ret
                     0x080493da 8b 12                         mov    (%edx),%edx
                     0x080493dc eb de                         jmp    0x080493bc <_FIND+7>
                     0x080493de 5e                            pop    %esi
                     0x080493df 31 c0                         xor    %eax,%eax
                     0x080493e1 c3                            ret
code_TCFA            0x080493e2 5f                            pop    %edi
                     0x080493e3 e8 04 00 00 00                call   0x080493ec <_TCFA>
                     0x080493e8 57                            push   %edi
                     0x080493e9 ad                            lods   %ds:(%esi),%eax
                     0x080493ea ff 20                         jmp    *(%eax)
_TCFA                0x080493ec 31 c0                         xor    %eax,%eax
                     0x080493ee 83 c7 04                      add    $0x4,%edi
                     0x080493f1 8a 07                         mov    (%edi),%al
                     0x080493f3 47                            inc    %edi
                     0x080493f4 24 1f                         and    $0x1f,%al
                     0x080493f6 01 c7                         add    %eax,%edi
                     0x080493f8 83 c7 03                      add    $0x3,%edi
                     0x080493fb 83 e7 fc                      and    $0xfffffffc,%edi
                     0x080493fe c3                            ret
code_CREATE          0x080493ff 59                            pop    %ecx
                     0x08049400 5b                            pop    %ebx
                     0x08049401 8b 3d d4 b6 04 08             mov    0x0804b6d4,%edi
                     0x08049407 a1 d8 b6 04 08                mov    0x0804b6d8,%eax
                     0x0804940c ab                            stos   %eax,%es:(%edi)
                     0x0804940d 88 c8                         mov    %cl,%al
                     0x0804940f aa                            stos   %al,%es:(%edi)
                     0x08049410 56                            push   %esi
                     0x08049411 89 de                         mov    %ebx,%esi
                     0x08049413 f3 a4                         rep movsb %ds:(%esi),%es:(%edi)
                     0x08049415 5e                            pop    %esi
                     0x08049416 83 c7 03                      add    $0x3,%edi
                     0x08049419 83 e7 fc                      and    $0xfffffffc,%edi
                     0x0804941c a1 d4 b6 04 08                mov    0x0804b6d4,%eax
                     0x08049421 a3 d8 b6 04 08                mov    %eax,0x0804b6d8
                     0x08049426 89 3d d4 b6 04 08             mov    %edi,0x0804b6d4
                     0x0804942c ad                            lods   %ds:(%esi),%eax
                     0x0804942d ff 20                         jmp    *(%eax)
code_COMMA           0x0804942f 58                            pop    %eax
                     0x08049430 e8 03 00 00 00                call   0x08049438 <_COMMA>
                     0x08049435 ad                            lods   %ds:(%esi),%eax
                     0x08049436 ff 20                         jmp    *(%eax)
_COMMA               0x08049438 8b 3d d4 b6 04 08             mov    0x0804b6d4,%edi
                     0x0804943e ab                            stos   %eax,%es:(%edi)
                     0x0804943f 89 3d d4 b6 04 08             mov    %edi,0x0804b6d4
                     0x08049445 c3                            ret
code_LBRAC           0x08049446 31 c0                         xor    %eax,%eax
                     0x08049448 a3 d0 b6 04 08                mov    %eax,0x0804b6d0
                     0x0804944d ad                            lods   %ds:(%esi),%eax
                     0x0804944e ff 20                         jmp    *(%eax)
code_RBRAC           0x08049450 c7 05 d0 b6 04 08 01 00 00 00 movl   $0x1,0x0804b6d0
                     0x0804945a ad                            lods   %ds:(%esi),%eax
                     0x0804945b ff 20                         jmp    *(%eax)
code_IMMEDIATE       0x0804945d 8b 3d d8 b6 04 08             mov    0x0804b6d8,%edi
                     0x08049463 83 c7 04                      add    $0x4,%edi
                     0x08049466 80 37 80                      xorb   $0x80,(%edi)
                     0x08049469 ad                            lods   %ds:(%esi),%eax
                     0x0804946a ff 20                         jmp    *(%eax)
code_HIDDEN          0x0804946c 5f                            pop    %edi
                     0x0804946d 83 c7 04                      add    $0x4,%edi
                     0x08049470 80 37 20                      xorb   $0x20,(%edi)
                     0x08049473 ad                            lods   %ds:(%esi),%eax
                     0x08049474 ff 20                         jmp    *(%eax)
code_TICK            0x08049476 ad                            lods   %ds:(%esi),%eax
                     0x08049477 50                            push   %eax
                     0x08049478 ad                            lods   %ds:(%esi),%eax
                     0x08049479 ff 20                         jmp    *(%eax)
code_BRANCH          0x0804947b 03 36                         add    (%esi),%esi
                     0x0804947d ad                            lods   %ds:(%esi),%eax
                     0x0804947e ff 20                         jmp    *(%eax)
code_ZBRANCH         0x08049480 58                            pop    %eax
                     0x08049481 85 c0                         test   %eax,%eax
                     0x08049483 74 f6                         je     0x0804947b <code_BRANCH>
                     0x08049485 ad                            lods   %ds:(%esi),%eax
                     0x08049486 ad                            lods   %ds:(%esi),%eax
                     0x08049487 ff 20                         jmp    *(%eax)
code_LITSTRING       0x08049489 ad                            lods   %ds:(%esi),%eax
                     0x0804948a 56                            push   %esi
                     0x0804948b 50                            push   %eax
                     0x0804948c 01 c6                         add    %eax,%esi
                     0x0804948e 83 c6 03                      add    $0x3,%esi
                     0x08049491 83 e6 fc                      and    $0xfffffffc,%esi
                     0x08049494 ad                            lods   %ds:(%esi),%eax
                     0x08049495 ff 20                         jmp    *(%eax)
code_TELL            0x08049497 bb 01 00 00 00                mov    $0x1,%ebx
                     0x0804949c 5a                            pop    %edx
                     0x0804949d 59                            pop    %ecx
                     0x0804949e b8 04 00 00 00                mov    $0x4,%eax
                     0x080494a3 cd 80                         int    $0x80
                     0x080494a5 ad                            lods   %ds:(%esi),%eax
                     0x080494a6 ff 20                         jmp    *(%eax)
code_INTERPRET       0x080494a8 e8 70 fe ff ff                call   0x0804931d <_WORD>
                     0x080494ad 31 c0                         xor    %eax,%eax
                     0x080494af a3 10 b7 04 08                mov    %eax,0x0804b710
                     0x080494b4 e8 fc fe ff ff                call   0x080493b5 <_FIND>
                     0x080494b9 85 c0                         test   %eax,%eax
                     0x080494bb 74 16                         je     0x080494d3 <code_INTERPRET+43>
                     0x080494bd 89 c7                         mov    %eax,%edi
                     0x080494bf 8a 47 04                      mov    0x4(%edi),%al
                     0x080494c2 66 50                         push   %ax
                     0x080494c4 e8 23 ff ff ff                call   0x080493ec <_TCFA>
                     0x080494c9 66 58                         pop    %ax
                     0x080494cb 24 80                         and    $0x80,%al
                     0x080494cd 89 f8                         mov    %edi,%eax
                     0x080494cf 75 3b                         jne    0x0804950c <code_INTERPRET+100>
                     0x080494d1 eb 16                         jmp    0x080494e9 <code_INTERPRET+65>
                     0x080494d3 ff 05 10 b7 04 08             incl   0x0804b710
                     0x080494d9 e8 80 fe ff ff                call   0x0804935e <_NUMBER>
                     0x080494de 85 c9                         test   %ecx,%ecx
                     0x080494e0 75 3a                         jne    0x0804951c <code_INTERPRET+116>
                     0x080494e2 89 c3                         mov    %eax,%ebx
                     0x080494e4 b8 dc a1 04 08                mov    $0x0804a1dc,%eax
                     0x080494e9 8b 15 d0 b6 04 08             mov    0x0804b6d0,%edx
                     0x080494ef 85 d2                         test   %edx,%edx
                     0x080494f1 74 19                         je     0x0804950c <code_INTERPRET+100>
                     0x080494f3 e8 40 ff ff ff                call   0x08049438 <_COMMA>
                     0x080494f8 8b 0d 10 b7 04 08             mov    0x0804b710,%ecx
                     0x080494fe 85 c9                         test   %ecx,%ecx
                     0x08049500 74 07                         je     0x08049509 <code_INTERPRET+97>
                     0x08049502 89 d8                         mov    %ebx,%eax
                     0x08049504 e8 2f ff ff ff                call   0x08049438 <_COMMA>
                     0x08049509 ad                            lods   %ds:(%esi),%eax
                     0x0804950a ff 20                         jmp    *(%eax)
                     0x0804950c 8b 0d 10 b7 04 08             mov    0x0804b710,%ecx
                     0x08049512 85 c9                         test   %ecx,%ecx
                     0x08049514 75 02                         jne    0x08049518 <code_INTERPRET+112>
                     0x08049516 ff 20                         jmp    *(%eax)
                     0x08049518 53                            push   %ebx
                     0x08049519 ad                            lods   %ds:(%esi),%eax
                     0x0804951a ff 20                         jmp    *(%eax)
                     0x0804951c bb 02 00 00 00                mov    $0x2,%ebx
                     0x08049521 b9 50 a6 04 08                mov    $0x0804a650,%ecx
                     0x08049526 ba 0d 00 00 00                mov    $0xd,%edx
                     0x0804952b b8 04 00 00 00                mov    $0x4,%eax
                     0x08049530 cd 80                         int    $0x80
                     0x08049532 8b 0d e4 b6 04 08             mov    0x0804b6e4,%ecx
                     0x08049538 89 ca                         mov    %ecx,%edx
                     0x0804953a 81 ea 00 e0 04 08             sub    $0x0804e000,%edx
                     0x08049540 83 fa 28                      cmp    $0x28,%edx
                     0x08049543 7e 05                         jle    0x0804954a <code_INTERPRET+162>
                     0x08049545 ba 28 00 00 00                mov    $0x28,%edx
                     0x0804954a 29 d1                         sub    %edx,%ecx
                     0x0804954c b8 04 00 00 00                mov    $0x4,%eax
                     0x08049551 cd 80                         int    $0x80
                     0x08049553 b9 5d a6 04 08                mov    $0x0804a65d,%ecx
                     0x08049558 ba 01 00 00 00                mov    $0x1,%edx
                     0x0804955d b8 04 00 00 00                mov    $0x4,%eax
                     0x08049562 cd 80                         int    $0x80
                     0x08049564 ad                            lods   %ds:(%esi),%eax
                     0x08049565 ff 20                         jmp    *(%eax)
code_CHAR            0x08049567 e8 b1 fd ff ff                call   0x0804931d <_WORD>
                     0x0804956c 31 c0                         xor    %eax,%eax
                     0x0804956e 8a 07                         mov    (%edi),%al
                     0x08049570 50                            push   %eax
                     0x08049571 ad                            lods   %ds:(%esi),%eax
                     0x08049572 ff 20                         jmp    *(%eax)
code_EXECUTE         0x08049574 58                            pop    %eax
                     0x08049575 ff 20                         jmp    *(%eax)
code_SYSCALL3        0x08049577 58                            pop    %eax
                     0x08049578 5b                            pop    %ebx
                     0x08049579 59                            pop    %ecx
                     0x0804957a 5a                            pop    %edx
                     0x0804957b cd 80                         int    $0x80
                     0x0804957d 50                            push   %eax
                     0x0804957e ad                            lods   %ds:(%esi),%eax
                     0x0804957f ff 20                         jmp    *(%eax)
code_SYSCALL2        0x08049581 58                            pop    %eax
                     0x08049582 5b                            pop    %ebx
                     0x08049583 59                            pop    %ecx
                     0x08049584 cd 80                         int    $0x80
                     0x08049586 50                            push   %eax
                     0x08049587 ad                            lods   %ds:(%esi),%eax
                     0x08049588 ff 20                         jmp    *(%eax)
code_SYSCALL1        0x0804958a 58                            pop    %eax
                     0x0804958b 5b                            pop    %ebx
                     0x0804958c cd 80                         int    $0x80
                     0x0804958e 50                            push   %eax
                     0x0804958f ad                            lods   %ds:(%esi),%eax
                     0x08049590 ff 20                         jmp    *(%eax)
code_SYSCALL0        0x08049592 58                            pop    %eax
                     0x08049593 cd 80                         int    $0x80
                     0x08049595 50                            push   %eax
                     0x08049596 ad                            lods   %ds:(%esi),%eax
                     0x08049597 ff 20                         jmp    *(%eax)
set_up_data_segment  0x08049599 31 db                         xor    %ebx,%ebx
                     0x0804959b b8 2d 00 00 00                mov    $0x2d,%eax
                     0x080495a0 cd 80                         int    $0x80
                     0x080495a2 a3 d4 b6 04 08                mov    %eax,0x0804b6d4
                     0x080495a7 05 00 00 01 00                add    $0x10000,%eax
                     0x080495ac 89 c3                         mov    %eax,%ebx
                     0x080495ae b8 2d 00 00 00                mov    $0x2d,%eax
                     0x080495b3 cd 80                         int    $0x80

.rodata
cold_start           0x0804a000 0x0804a624                     QUIT
name_DROP            0x0804a004 0x00000000
                     0x0804a008 0x4f524404
                     0x0804a00c 0x00000050
DROP                 0x0804a010 0x08049027                     code_DROP
name_SWAP            0x0804a014 0x0804a004                     name_DROP
                     0x0804a018 0x41575304
                     0x0804a01c 0x00000050
SWAP                 0x0804a020 0x0804902b                     code_SWAP
name_DUP             0x0804a024 0x0804a014                     name_SWAP
                     0x0804a028 0x50554403
DUP                  0x0804a02c 0x08049032                     code_DUP
name_OVER            0x0804a030 0x0804a024                     name_DUP
                     0x0804a034 0x45564f04
                     0x0804a038 0x00000052
OVER                 0x0804a03c 0x08049039                     code_OVER
name_ROT             0x0804a040 0x0804a030                     name_OVER
                     0x0804a044 0x544f5203
ROT                  0x0804a048 0x08049041                     code_ROT
name_NROT            0x0804a04c 0x0804a040                     name_ROT
                     0x0804a050 0x4f522d04
                     0x0804a054 0x00000054
NROT                 0x0804a058 0x0804904a                     code_NROT
name_TWODROP         0x0804a05c 0x0804a04c                     name_NROT
                     0x0804a060 0x52443205
                     0x0804a064 0x0000504f
TWODROP              0x0804a068 0x08049053                     code_TWODROP
name_TWODUP          0x0804a06c 0x0804a05c                     name_TWODROP
                     0x0804a070 0x55443204
                     0x0804a074 0x00000050
TWODUP               0x0804a078 0x08049058                     code_TWODUP
name_TWOSWAP         0x0804a07c 0x0804a06c                     name_TWODUP
                     0x0804a080 0x57533205
                     0x0804a084 0x00005041
TWOSWAP              0x0804a088 0x08049064                     code_TWOSWAP
name_QDUP            0x0804a08c 0x0804a07c                     name_TWOSWAP
                     0x0804a090 0x55443f04
                     0x0804a094 0x00000050
QDUP                 0x0804a098 0x0804906f                     code_QDUP
name_INCR            0x0804a09c 0x0804a08c                     name_QDUP
                     0x0804a0a0 0x002b3102
INCR                 0x0804a0a4 0x0804907a                     code_INCR
name_DECR            0x0804a0a8 0x0804a09c                     name_INCR
                     0x0804a0ac 0x002d3102
DECR                 0x0804a0b0 0x08049080                     code_DECR
name_INCR4           0x0804a0b4 0x0804a0a8                     name_DECR
                     0x0804a0b8 0x002b3402
INCR4                0x0804a0bc 0x08049086                     code_INCR4
name_DECR4           0x0804a0c0 0x0804a0b4                     name_INCR4
                     0x0804a0c4 0x002d3402
DECR4                0x0804a0c8 0x0804908d                     code_DECR4
name_ADD             0x0804a0cc 0x0804a0c0                     name_DECR4
                     0x0804a0d0 0x00002b01
ADD                  0x0804a0d4 0x08049094                     code_ADD
name_SUB             0x0804a0d8 0x0804a0cc                     name_ADD
                     0x0804a0dc 0x00002d01
SUB                  0x0804a0e0 0x0804909b                     code_SUB
name_MUL             0x0804a0e4 0x0804a0d8                     name_SUB
                     0x0804a0e8 0x00002a01
MUL                  0x0804a0ec 0x080490a2                     code_MUL
name_DIVMOD          0x0804a0f0 0x0804a0e4                     name_MUL
                     0x0804a0f4 0x4f4d2f04
                     0x0804a0f8 0x00000044
DIVMOD               0x0804a0fc 0x080490ab                     code_DIVMOD
name_EQU             0x0804a100 0x0804a0f0                     name_DIVMOD
                     0x0804a104 0x00003d01
EQU                  0x0804a108 0x080490b6                     code_EQU
name_NEQU            0x0804a10c 0x0804a100                     name_EQU
                     0x0804a110 0x003e3c02
NEQU                 0x0804a114 0x080490c4                     code_NEQU
name_LT              0x0804a118 0x0804a10c                     name_NEQU
                     0x0804a11c 0x00003c01
LT                   0x0804a120 0x080490d2                     code_LT
name_GT              0x0804a124 0x0804a118                     name_LT
                     0x0804a128 0x00003e01
GT                   0x0804a12c 0x080490e0                     code_GT
name_LE              0x0804a130 0x0804a124                     name_GT
                     0x0804a134 0x003d3c02
LE                   0x0804a138 0x080490ee                     code_LE
name_GE              0x0804a13c 0x0804a130                     name_LE
                     0x0804a140 0x003d3e02
GE                   0x0804a144 0x080490fc                     code_GE
name_ZEQU            0x0804a148 0x0804a13c                     name_GE
                     0x0804a14c 0x003d3002
ZEQU                 0x0804a150 0x0804910a                     code_ZEQU
name_ZNEQU           0x0804a154 0x0804a148                     name_ZEQU
                     0x0804a158 0x3e3c3003
ZNEQU                0x0804a15c 0x08049117                     code_ZNEQU
name_ZLT             0x0804a160 0x0804a154                     name_ZNEQU
                     0x0804a164 0x003c3002
ZLT                  0x0804a168 0x08049124                     code_ZLT
name_ZGT             0x0804a16c 0x0804a160                     name_ZLT
                     0x0804a170 0x003e3002
ZGT                  0x0804a174 0x08049131                     code_ZGT
name_ZLE             0x0804a178 0x0804a16c                     name_ZGT
                     0x0804a17c 0x3d3c3003
ZLE                  0x0804a180 0x0804913e                     code_ZLE
name_ZGE             0x0804a184 0x0804a178                     name_ZLE
                     0x0804a188 0x3d3e3003
ZGE                  0x0804a18c 0x0804914b                     code_ZGE
name_AND             0x0804a190 0x0804a184                     name_ZGE
                     0x0804a194 0x444e4103
AND                  0x0804a198 0x08049158                     code_AND
name_OR              0x0804a19c 0x0804a190                     name_AND
                     0x0804a1a0 0x00524f02
OR                   0x0804a1a4 0x0804915f                     code_OR
name_XOR             0x0804a1a8 0x0804a19c                     name_OR
                     0x0804a1ac 0x524f5803
XOR                  0x0804a1b0 0x08049166                     code_XOR
name_INVERT          0x0804a1b4 0x0804a1a8                     name_XOR
                     0x0804a1b8 0x564e4906
                     0x0804a1bc 0x00545245
INVERT               0x0804a1c0 0x0804916d                     code_INVERT
name_EXIT            0x0804a1c4 0x0804a1b4                     name_INVERT
                     0x0804a1c8 0x49584504
                     0x0804a1cc 0x00000054
EXIT                 0x0804a1d0 0x08049173                     code_EXIT
name_LIT             0x0804a1d4 0x0804a1c4                     name_EXIT
                     0x0804a1d8 0x54494c03
LIT                  0x0804a1dc 0x0804917c                     code_LIT
name_STORE           0x0804a1e0 0x0804a1d4                     name_LIT
                     0x0804a1e4 0x00002101
STORE                0x0804a1e8 0x08049181                     code_STORE
name_FETCH           0x0804a1ec 0x0804a1e0                     name_STORE
                     0x0804a1f0 0x00004001
FETCH                0x0804a1f4 0x08049188                     code_FETCH
name_ADDSTORE        0x0804a1f8 0x0804a1ec                     name_FETCH
                     0x0804a1fc 0x00212b02
ADDSTORE             0x0804a200 0x0804918f                     code_ADDSTORE
name_SUBSTORE        0x0804a204 0x0804a1f8                     name_ADDSTORE
                     0x0804a208 0x00212d02
SUBSTORE             0x0804a20c 0x08049196                     code_SUBSTORE
name_STOREBYTE       0x0804a210 0x0804a204                     name_SUBSTORE
                     0x0804a214 0x00214302
STOREBYTE            0x0804a218 0x0804919d                     code_STOREBYTE
name_FETCHBYTE       0x0804a21c 0x0804a210                     name_STOREBYTE
                     0x0804a220 0x00404302
FETCHBYTE            0x0804a224 0x080491a4                     code_FETCHBYTE
name_CCOPY           0x0804a228 0x0804a21c                     name_FETCHBYTE
                     0x0804a22c 0x43404304
                     0x0804a230 0x00000021
CCOPY                0x0804a234 0x080491ad                     code_CCOPY
name_CMOVE           0x0804a238 0x0804a228                     name_CCOPY
                     0x0804a23c 0x4f4d4305
                     0x0804a240 0x00004556
CMOVE                0x0804a244 0x080491bd                     code_CMOVE
name_STATE           0x0804a248 0x0804a238                     name_CMOVE
                     0x0804a24c 0x41545305
                     0x0804a250 0x00004554
STATE                0x0804a254 0x080491c9                     code_STATE
name_HERE            0x0804a258 0x0804a248                     name_STATE
                     0x0804a25c 0x52454804
                     0x0804a260 0x00000045
HERE                 0x0804a264 0x080491d1                     code_HERE
name_LATEST          0x0804a268 0x0804a258                     name_HERE
                     0x0804a26c 0x54414c06
                     0x0804a270 0x00545345
LATEST               0x0804a274 0x080491d9                     code_LATEST
name_SZ              0x0804a278 0x0804a268                     name_LATEST
                     0x0804a27c 0x00305302
SZ                   0x0804a280 0x080491e1                     code_SZ
name_BASE            0x0804a284 0x0804a278                     name_SZ
                     0x0804a288 0x53414204
                     0x0804a28c 0x00000045
BASE                 0x0804a290 0x080491e9                     code_BASE
name_VERSION         0x0804a294 0x0804a284                     name_BASE
                     0x0804a298 0x52455607
                     0x0804a29c 0x4e4f4953
VERSION              0x0804a2a0 0x080491f1                     code_VERSION
name_RZ              0x0804a2a4 0x0804a294                     name_VERSION
                     0x0804a2a8 0x00305202
RZ                   0x0804a2ac 0x080491f6                     code_RZ
name___DOCOL         0x0804a2b0 0x0804a2a4                     name_RZ
                     0x0804a2b4 0x434f4405
                     0x0804a2b8 0x00004c4f
__DOCOL              0x0804a2bc 0x080491fe                     code___DOCOL
name___F_IMMED       0x0804a2c0 0x0804a2b0                     name___DOCOL
                     0x0804a2c4 0x495f4607
                     0x0804a2c8 0x44454d4d
__F_IMMED            0x0804a2cc 0x08049206                     code___F_IMMED
name___F_HIDDEN      0x0804a2d0 0x0804a2c0                     name___F_IMMED
                     0x0804a2d4 0x485f4608
                     0x0804a2d8 0x45444449
                     0x0804a2dc 0x0000004e
__F_HIDDEN           0x0804a2e0 0x0804920e                     code___F_HIDDEN
name___F_LENMASK     0x0804a2e4 0x0804a2d0                     name___F_HIDDEN
                     0x0804a2e8 0x4c5f4609
                     0x0804a2ec 0x414d4e45
                     0x0804a2f0 0x00004b53
__F_LENMASK          0x0804a2f4 0x08049213                     code___F_LENMASK
name_SYS_EXIT        0x0804a2f8 0x0804a2e4                     name___F_LENMASK
                     0x0804a2fc 0x53595308
                     0x0804a300 0x4958455f
                     0x0804a304 0x00000054
SYS_EXIT             0x0804a308 0x08049218                     code_SYS_EXIT
name_SYS_OPEN        0x0804a30c 0x0804a2f8                     name_SYS_EXIT
                     0x0804a310 0x53595308
                     0x0804a314 0x45504f5f
                     0x0804a318 0x0000004e
SYS_OPEN             0x0804a31c 0x0804921d                     code_SYS_OPEN
name_SYS_CLOSE       0x0804a320 0x0804a30c                     name_SYS_OPEN
                     0x0804a324 0x53595309
                     0x0804a328 0x4f4c435f
                     0x0804a32c 0x00004553
SYS_CLOSE            0x0804a330 0x08049222                     code_SYS_CLOSE
name_SYS_READ        0x0804a334 0x0804a320                     name_SYS_CLOSE
                     0x0804a338 0x53595308
                     0x0804a33c 0x4145525f
                     0x0804a340 0x00000044
SYS_READ             0x0804a344 0x08049227                     code_SYS_READ
name_SYS_WRITE       0x0804a348 0x0804a334                     name_SYS_READ
                     0x0804a34c 0x53595309
                     0x0804a350 0x4952575f
                     0x0804a354 0x00004554
SYS_WRITE            0x0804a358 0x0804922c                     code_SYS_WRITE
name_SYS_CREAT       0x0804a35c 0x0804a348                     name_SYS_WRITE
                     0x0804a360 0x53595309
                     0x0804a364 0x4552435f
                     0x0804a368 0x00005441
SYS_CREAT            0x0804a36c 0x08049231                     code_SYS_CREAT
name_SYS_BRK         0x0804a370 0x0804a35c                     name_SYS_CREAT
                     0x0804a374 0x53595307
                     0x0804a378 0x4b52425f
SYS_BRK              0x0804a37c 0x08049236                     code_SYS_BRK
name___O_RDONLY      0x0804a380 0x0804a370                     name_SYS_BRK
                     0x0804a384 0x525f4f08
                     0x0804a388 0x4c4e4f44
                     0x0804a38c 0x00000059
__O_RDONLY           0x0804a390 0x0804923b                     code___O_RDONLY
name___O_WRONLY      0x0804a394 0x0804a380                     name___O_RDONLY
                     0x0804a398 0x575f4f08
                     0x0804a39c 0x4c4e4f52
                     0x0804a3a0 0x00000059
__O_WRONLY           0x0804a3a4 0x08049240                     code___O_WRONLY
name___O_RDWR        0x0804a3a8 0x0804a394                     name___O_WRONLY
                     0x0804a3ac 0x525f4f06
                     0x0804a3b0 0x00525744
__O_RDWR             0x0804a3b4 0x08049245                     code___O_RDWR
name___O_CREAT       0x0804a3b8 0x0804a3a8                     name___O_RDWR
                     0x0804a3bc 0x435f4f07
                     0x0804a3c0 0x54414552
__O_CREAT            0x0804a3c4 0x0804924a                     code___O_CREAT
name___O_EXCL        0x0804a3c8 0x0804a3b8                     name___O_CREAT
                     0x0804a3cc 0x455f4f06
                     0x0804a3d0 0x004c4358
__O_EXCL             0x0804a3d4 0x0804924f                     code___O_EXCL
name___O_TRUNC       0x0804a3d8 0x0804a3c8                     name___O_EXCL
                     0x0804a3dc 0x545f4f07
                     0x0804a3e0 0x434e5552
__O_TRUNC            0x0804a3e4 0x08049257                     code___O_TRUNC
name___O_APPEND      0x0804a3e8 0x0804a3d8                     name___O_TRUNC
                     0x0804a3ec 0x415f4f08
                     0x0804a3f0 0x4e455050
                     0x0804a3f4 0x00000044
__O_APPEND           0x0804a3f8 0x0804925f                     code___O_APPEND
name___O_NONBLOCK    0x0804a3fc 0x0804a3e8                     name___O_APPEND
                     0x0804a400 0x4e5f4f0a
                     0x0804a404 0x4c424e4f
                     0x0804a408 0x004b434f
__O_NONBLOCK         0x0804a40c 0x08049267                     code___O_NONBLOCK
name_TOR             0x0804a410 0x0804a3fc                     name___O_NONBLOCK
                     0x0804a414 0x00523e02
TOR                  0x0804a418 0x0804926f                     code_TOR
name_FROMR           0x0804a41c 0x0804a410                     name_TOR
                     0x0804a420 0x003e5202
FROMR                0x0804a424 0x08049279                     code_FROMR
name_RSPFETCH        0x0804a428 0x0804a41c                     name_FROMR
                     0x0804a42c 0x50535204
                     0x0804a430 0x00000040
RSPFETCH             0x0804a434 0x08049283                     code_RSPFETCH
name_RSPSTORE        0x0804a438 0x0804a428                     name_RSPFETCH
                     0x0804a43c 0x50535204
                     0x0804a440 0x00000021
RSPSTORE             0x0804a444 0x08049287                     code_RSPSTORE
name_RDROP           0x0804a448 0x0804a438                     name_RSPSTORE
                     0x0804a44c 0x52445205
                     0x0804a450 0x0000504f
RDROP                0x0804a454 0x0804928b                     code_RDROP
name_DSPFETCH        0x0804a458 0x0804a448                     name_RDROP
                     0x0804a45c 0x50534404
                     0x0804a460 0x00000040
DSPFETCH             0x0804a464 0x08049291                     code_DSPFETCH
name_DSPSTORE        0x0804a468 0x0804a458                     name_DSPFETCH
                     0x0804a46c 0x50534404
                     0x0804a470 0x00000021
DSPSTORE             0x0804a474 0x08049297                     code_DSPSTORE
name_KEY             0x0804a478 0x0804a468                     name_DSPSTORE
                     0x0804a47c 0x59454b03
KEY                  0x0804a480 0x0804929b                     code_KEY
name_EMIT            0x0804a484 0x0804a478                     name_KEY
                     0x0804a488 0x494d4504
                     0x0804a48c 0x00000054
EMIT                 0x0804a490 0x080492ee                     code_EMIT
name_WORD            0x0804a494 0x0804a484                     name_EMIT
                     0x0804a498 0x524f5704
                     0x0804a49c 0x00000044
WORD                 0x0804a4a0 0x08049313                     code_WORD
name_NUMBER          0x0804a4a4 0x0804a494                     name_WORD
                     0x0804a4a8 0x4d554e06
                     0x0804a4ac 0x00524542
NUMBER               0x0804a4b0 0x08049352                     code_NUMBER
name_FIND            0x0804a4b4 0x0804a4a4                     name_NUMBER
                     0x0804a4b8 0x4e494604
                     0x0804a4bc 0x00000044
FIND                 0x0804a4c0 0x080493aa                     code_FIND
name_TCFA            0x0804a4c4 0x0804a4b4                     name_FIND
                     0x0804a4c8 0x46433e04
                     0x0804a4cc 0x00000041
TCFA                 0x0804a4d0 0x080493e2                     code_TCFA
name_TDFA            0x0804a4d4 0x0804a4c4                     name_TCFA
                     0x0804a4d8 0x46443e04
                     0x0804a4dc 0x00000041
TDFA                 0x0804a4e0 0x08049000                     DOCOL
                     0x0804a4e4 0x0804a4d0                     TCFA
                     0x0804a4e8 0x0804a0bc                     INCR4
                     0x0804a4ec 0x0804a1d0                     EXIT
name_CREATE          0x0804a4f0 0x0804a4d4                     name_TDFA
                     0x0804a4f4 0x45524306
                     0x0804a4f8 0x00455441
CREATE               0x0804a4fc 0x080493ff                     code_CREATE
name_COMMA           0x0804a500 0x0804a4f0                     name_CREATE
                     0x0804a504 0x00002c01
COMMA                0x0804a508 0x0804942f                     code_COMMA
name_LBRAC           0x0804a50c 0x0804a500                     name_COMMA
                     0x0804a510 0x00005b81
LBRAC                0x0804a514 0x08049446                     code_LBRAC
name_RBRAC           0x0804a518 0x0804a50c                     name_LBRAC
                     0x0804a51c 0x00005d01
RBRAC                0x0804a520 0x08049450                     code_RBRAC
name_COLON           0x0804a524 0x0804a518                     name_RBRAC
                     0x0804a528 0x00003a01
COLON                0x0804a52c 0x08049000                     DOCOL
                     0x0804a530 0x0804a4a0                     WORD
                     0x0804a534 0x0804a4fc                     CREATE
                     0x0804a538 0x0804a1dc                     LIT
                     0x0804a53c 0x08049000                     DOCOL
                     0x0804a540 0x0804a508                     COMMA
                     0x0804a544 0x0804a274                     LATEST
                     0x0804a548 0x0804a1f4                     FETCH
                     0x0804a54c 0x0804a5a4                     HIDDEN
                     0x0804a550 0x0804a520                     RBRAC
                     0x0804a554 0x0804a1d0                     EXIT
name_SEMICOLON       0x0804a558 0x0804a524                     name_COLON
                     0x0804a55c 0x00003b81
SEMICOLON            0x0804a560 0x08049000                     DOCOL
                     0x0804a564 0x0804a1dc                     LIT
                     0x0804a568 0x0804a1d0                     EXIT
                     0x0804a56c 0x0804a508                     COMMA
                     0x0804a570 0x0804a274                     LATEST
                     0x0804a574 0x0804a1f4                     FETCH
                     0x0804a578 0x0804a5a4                     HIDDEN
                     0x0804a57c 0x0804a514                     LBRAC
                     0x0804a580 0x0804a1d0                     EXIT
name_IMMEDIATE       0x0804a584 0x0804a558                     name_SEMICOLON
                     0x0804a588 0x4d4d4989
                     0x0804a58c 0x41494445
                     0x0804a590 0x00004554
IMMEDIATE            0x0804a594 0x0804945d                     code_IMMEDIATE
name_HIDDEN          0x0804a598 0x0804a584                     name_IMMEDIATE
                     0x0804a59c 0x44494806
                     0x0804a5a0 0x004e4544
HIDDEN               0x0804a5a4 0x0804946c                     code_HIDDEN
name_HIDE            0x0804a5a8 0x0804a598                     name_HIDDEN
                     0x0804a5ac 0x44494804
                     0x0804a5b0 0x00000045
HIDE                 0x0804a5b4 0x08049000                     DOCOL
                     0x0804a5b8 0x0804a4a0                     WORD
                     0x0804a5bc 0x0804a4c0                     FIND
                     0x0804a5c0 0x0804a5a4                     HIDDEN
                     0x0804a5c4 0x0804a1d0                     EXIT
name_TICK            0x0804a5c8 0x0804a5a8                     name_HIDE
                     0x0804a5cc 0x00002701
TICK                 0x0804a5d0 0x08049476                     code_TICK
name_BRANCH          0x0804a5d4 0x0804a5c8                     name_TICK
                     0x0804a5d8 0x41524206
                     0x0804a5dc 0x0048434e
BRANCH               0x0804a5e0 0x0804947b                     code_BRANCH
name_ZBRANCH         0x0804a5e4 0x0804a5d4                     name_BRANCH
                     0x0804a5e8 0x52423007
                     0x0804a5ec 0x48434e41
ZBRANCH              0x0804a5f0 0x08049480                     code_ZBRANCH
name_LITSTRING       0x0804a5f4 0x0804a5e4                     name_ZBRANCH
                     0x0804a5f8 0x54494c09
                     0x0804a5fc 0x49525453
                     0x0804a600 0x0000474e
LITSTRING            0x0804a604 0x08049489                     code_LITSTRING
name_TELL            0x0804a608 0x0804a5f4                     name_LITSTRING
                     0x0804a60c 0x4c455404
                     0x0804a610 0x0000004c
TELL                 0x0804a614 0x08049497                     code_TELL
name_QUIT            0x0804a618 0x0804a608                     name_TELL
                     0x0804a61c 0x49555104
                     0x0804a620 0x00000054
QUIT                 0x0804a624 0x08049000                     DOCOL
                     0x0804a628 0x0804a2ac                     RZ
                     0x0804a62c 0x0804a444                     RSPSTORE
                     0x0804a630 0x0804a64c                     INTERPRET
                     0x0804a634 0x0804a5e0                     BRANCH
                     0x0804a638 0xfffffff8
name_INTERPRET       0x0804a63c 0x0804a618                     name_QUIT
                     0x0804a640 0x544e4909
                     0x0804a644 0x52505245
                     0x0804a648 0x00005445
INTERPRET            0x0804a64c 0x080494a8                     code_INTERPRET
errmsg               0x0804a650 0x53524150
                     0x0804a654 0x52452045
                     0x0804a658 0x3a524f52
                     0x0804a65c 0x00000a20
name_CHAR            0x0804a660 0x0804a63c                     name_INTERPRET
                     0x0804a664 0x41484304
                     0x0804a668 0x00000052
CHAR                 0x0804a66c 0x08049567                     code_CHAR
name_EXECUTE         0x0804a670 0x0804a660                     name_CHAR
                     0x0804a674 0x45584507
                     0x0804a678 0x45545543
EXECUTE              0x0804a67c 0x08049574                     code_EXECUTE
name_SYSCALL3        0x0804a680 0x0804a670                     name_EXECUTE
                     0x0804a684 0x53595308
                     0x0804a688 0x4c4c4143
                     0x0804a68c 0x00000033
SYSCALL3             0x0804a690 0x08049577                     code_SYSCALL3
name_SYSCALL2        0x0804a694 0x0804a680                     name_SYSCALL3
                     0x0804a698 0x53595308
                     0x0804a69c 0x4c4c4143
                     0x0804a6a0 0x00000032
SYSCALL2             0x0804a6a4 0x08049581                     code_SYSCALL2
name_SYSCALL1        0x0804a6a8 0x0804a694                     name_SYSCALL2
                     0x0804a6ac 0x53595308
                     0x0804a6b0 0x4c4c4143
                     0x0804a6b4 0x00000031
SYSCALL1             0x0804a6b8 0x0804958a                     code_SYSCALL1
name_SYSCALL0        0x0804a6bc 0x0804a6a8                     name_SYSCALL1
                     0x0804a6c0 0x53595308
                     0x0804a6c4 0x4c4c4143
                     0x0804a6c8 0x00000030
SYSCALL0             0x0804a6cc 0x08049592                     code_SYSCALL0

# Single Stepping 
``` 
--------------------
566		mov %esp,var_S0		// Save the initial data stack pointer in FORTH variable S0.

$pc         x/i $pc$eax 0x00000000
$esi 0x00000000
$esp         x/4dw $esp--------------------
567		mov $return_stack_top,%ebp // Initialise the return stack.

$pc         x/i $pc$eax 0x00000000
$esi 0x00000000
$esp         x/4dw $esp--------------------
_start () at jonesforth.S:568
568		call set_up_data_segment

$pc         x/i $pc$eax 0x00000000
$esi 0x00000000
$esp         x/4dw $esp--------------------
set_up_data_segment () at jonesforth.S:2267
2267		xor %ebx,%ebx		// Call brk(0)

$pc         x/i $pc$eax 0x00000000
$esi 0x00000000
$esp         x/4dw $esp--------------------
2268		movl $__NR_brk,%eax

$pc         x/i $pc$eax 0x00000000
$esi 0x00000000
$esp         x/4dw $esp--------------------
2269		int $0x80

$pc         x/i $pc$eax 0x0000002d
$esi 0x00000000
$esp         x/4dw $esp--------------------
2270		movl %eax,var_HERE	// Initialise HERE to point at beginning of data segment.

$pc         x/i $pc$eax 0x0804f000
$esi 0x00000000
$esp         x/4dw $esp--------------------
2271		addl $INITIAL_DATA_SEGMENT_SIZE,%eax	// Reserve nn bytes of memory for initial data segment.

$pc         x/i $pc$eax 0x0804f000
$esi 0x00000000
$esp         x/4dw $esp--------------------
2272		movl %eax,%ebx		// Call brk(HERE+INITIAL_DATA_SEGMENT_SIZE)

$pc         x/i $pc$eax 0x0805f000
$esi 0x00000000
$esp         x/4dw $esp--------------------
2273		movl $__NR_brk,%eax

$pc         x/i $pc$eax 0x0805f000
$esi 0x00000000
$esp         x/4dw $esp--------------------
2274		int $0x80

$pc         x/i $pc$eax 0x0000002d
$esi 0x00000000
$esp         x/4dw $esp--------------------
2275		ret

$pc         x/i $pc$eax 0x0805f000
$esi 0x00000000
$esp         x/4dw $esp--------------------
_start () at jonesforth.S:570
570		mov $cold_start,%esi	// Initialise interpreter.

$pc         x/i $pc$eax 0x0805f000
$esi 0x00000000
$esp         x/4dw $esp--------------------
571		NEXT			// Run interpreter!

$pc         x/i $pc$eax 0x0805f000
$esi 0x0804a000  cold_start
$esp         x/4dw $esp--------------------
0x08049025	571		NEXT			// Run interpreter!

$pc         x/i $pc$eax 0x0804a624  QUIT
$esi 0x0804a004  name_DROP
$esp         x/4dw $esp--------------------
DOCOL () at jonesforth.S:500
500		PUSHRSP %esi		// push %esi on to the return stack

$pc         x/i $pc$eax 0x0804a624  QUIT
$esi 0x0804a004  name_DROP
$esp         x/4dw $esp--------------------
0x08049003	500		PUSHRSP %esi		// push %esi on to the return stack

$pc         x/i $pc$eax 0x0804a624  QUIT
$esi 0x0804a004  name_DROP
$esp         x/4dw $esp--------------------
501		addl $4,%eax		// %eax points to codeword, so make

$pc         x/i $pc$eax 0x0804a624  QUIT
$esi 0x0804a004  name_DROP
$esp         x/4dw $esp--------------------
502		movl %eax,%esi		// %esi point to first data word

$pc         x/i $pc$eax 0x0804a628  QUIT + 4
$esi 0x0804a004  name_DROP
$esp         x/4dw $esp--------------------
503		NEXT

$pc         x/i $pc$eax 0x0804a628  QUIT + 4
$esi 0x0804a628  QUIT + 4
$esp         x/4dw $esp--------------------
0x0804900c	503		NEXT

$pc         x/i $pc$eax 0x0804a2ac  RZ
$esi 0x0804a62c  QUIT + 8
$esp         x/4dw $esp--------------------
code_RZ () at jonesforth.S:1161
1161		defconst "R0",2,,RZ,return_stack_top

$pc         x/i $pc$eax 0x0804a2ac  RZ
$esi 0x0804a62c  QUIT + 8
$esp         x/4dw $esp--------------------
0x080491fb in code_RZ () at jonesforth.S:1161
1161		defconst "R0",2,,RZ,return_stack_top

$pc         x/i $pc$eax 0x0804a2ac  RZ
$esi 0x0804a62c  QUIT + 8
$esp         x/4dw $esp--------------------
0x080491fc	1161		defconst "R0",2,,RZ,return_stack_top

$pc         x/i $pc$eax 0x0804a444  RSPSTORE
$esi 0x0804a630  QUIT + 12
$esp         x/4dw $esp--------------------
code_RSPSTORE () at jonesforth.S:1206
1206		pop %ebp

$pc         x/i $pc$eax 0x0804a444  RSPSTORE
$esi 0x0804a630  QUIT + 12
$esp         x/4dw $esp--------------------
code_RSPSTORE () at jonesforth.S:1207
1207		NEXT

$pc         x/i $pc$eax 0x0804a444  RSPSTORE
$esi 0x0804a630  QUIT + 12
$esp         x/4dw $esp--------------------
0x08049289	1207		NEXT

$pc         x/i $pc$eax 0x0804a64c  INTERPRET
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
code_INTERPRET () at jonesforth.S:2089
2089		call _WORD		// Returns %ecx = length, %edi = pointer to word.

$pc         x/i $pc$eax 0x0804a64c  INTERPRET
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_WORD () at jonesforth.S:1371
1371		call _KEY		// get next key, returned in %eax

$pc         x/i $pc$eax 0x0804a64c  INTERPRET
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_KEY () at jonesforth.S:1272
1272		mov (currkey),%ebx

$pc         x/i $pc$eax 0x0804a64c  INTERPRET
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1273		cmp (bufftop),%ebx

$pc         x/i $pc$eax 0x0804a64c  INTERPRET
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1274		jge 1f			// exhausted the input buffer?

$pc         x/i $pc$eax 0x0804a64c  INTERPRET
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1282		xor %ebx,%ebx		// 1st param: stdin

$pc         x/i $pc$eax 0x0804a64c  INTERPRET
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1283		mov $buffer,%ecx	// 2nd param: buffer

$pc         x/i $pc$eax 0x0804a64c  INTERPRET
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1284		mov %ecx,currkey

$pc         x/i $pc$eax 0x0804a64c  INTERPRET
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1285		mov $BUFFER_SIZE,%edx	// 3rd param: max length

$pc         x/i $pc$eax 0x0804a64c  INTERPRET
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1286		mov $__NR_read,%eax	// syscall: read

$pc         x/i $pc$eax 0x0804a64c  INTERPRET
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1287		int $0x80

$pc         x/i $pc$eax 0x00000003
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1288		test %eax,%eax		// If %eax <= 0, then exit.

$pc         x/i $pc$eax 0x00001000
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1289		jbe 2f

$pc         x/i $pc$eax 0x00001000
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1290		addl %eax,%ecx		// buffer+%eax = bufftop

$pc         x/i $pc$eax 0x00001000
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1291		mov %ecx,bufftop

$pc         x/i $pc$eax 0x00001000
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1292		jmp _KEY

$pc         x/i $pc$eax 0x00001000
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1272		mov (currkey),%ebx

$pc         x/i $pc$eax 0x00001000
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1273		cmp (bufftop),%ebx

$pc         x/i $pc$eax 0x00001000
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1274		jge 1f			// exhausted the input buffer?

$pc         x/i $pc$eax 0x00001000
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1275		xor %eax,%eax

$pc         x/i $pc$eax 0x00001000
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1276		mov (%ebx),%al		// get next key from input buffer

$pc         x/i $pc$eax 0x00000000
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1277		inc %ebx

$pc         x/i $pc$eax 0x0000005c
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1278		mov %ebx,(currkey)	// increment currkey

$pc         x/i $pc$eax 0x0000005c
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1279		ret

$pc         x/i $pc$eax 0x0000005c
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_WORD () at jonesforth.S:1372
1372		cmpb $'\\',%al		// start of a comment?

$pc         x/i $pc$eax 0x0000005c
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1373		je 3f			// if so, skip the comment

$pc         x/i $pc$eax 0x0000005c
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1393		call _KEY

$pc         x/i $pc$eax 0x0000005c
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_KEY () at jonesforth.S:1272
1272		mov (currkey),%ebx

$pc         x/i $pc$eax 0x0000005c
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1273		cmp (bufftop),%ebx

$pc         x/i $pc$eax 0x0000005c
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1274		jge 1f			// exhausted the input buffer?

$pc         x/i $pc$eax 0x0000005c
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1275		xor %eax,%eax

$pc         x/i $pc$eax 0x0000005c
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1276		mov (%ebx),%al		// get next key from input buffer

$pc         x/i $pc$eax 0x00000000
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1277		inc %ebx

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1278		mov %ebx,(currkey)	// increment currkey

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1279		ret

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_WORD () at jonesforth.S:1394
1394		cmpb $'\n',%al		// end of line yet?

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1395		jne 3b

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1393		call _KEY

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_KEY () at jonesforth.S:1272
1272		mov (currkey),%ebx

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1273		cmp (bufftop),%ebx

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1274		jge 1f			// exhausted the input buffer?

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1275		xor %eax,%eax

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1276		mov (%ebx),%al		// get next key from input buffer

$pc         x/i $pc$eax 0x00000000
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1277		inc %ebx

$pc         x/i $pc$eax 0x0000002d
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1278		mov %ebx,(currkey)	// increment currkey

$pc         x/i $pc$eax 0x0000002d
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1279		ret

$pc         x/i $pc$eax 0x0000002d
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_WORD () at jonesforth.S:1394
1394		cmpb $'\n',%al		// end of line yet?

$pc         x/i $pc$eax 0x0000002d
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1395		jne 3b

$pc         x/i $pc$eax 0x0000002d
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1393		call _KEY

$pc         x/i $pc$eax 0x0000002d
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_KEY () at jonesforth.S:1272
1272		mov (currkey),%ebx

$pc         x/i $pc$eax 0x0000002d
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1273		cmp (bufftop),%ebx

$pc         x/i $pc$eax 0x0000002d
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1274		jge 1f			// exhausted the input buffer?

$pc         x/i $pc$eax 0x0000002d
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1275		xor %eax,%eax

$pc         x/i $pc$eax 0x0000002d
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1276		mov (%ebx),%al		// get next key from input buffer

$pc         x/i $pc$eax 0x00000000
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1277		inc %ebx

$pc         x/i $pc$eax 0x0000002a
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1278		mov %ebx,(currkey)	// increment currkey

$pc         x/i $pc$eax 0x0000002a
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1279		ret

$pc         x/i $pc$eax 0x0000002a
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_WORD () at jonesforth.S:1394
1394		cmpb $'\n',%al		// end of line yet?

$pc         x/i $pc$eax 0x0000002a
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1395		jne 3b

$pc         x/i $pc$eax 0x0000002a
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1393		call _KEY

$pc         x/i $pc$eax 0x0000002a
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_KEY () at jonesforth.S:1272
1272		mov (currkey),%ebx

$pc         x/i $pc$eax 0x0000002a
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1273		cmp (bufftop),%ebx

$pc         x/i $pc$eax 0x0000002a
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1274		jge 1f			// exhausted the input buffer?

$pc         x/i $pc$eax 0x0000002a
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1275		xor %eax,%eax

$pc         x/i $pc$eax 0x0000002a
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1276		mov (%ebx),%al		// get next key from input buffer

$pc         x/i $pc$eax 0x00000000
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1277		inc %ebx

$pc         x/i $pc$eax 0x0000002d
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1278		mov %ebx,(currkey)	// increment currkey

$pc         x/i $pc$eax 0x0000002d
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1279		ret

$pc         x/i $pc$eax 0x0000002d
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_WORD () at jonesforth.S:1394
1394		cmpb $'\n',%al		// end of line yet?

$pc         x/i $pc$eax 0x0000002d
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1395		jne 3b

$pc         x/i $pc$eax 0x0000002d
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1393		call _KEY

$pc         x/i $pc$eax 0x0000002d
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_KEY () at jonesforth.S:1272
1272		mov (currkey),%ebx

$pc         x/i $pc$eax 0x0000002d
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1273		cmp (bufftop),%ebx

$pc         x/i $pc$eax 0x0000002d
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1274		jge 1f			// exhausted the input buffer?

$pc         x/i $pc$eax 0x0000002d
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1275		xor %eax,%eax

$pc         x/i $pc$eax 0x0000002d
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1276		mov (%ebx),%al		// get next key from input buffer

$pc         x/i $pc$eax 0x00000000
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1277		inc %ebx

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1278		mov %ebx,(currkey)	// increment currkey

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1279		ret

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_WORD () at jonesforth.S:1394
1394		cmpb $'\n',%al		// end of line yet?

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1395		jne 3b

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1393		call _KEY

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_KEY () at jonesforth.S:1272
1272		mov (currkey),%ebx

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1273		cmp (bufftop),%ebx

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1274		jge 1f			// exhausted the input buffer?

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1275		xor %eax,%eax

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1276		mov (%ebx),%al		// get next key from input buffer

$pc         x/i $pc$eax 0x00000000
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1277		inc %ebx

$pc         x/i $pc$eax 0x00000074
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1278		mov %ebx,(currkey)	// increment currkey

$pc         x/i $pc$eax 0x00000074
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1279		ret

$pc         x/i $pc$eax 0x00000074
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_WORD () at jonesforth.S:1394
1394		cmpb $'\n',%al		// end of line yet?

$pc         x/i $pc$eax 0x00000074
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1395		jne 3b

$pc         x/i $pc$eax 0x00000074
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1393		call _KEY

$pc         x/i $pc$eax 0x00000074
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_KEY () at jonesforth.S:1272
1272		mov (currkey),%ebx

$pc         x/i $pc$eax 0x00000074
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1273		cmp (bufftop),%ebx

$pc         x/i $pc$eax 0x00000074
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1274		jge 1f			// exhausted the input buffer?

$pc         x/i $pc$eax 0x00000074
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1275		xor %eax,%eax

$pc         x/i $pc$eax 0x00000074
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1276		mov (%ebx),%al		// get next key from input buffer

$pc         x/i $pc$eax 0x00000000
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1277		inc %ebx

$pc         x/i $pc$eax 0x00000065
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1278		mov %ebx,(currkey)	// increment currkey

$pc         x/i $pc$eax 0x00000065
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1279		ret

$pc         x/i $pc$eax 0x00000065
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_WORD () at jonesforth.S:1394
1394		cmpb $'\n',%al		// end of line yet?

$pc         x/i $pc$eax 0x00000065
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1395		jne 3b

$pc         x/i $pc$eax 0x00000065
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1393		call _KEY

$pc         x/i $pc$eax 0x00000065
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_KEY () at jonesforth.S:1272
1272		mov (currkey),%ebx

$pc         x/i $pc$eax 0x00000065
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1273		cmp (bufftop),%ebx

$pc         x/i $pc$eax 0x00000065
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1274		jge 1f			// exhausted the input buffer?

$pc         x/i $pc$eax 0x00000065
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1275		xor %eax,%eax

$pc         x/i $pc$eax 0x00000065
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1276		mov (%ebx),%al		// get next key from input buffer

$pc         x/i $pc$eax 0x00000000
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1277		inc %ebx

$pc         x/i $pc$eax 0x00000078
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1278		mov %ebx,(currkey)	// increment currkey

$pc         x/i $pc$eax 0x00000078
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1279		ret

$pc         x/i $pc$eax 0x00000078
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_WORD () at jonesforth.S:1394
1394		cmpb $'\n',%al		// end of line yet?

$pc         x/i $pc$eax 0x00000078
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1395		jne 3b

$pc         x/i $pc$eax 0x00000078
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1393		call _KEY

$pc         x/i $pc$eax 0x00000078
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_KEY () at jonesforth.S:1272
1272		mov (currkey),%ebx

$pc         x/i $pc$eax 0x00000078
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1273		cmp (bufftop),%ebx

$pc         x/i $pc$eax 0x00000078
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1274		jge 1f			// exhausted the input buffer?

$pc         x/i $pc$eax 0x00000078
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1275		xor %eax,%eax

$pc         x/i $pc$eax 0x00000078
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1276		mov (%ebx),%al		// get next key from input buffer

$pc         x/i $pc$eax 0x00000000
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1277		inc %ebx

$pc         x/i $pc$eax 0x00000074
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1278		mov %ebx,(currkey)	// increment currkey

$pc         x/i $pc$eax 0x00000074
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1279		ret

$pc         x/i $pc$eax 0x00000074
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_WORD () at jonesforth.S:1394
1394		cmpb $'\n',%al		// end of line yet?

$pc         x/i $pc$eax 0x00000074
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1395		jne 3b

$pc         x/i $pc$eax 0x00000074
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1393		call _KEY

$pc         x/i $pc$eax 0x00000074
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_KEY () at jonesforth.S:1272
1272		mov (currkey),%ebx

$pc         x/i $pc$eax 0x00000074
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1273		cmp (bufftop),%ebx

$pc         x/i $pc$eax 0x00000074
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1274		jge 1f			// exhausted the input buffer?

$pc         x/i $pc$eax 0x00000074
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1275		xor %eax,%eax

$pc         x/i $pc$eax 0x00000074
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1276		mov (%ebx),%al		// get next key from input buffer

$pc         x/i $pc$eax 0x00000000
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1277		inc %ebx

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1278		mov %ebx,(currkey)	// increment currkey

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1279		ret

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_WORD () at jonesforth.S:1394
1394		cmpb $'\n',%al		// end of line yet?

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1395		jne 3b

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1393		call _KEY

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_KEY () at jonesforth.S:1272
1272		mov (currkey),%ebx

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1273		cmp (bufftop),%ebx

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1274		jge 1f			// exhausted the input buffer?

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1275		xor %eax,%eax

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1276		mov (%ebx),%al		// get next key from input buffer

$pc         x/i $pc$eax 0x00000000
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1277		inc %ebx

$pc         x/i $pc$eax 0x0000002d
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1278		mov %ebx,(currkey)	// increment currkey

$pc         x/i $pc$eax 0x0000002d
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1279		ret

$pc         x/i $pc$eax 0x0000002d
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_WORD () at jonesforth.S:1394
1394		cmpb $'\n',%al		// end of line yet?

$pc         x/i $pc$eax 0x0000002d
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1395		jne 3b

$pc         x/i $pc$eax 0x0000002d
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1393		call _KEY

$pc         x/i $pc$eax 0x0000002d
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_KEY () at jonesforth.S:1272
1272		mov (currkey),%ebx

$pc         x/i $pc$eax 0x0000002d
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1273		cmp (bufftop),%ebx

$pc         x/i $pc$eax 0x0000002d
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1274		jge 1f			// exhausted the input buffer?

$pc         x/i $pc$eax 0x0000002d
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1275		xor %eax,%eax

$pc         x/i $pc$eax 0x0000002d
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1276		mov (%ebx),%al		// get next key from input buffer

$pc         x/i $pc$eax 0x00000000
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1277		inc %ebx

$pc         x/i $pc$eax 0x0000002a
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1278		mov %ebx,(currkey)	// increment currkey

$pc         x/i $pc$eax 0x0000002a
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1279		ret

$pc         x/i $pc$eax 0x0000002a
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_WORD () at jonesforth.S:1394
1394		cmpb $'\n',%al		// end of line yet?

$pc         x/i $pc$eax 0x0000002a
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1395		jne 3b

$pc         x/i $pc$eax 0x0000002a
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1393		call _KEY

$pc         x/i $pc$eax 0x0000002a
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_KEY () at jonesforth.S:1272
1272		mov (currkey),%ebx

$pc         x/i $pc$eax 0x0000002a
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1273		cmp (bufftop),%ebx

$pc         x/i $pc$eax 0x0000002a
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1274		jge 1f			// exhausted the input buffer?

$pc         x/i $pc$eax 0x0000002a
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1275		xor %eax,%eax

$pc         x/i $pc$eax 0x0000002a
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1276		mov (%ebx),%al		// get next key from input buffer

$pc         x/i $pc$eax 0x00000000
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1277		inc %ebx

$pc         x/i $pc$eax 0x0000002d
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1278		mov %ebx,(currkey)	// increment currkey

$pc         x/i $pc$eax 0x0000002d
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1279		ret

$pc         x/i $pc$eax 0x0000002d
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_WORD () at jonesforth.S:1394
1394		cmpb $'\n',%al		// end of line yet?

$pc         x/i $pc$eax 0x0000002d
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1395		jne 3b

$pc         x/i $pc$eax 0x0000002d
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1393		call _KEY

$pc         x/i $pc$eax 0x0000002d
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_KEY () at jonesforth.S:1272
1272		mov (currkey),%ebx

$pc         x/i $pc$eax 0x0000002d
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1273		cmp (bufftop),%ebx

$pc         x/i $pc$eax 0x0000002d
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1274		jge 1f			// exhausted the input buffer?

$pc         x/i $pc$eax 0x0000002d
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1275		xor %eax,%eax

$pc         x/i $pc$eax 0x0000002d
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1276		mov (%ebx),%al		// get next key from input buffer

$pc         x/i $pc$eax 0x00000000
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1277		inc %ebx

$pc         x/i $pc$eax 0x0000000a
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1278		mov %ebx,(currkey)	// increment currkey

$pc         x/i $pc$eax 0x0000000a
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1279		ret

$pc         x/i $pc$eax 0x0000000a
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_WORD () at jonesforth.S:1394
1394		cmpb $'\n',%al		// end of line yet?

$pc         x/i $pc$eax 0x0000000a
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1395		jne 3b

$pc         x/i $pc$eax 0x0000000a
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1396		jmp 1b

$pc         x/i $pc$eax 0x0000000a
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1371		call _KEY		// get next key, returned in %eax

$pc         x/i $pc$eax 0x0000000a
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_KEY () at jonesforth.S:1272
1272		mov (currkey),%ebx

$pc         x/i $pc$eax 0x0000000a
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1273		cmp (bufftop),%ebx

$pc         x/i $pc$eax 0x0000000a
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1274		jge 1f			// exhausted the input buffer?

$pc         x/i $pc$eax 0x0000000a
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1275		xor %eax,%eax

$pc         x/i $pc$eax 0x0000000a
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1276		mov (%ebx),%al		// get next key from input buffer

$pc         x/i $pc$eax 0x00000000
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1277		inc %ebx

$pc         x/i $pc$eax 0x0000005c
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1278		mov %ebx,(currkey)	// increment currkey

$pc         x/i $pc$eax 0x0000005c
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1279		ret

$pc         x/i $pc$eax 0x0000005c
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_WORD () at jonesforth.S:1372
1372		cmpb $'\\',%al		// start of a comment?

$pc         x/i $pc$eax 0x0000005c
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1373		je 3f			// if so, skip the comment

$pc         x/i $pc$eax 0x0000005c
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1393		call _KEY

$pc         x/i $pc$eax 0x0000005c
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_KEY () at jonesforth.S:1272
1272		mov (currkey),%ebx

$pc         x/i $pc$eax 0x0000005c
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1273		cmp (bufftop),%ebx

$pc         x/i $pc$eax 0x0000005c
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1274		jge 1f			// exhausted the input buffer?

$pc         x/i $pc$eax 0x0000005c
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1275		xor %eax,%eax

$pc         x/i $pc$eax 0x0000005c
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1276		mov (%ebx),%al		// get next key from input buffer

$pc         x/i $pc$eax 0x00000000
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1277		inc %ebx

$pc         x/i $pc$eax 0x00000009
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1278		mov %ebx,(currkey)	// increment currkey

$pc         x/i $pc$eax 0x00000009
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1279		ret

$pc         x/i $pc$eax 0x00000009
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_WORD () at jonesforth.S:1394
1394		cmpb $'\n',%al		// end of line yet?

$pc         x/i $pc$eax 0x00000009
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1395		jne 3b

$pc         x/i $pc$eax 0x00000009
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1393		call _KEY

$pc         x/i $pc$eax 0x00000009
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_KEY () at jonesforth.S:1272
1272		mov (currkey),%ebx

$pc         x/i $pc$eax 0x00000009
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1273		cmp (bufftop),%ebx

$pc         x/i $pc$eax 0x00000009
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1274		jge 1f			// exhausted the input buffer?

$pc         x/i $pc$eax 0x00000009
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1275		xor %eax,%eax

$pc         x/i $pc$eax 0x00000009
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1276		mov (%ebx),%al		// get next key from input buffer

$pc         x/i $pc$eax 0x00000000
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1277		inc %ebx

$pc         x/i $pc$eax 0x00000041
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1278		mov %ebx,(currkey)	// increment currkey

$pc         x/i $pc$eax 0x00000041
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1279		ret

$pc         x/i $pc$eax 0x00000041
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_WORD () at jonesforth.S:1394
1394		cmpb $'\n',%al		// end of line yet?

$pc         x/i $pc$eax 0x00000041
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1395		jne 3b

$pc         x/i $pc$eax 0x00000041
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1393		call _KEY

$pc         x/i $pc$eax 0x00000041
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_KEY () at jonesforth.S:1272
1272		mov (currkey),%ebx

$pc         x/i $pc$eax 0x00000041
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1273		cmp (bufftop),%ebx

$pc         x/i $pc$eax 0x00000041
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1274		jge 1f			// exhausted the input buffer?

$pc         x/i $pc$eax 0x00000041
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1275		xor %eax,%eax

$pc         x/i $pc$eax 0x00000041
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1276		mov (%ebx),%al		// get next key from input buffer

$pc         x/i $pc$eax 0x00000000
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1277		inc %ebx

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1278		mov %ebx,(currkey)	// increment currkey

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1279		ret

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_WORD () at jonesforth.S:1394
1394		cmpb $'\n',%al		// end of line yet?

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1395		jne 3b

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1393		call _KEY

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_KEY () at jonesforth.S:1272
1272		mov (currkey),%ebx

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1273		cmp (bufftop),%ebx

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1274		jge 1f			// exhausted the input buffer?

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1275		xor %eax,%eax

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1276		mov (%ebx),%al		// get next key from input buffer

$pc         x/i $pc$eax 0x00000000
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1277		inc %ebx

$pc         x/i $pc$eax 0x00000073
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1278		mov %ebx,(currkey)	// increment currkey

$pc         x/i $pc$eax 0x00000073
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1279		ret

$pc         x/i $pc$eax 0x00000073
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_WORD () at jonesforth.S:1394
1394		cmpb $'\n',%al		// end of line yet?

$pc         x/i $pc$eax 0x00000073
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1395		jne 3b

$pc         x/i $pc$eax 0x00000073
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1393		call _KEY

$pc         x/i $pc$eax 0x00000073
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_KEY () at jonesforth.S:1272
1272		mov (currkey),%ebx

$pc         x/i $pc$eax 0x00000073
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1273		cmp (bufftop),%ebx

$pc         x/i $pc$eax 0x00000073
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1274		jge 1f			// exhausted the input buffer?

$pc         x/i $pc$eax 0x00000073
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1275		xor %eax,%eax

$pc         x/i $pc$eax 0x00000073
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1276		mov (%ebx),%al		// get next key from input buffer

$pc         x/i $pc$eax 0x00000000
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1277		inc %ebx

$pc         x/i $pc$eax 0x0000006f
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1278		mov %ebx,(currkey)	// increment currkey

$pc         x/i $pc$eax 0x0000006f
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1279		ret

$pc         x/i $pc$eax 0x0000006f
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_WORD () at jonesforth.S:1394
1394		cmpb $'\n',%al		// end of line yet?

$pc         x/i $pc$eax 0x0000006f
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1395		jne 3b

$pc         x/i $pc$eax 0x0000006f
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1393		call _KEY

$pc         x/i $pc$eax 0x0000006f
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_KEY () at jonesforth.S:1272
1272		mov (currkey),%ebx

$pc         x/i $pc$eax 0x0000006f
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1273		cmp (bufftop),%ebx

$pc         x/i $pc$eax 0x0000006f
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1274		jge 1f			// exhausted the input buffer?

$pc         x/i $pc$eax 0x0000006f
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1275		xor %eax,%eax

$pc         x/i $pc$eax 0x0000006f
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1276		mov (%ebx),%al		// get next key from input buffer

$pc         x/i $pc$eax 0x00000000
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1277		inc %ebx

$pc         x/i $pc$eax 0x0000006d
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1278		mov %ebx,(currkey)	// increment currkey

$pc         x/i $pc$eax 0x0000006d
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1279		ret

$pc         x/i $pc$eax 0x0000006d
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_WORD () at jonesforth.S:1394
1394		cmpb $'\n',%al		// end of line yet?

$pc         x/i $pc$eax 0x0000006d
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1395		jne 3b

$pc         x/i $pc$eax 0x0000006d
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1393		call _KEY

$pc         x/i $pc$eax 0x0000006d
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_KEY () at jonesforth.S:1272
1272		mov (currkey),%ebx

$pc         x/i $pc$eax 0x0000006d
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1273		cmp (bufftop),%ebx

$pc         x/i $pc$eax 0x0000006d
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1274		jge 1f			// exhausted the input buffer?

$pc         x/i $pc$eax 0x0000006d
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1275		xor %eax,%eax

$pc         x/i $pc$eax 0x0000006d
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1276		mov (%ebx),%al		// get next key from input buffer

$pc         x/i $pc$eax 0x00000000
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1277		inc %ebx

$pc         x/i $pc$eax 0x00000065
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1278		mov %ebx,(currkey)	// increment currkey

$pc         x/i $pc$eax 0x00000065
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1279		ret

$pc         x/i $pc$eax 0x00000065
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_WORD () at jonesforth.S:1394
1394		cmpb $'\n',%al		// end of line yet?

$pc         x/i $pc$eax 0x00000065
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1395		jne 3b

$pc         x/i $pc$eax 0x00000065
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1393		call _KEY

$pc         x/i $pc$eax 0x00000065
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_KEY () at jonesforth.S:1272
1272		mov (currkey),%ebx

$pc         x/i $pc$eax 0x00000065
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1273		cmp (bufftop),%ebx

$pc         x/i $pc$eax 0x00000065
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1274		jge 1f			// exhausted the input buffer?

$pc         x/i $pc$eax 0x00000065
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1275		xor %eax,%eax

$pc         x/i $pc$eax 0x00000065
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1276		mov (%ebx),%al		// get next key from input buffer

$pc         x/i $pc$eax 0x00000000
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1277		inc %ebx

$pc         x/i $pc$eax 0x00000074
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1278		mov %ebx,(currkey)	// increment currkey

$pc         x/i $pc$eax 0x00000074
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1279		ret

$pc         x/i $pc$eax 0x00000074
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_WORD () at jonesforth.S:1394
1394		cmpb $'\n',%al		// end of line yet?

$pc         x/i $pc$eax 0x00000074
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1395		jne 3b

$pc         x/i $pc$eax 0x00000074
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1393		call _KEY

$pc         x/i $pc$eax 0x00000074
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_KEY () at jonesforth.S:1272
1272		mov (currkey),%ebx

$pc         x/i $pc$eax 0x00000074
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1273		cmp (bufftop),%ebx

$pc         x/i $pc$eax 0x00000074
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1274		jge 1f			// exhausted the input buffer?

$pc         x/i $pc$eax 0x00000074
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1275		xor %eax,%eax

$pc         x/i $pc$eax 0x00000074
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1276		mov (%ebx),%al		// get next key from input buffer

$pc         x/i $pc$eax 0x00000000
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1277		inc %ebx

$pc         x/i $pc$eax 0x00000069
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1278		mov %ebx,(currkey)	// increment currkey

$pc         x/i $pc$eax 0x00000069
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1279		ret

$pc         x/i $pc$eax 0x00000069
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_WORD () at jonesforth.S:1394
1394		cmpb $'\n',%al		// end of line yet?

$pc         x/i $pc$eax 0x00000069
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1395		jne 3b

$pc         x/i $pc$eax 0x00000069
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1393		call _KEY

$pc         x/i $pc$eax 0x00000069
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_KEY () at jonesforth.S:1272
1272		mov (currkey),%ebx

$pc         x/i $pc$eax 0x00000069
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1273		cmp (bufftop),%ebx

$pc         x/i $pc$eax 0x00000069
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1274		jge 1f			// exhausted the input buffer?

$pc         x/i $pc$eax 0x00000069
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1275		xor %eax,%eax

$pc         x/i $pc$eax 0x00000069
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1276		mov (%ebx),%al		// get next key from input buffer

$pc         x/i $pc$eax 0x00000000
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1277		inc %ebx

$pc         x/i $pc$eax 0x0000006d
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1278		mov %ebx,(currkey)	// increment currkey

$pc         x/i $pc$eax 0x0000006d
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1279		ret

$pc         x/i $pc$eax 0x0000006d
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_WORD () at jonesforth.S:1394
1394		cmpb $'\n',%al		// end of line yet?

$pc         x/i $pc$eax 0x0000006d
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1395		jne 3b

$pc         x/i $pc$eax 0x0000006d
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1393		call _KEY

$pc         x/i $pc$eax 0x0000006d
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_KEY () at jonesforth.S:1272
1272		mov (currkey),%ebx

$pc         x/i $pc$eax 0x0000006d
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1273		cmp (bufftop),%ebx

$pc         x/i $pc$eax 0x0000006d
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1274		jge 1f			// exhausted the input buffer?

$pc         x/i $pc$eax 0x0000006d
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1275		xor %eax,%eax

$pc         x/i $pc$eax 0x0000006d
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1276		mov (%ebx),%al		// get next key from input buffer

$pc         x/i $pc$eax 0x00000000
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1277		inc %ebx

$pc         x/i $pc$eax 0x00000065
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1278		mov %ebx,(currkey)	// increment currkey

$pc         x/i $pc$eax 0x00000065
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1279		ret

$pc         x/i $pc$eax 0x00000065
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_WORD () at jonesforth.S:1394
1394		cmpb $'\n',%al		// end of line yet?

$pc         x/i $pc$eax 0x00000065
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1395		jne 3b

$pc         x/i $pc$eax 0x00000065
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1393		call _KEY

$pc         x/i $pc$eax 0x00000065
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_KEY () at jonesforth.S:1272
1272		mov (currkey),%ebx

$pc         x/i $pc$eax 0x00000065
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1273		cmp (bufftop),%ebx

$pc         x/i $pc$eax 0x00000065
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1274		jge 1f			// exhausted the input buffer?

$pc         x/i $pc$eax 0x00000065
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1275		xor %eax,%eax

$pc         x/i $pc$eax 0x00000065
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1276		mov (%ebx),%al		// get next key from input buffer

$pc         x/i $pc$eax 0x00000000
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1277		inc %ebx

$pc         x/i $pc$eax 0x00000073
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1278		mov %ebx,(currkey)	// increment currkey

$pc         x/i $pc$eax 0x00000073
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1279		ret

$pc         x/i $pc$eax 0x00000073
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_WORD () at jonesforth.S:1394
1394		cmpb $'\n',%al		// end of line yet?

$pc         x/i $pc$eax 0x00000073
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1395		jne 3b

$pc         x/i $pc$eax 0x00000073
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1393		call _KEY

$pc         x/i $pc$eax 0x00000073
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_KEY () at jonesforth.S:1272
1272		mov (currkey),%ebx

$pc         x/i $pc$eax 0x00000073
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1273		cmp (bufftop),%ebx

$pc         x/i $pc$eax 0x00000073
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1274		jge 1f			// exhausted the input buffer?

$pc         x/i $pc$eax 0x00000073
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1275		xor %eax,%eax

$pc         x/i $pc$eax 0x00000073
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1276		mov (%ebx),%al		// get next key from input buffer

$pc         x/i $pc$eax 0x00000000
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1277		inc %ebx

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1278		mov %ebx,(currkey)	// increment currkey

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1279		ret

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_WORD () at jonesforth.S:1394
1394		cmpb $'\n',%al		// end of line yet?

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1395		jne 3b

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1393		call _KEY

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_KEY () at jonesforth.S:1272
1272		mov (currkey),%ebx

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1273		cmp (bufftop),%ebx

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1274		jge 1f			// exhausted the input buffer?

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1275		xor %eax,%eax

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1276		mov (%ebx),%al		// get next key from input buffer

$pc         x/i $pc$eax 0x00000000
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1277		inc %ebx

$pc         x/i $pc$eax 0x0000006d
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1278		mov %ebx,(currkey)	// increment currkey

$pc         x/i $pc$eax 0x0000006d
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1279		ret

$pc         x/i $pc$eax 0x0000006d
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_WORD () at jonesforth.S:1394
1394		cmpb $'\n',%al		// end of line yet?

$pc         x/i $pc$eax 0x0000006d
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1395		jne 3b

$pc         x/i $pc$eax 0x0000006d
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1393		call _KEY

$pc         x/i $pc$eax 0x0000006d
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_KEY () at jonesforth.S:1272
1272		mov (currkey),%ebx

$pc         x/i $pc$eax 0x0000006d
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1273		cmp (bufftop),%ebx

$pc         x/i $pc$eax 0x0000006d
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1274		jge 1f			// exhausted the input buffer?

$pc         x/i $pc$eax 0x0000006d
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1275		xor %eax,%eax

$pc         x/i $pc$eax 0x0000006d
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1276		mov (%ebx),%al		// get next key from input buffer

$pc         x/i $pc$eax 0x00000000
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1277		inc %ebx

$pc         x/i $pc$eax 0x00000069
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1278		mov %ebx,(currkey)	// increment currkey

$pc         x/i $pc$eax 0x00000069
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1279		ret

$pc         x/i $pc$eax 0x00000069
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_WORD () at jonesforth.S:1394
1394		cmpb $'\n',%al		// end of line yet?

$pc         x/i $pc$eax 0x00000069
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1395		jne 3b

$pc         x/i $pc$eax 0x00000069
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1393		call _KEY

$pc         x/i $pc$eax 0x00000069
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_KEY () at jonesforth.S:1272
1272		mov (currkey),%ebx

$pc         x/i $pc$eax 0x00000069
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1273		cmp (bufftop),%ebx

$pc         x/i $pc$eax 0x00000069
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1274		jge 1f			// exhausted the input buffer?

$pc         x/i $pc$eax 0x00000069
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1275		xor %eax,%eax

$pc         x/i $pc$eax 0x00000069
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1276		mov (%ebx),%al		// get next key from input buffer

$pc         x/i $pc$eax 0x00000000
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1277		inc %ebx

$pc         x/i $pc$eax 0x0000006e
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1278		mov %ebx,(currkey)	// increment currkey

$pc         x/i $pc$eax 0x0000006e
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1279		ret

$pc         x/i $pc$eax 0x0000006e
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_WORD () at jonesforth.S:1394
1394		cmpb $'\n',%al		// end of line yet?

$pc         x/i $pc$eax 0x0000006e
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1395		jne 3b

$pc         x/i $pc$eax 0x0000006e
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1393		call _KEY

$pc         x/i $pc$eax 0x0000006e
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_KEY () at jonesforth.S:1272
1272		mov (currkey),%ebx

$pc         x/i $pc$eax 0x0000006e
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1273		cmp (bufftop),%ebx

$pc         x/i $pc$eax 0x0000006e
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1274		jge 1f			// exhausted the input buffer?

$pc         x/i $pc$eax 0x0000006e
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1275		xor %eax,%eax

$pc         x/i $pc$eax 0x0000006e
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1276		mov (%ebx),%al		// get next key from input buffer

$pc         x/i $pc$eax 0x00000000
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1277		inc %ebx

$pc         x/i $pc$eax 0x00000069
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1278		mov %ebx,(currkey)	// increment currkey

$pc         x/i $pc$eax 0x00000069
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1279		ret

$pc         x/i $pc$eax 0x00000069
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_WORD () at jonesforth.S:1394
1394		cmpb $'\n',%al		// end of line yet?

$pc         x/i $pc$eax 0x00000069
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1395		jne 3b

$pc         x/i $pc$eax 0x00000069
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1393		call _KEY

$pc         x/i $pc$eax 0x00000069
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_KEY () at jonesforth.S:1272
1272		mov (currkey),%ebx

$pc         x/i $pc$eax 0x00000069
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1273		cmp (bufftop),%ebx

$pc         x/i $pc$eax 0x00000069
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1274		jge 1f			// exhausted the input buffer?

$pc         x/i $pc$eax 0x00000069
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1275		xor %eax,%eax

$pc         x/i $pc$eax 0x00000069
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1276		mov (%ebx),%al		// get next key from input buffer

$pc         x/i $pc$eax 0x00000000
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1277		inc %ebx

$pc         x/i $pc$eax 0x0000006d
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1278		mov %ebx,(currkey)	// increment currkey

$pc         x/i $pc$eax 0x0000006d
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1279		ret

$pc         x/i $pc$eax 0x0000006d
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_WORD () at jonesforth.S:1394
1394		cmpb $'\n',%al		// end of line yet?

$pc         x/i $pc$eax 0x0000006d
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1395		jne 3b

$pc         x/i $pc$eax 0x0000006d
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1393		call _KEY

$pc         x/i $pc$eax 0x0000006d
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_KEY () at jonesforth.S:1272
1272		mov (currkey),%ebx

$pc         x/i $pc$eax 0x0000006d
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1273		cmp (bufftop),%ebx

$pc         x/i $pc$eax 0x0000006d
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1274		jge 1f			// exhausted the input buffer?

$pc         x/i $pc$eax 0x0000006d
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1275		xor %eax,%eax

$pc         x/i $pc$eax 0x0000006d
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1276		mov (%ebx),%al		// get next key from input buffer

$pc         x/i $pc$eax 0x00000000
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1277		inc %ebx

$pc         x/i $pc$eax 0x00000061
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1278		mov %ebx,(currkey)	// increment currkey

$pc         x/i $pc$eax 0x00000061
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1279		ret

$pc         x/i $pc$eax 0x00000061
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_WORD () at jonesforth.S:1394
1394		cmpb $'\n',%al		// end of line yet?

$pc         x/i $pc$eax 0x00000061
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1395		jne 3b

$pc         x/i $pc$eax 0x00000061
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1393		call _KEY

$pc         x/i $pc$eax 0x00000061
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_KEY () at jonesforth.S:1272
1272		mov (currkey),%ebx

$pc         x/i $pc$eax 0x00000061
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1273		cmp (bufftop),%ebx

$pc         x/i $pc$eax 0x00000061
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1274		jge 1f			// exhausted the input buffer?

$pc         x/i $pc$eax 0x00000061
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1275		xor %eax,%eax

$pc         x/i $pc$eax 0x00000061
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1276		mov (%ebx),%al		// get next key from input buffer

$pc         x/i $pc$eax 0x00000000
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1277		inc %ebx

$pc         x/i $pc$eax 0x0000006c
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1278		mov %ebx,(currkey)	// increment currkey

$pc         x/i $pc$eax 0x0000006c
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1279		ret

$pc         x/i $pc$eax 0x0000006c
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_WORD () at jonesforth.S:1394
1394		cmpb $'\n',%al		// end of line yet?

$pc         x/i $pc$eax 0x0000006c
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1395		jne 3b

$pc         x/i $pc$eax 0x0000006c
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1393		call _KEY

$pc         x/i $pc$eax 0x0000006c
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_KEY () at jonesforth.S:1272
1272		mov (currkey),%ebx

$pc         x/i $pc$eax 0x0000006c
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1273		cmp (bufftop),%ebx

$pc         x/i $pc$eax 0x0000006c
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1274		jge 1f			// exhausted the input buffer?

$pc         x/i $pc$eax 0x0000006c
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1275		xor %eax,%eax

$pc         x/i $pc$eax 0x0000006c
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1276		mov (%ebx),%al		// get next key from input buffer

$pc         x/i $pc$eax 0x00000000
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1277		inc %ebx

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1278		mov %ebx,(currkey)	// increment currkey

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1279		ret

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_WORD () at jonesforth.S:1394
1394		cmpb $'\n',%al		// end of line yet?

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1395		jne 3b

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1393		call _KEY

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_KEY () at jonesforth.S:1272
1272		mov (currkey),%ebx

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1273		cmp (bufftop),%ebx

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1274		jge 1f			// exhausted the input buffer?

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1275		xor %eax,%eax

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1276		mov (%ebx),%al		// get next key from input buffer

$pc         x/i $pc$eax 0x00000000
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1277		inc %ebx

$pc         x/i $pc$eax 0x00000046
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1278		mov %ebx,(currkey)	// increment currkey

$pc         x/i $pc$eax 0x00000046
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1279		ret

$pc         x/i $pc$eax 0x00000046
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_WORD () at jonesforth.S:1394
1394		cmpb $'\n',%al		// end of line yet?

$pc         x/i $pc$eax 0x00000046
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1395		jne 3b

$pc         x/i $pc$eax 0x00000046
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1393		call _KEY

$pc         x/i $pc$eax 0x00000046
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_KEY () at jonesforth.S:1272
1272		mov (currkey),%ebx

$pc         x/i $pc$eax 0x00000046
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1273		cmp (bufftop),%ebx

$pc         x/i $pc$eax 0x00000046
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1274		jge 1f			// exhausted the input buffer?

$pc         x/i $pc$eax 0x00000046
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1275		xor %eax,%eax

$pc         x/i $pc$eax 0x00000046
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1276		mov (%ebx),%al		// get next key from input buffer

$pc         x/i $pc$eax 0x00000000
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1277		inc %ebx

$pc         x/i $pc$eax 0x0000004f
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1278		mov %ebx,(currkey)	// increment currkey

$pc         x/i $pc$eax 0x0000004f
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1279		ret

$pc         x/i $pc$eax 0x0000004f
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_WORD () at jonesforth.S:1394
1394		cmpb $'\n',%al		// end of line yet?

$pc         x/i $pc$eax 0x0000004f
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1395		jne 3b

$pc         x/i $pc$eax 0x0000004f
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1393		call _KEY

$pc         x/i $pc$eax 0x0000004f
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_KEY () at jonesforth.S:1272
1272		mov (currkey),%ebx

$pc         x/i $pc$eax 0x0000004f
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1273		cmp (bufftop),%ebx

$pc         x/i $pc$eax 0x0000004f
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1274		jge 1f			// exhausted the input buffer?

$pc         x/i $pc$eax 0x0000004f
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1275		xor %eax,%eax

$pc         x/i $pc$eax 0x0000004f
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1276		mov (%ebx),%al		// get next key from input buffer

$pc         x/i $pc$eax 0x00000000
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1277		inc %ebx

$pc         x/i $pc$eax 0x00000052
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1278		mov %ebx,(currkey)	// increment currkey

$pc         x/i $pc$eax 0x00000052
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1279		ret

$pc         x/i $pc$eax 0x00000052
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_WORD () at jonesforth.S:1394
1394		cmpb $'\n',%al		// end of line yet?

$pc         x/i $pc$eax 0x00000052
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1395		jne 3b

$pc         x/i $pc$eax 0x00000052
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1393		call _KEY

$pc         x/i $pc$eax 0x00000052
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_KEY () at jonesforth.S:1272
1272		mov (currkey),%ebx

$pc         x/i $pc$eax 0x00000052
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1273		cmp (bufftop),%ebx

$pc         x/i $pc$eax 0x00000052
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1274		jge 1f			// exhausted the input buffer?

$pc         x/i $pc$eax 0x00000052
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1275		xor %eax,%eax

$pc         x/i $pc$eax 0x00000052
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1276		mov (%ebx),%al		// get next key from input buffer

$pc         x/i $pc$eax 0x00000000
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1277		inc %ebx

$pc         x/i $pc$eax 0x00000054
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1278		mov %ebx,(currkey)	// increment currkey

$pc         x/i $pc$eax 0x00000054
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1279		ret

$pc         x/i $pc$eax 0x00000054
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_WORD () at jonesforth.S:1394
1394		cmpb $'\n',%al		// end of line yet?

$pc         x/i $pc$eax 0x00000054
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1395		jne 3b

$pc         x/i $pc$eax 0x00000054
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1393		call _KEY

$pc         x/i $pc$eax 0x00000054
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_KEY () at jonesforth.S:1272
1272		mov (currkey),%ebx

$pc         x/i $pc$eax 0x00000054
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1273		cmp (bufftop),%ebx

$pc         x/i $pc$eax 0x00000054
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1274		jge 1f			// exhausted the input buffer?

$pc         x/i $pc$eax 0x00000054
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1275		xor %eax,%eax

$pc         x/i $pc$eax 0x00000054
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1276		mov (%ebx),%al		// get next key from input buffer

$pc         x/i $pc$eax 0x00000000
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1277		inc %ebx

$pc         x/i $pc$eax 0x00000048
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1278		mov %ebx,(currkey)	// increment currkey

$pc         x/i $pc$eax 0x00000048
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1279		ret

$pc         x/i $pc$eax 0x00000048
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_WORD () at jonesforth.S:1394
1394		cmpb $'\n',%al		// end of line yet?

$pc         x/i $pc$eax 0x00000048
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1395		jne 3b

$pc         x/i $pc$eax 0x00000048
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1393		call _KEY

$pc         x/i $pc$eax 0x00000048
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_KEY () at jonesforth.S:1272
1272		mov (currkey),%ebx

$pc         x/i $pc$eax 0x00000048
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1273		cmp (bufftop),%ebx

$pc         x/i $pc$eax 0x00000048
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1274		jge 1f			// exhausted the input buffer?

$pc         x/i $pc$eax 0x00000048
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1275		xor %eax,%eax

$pc         x/i $pc$eax 0x00000048
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1276		mov (%ebx),%al		// get next key from input buffer

$pc         x/i $pc$eax 0x00000000
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1277		inc %ebx

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1278		mov %ebx,(currkey)	// increment currkey

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1279		ret

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_WORD () at jonesforth.S:1394
1394		cmpb $'\n',%al		// end of line yet?

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1395		jne 3b

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1393		call _KEY

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_KEY () at jonesforth.S:1272
1272		mov (currkey),%ebx

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1273		cmp (bufftop),%ebx

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1274		jge 1f			// exhausted the input buffer?

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1275		xor %eax,%eax

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1276		mov (%ebx),%al		// get next key from input buffer

$pc         x/i $pc$eax 0x00000000
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1277		inc %ebx

$pc         x/i $pc$eax 0x00000063
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1278		mov %ebx,(currkey)	// increment currkey

$pc         x/i $pc$eax 0x00000063
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1279		ret

$pc         x/i $pc$eax 0x00000063
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_WORD () at jonesforth.S:1394
1394		cmpb $'\n',%al		// end of line yet?

$pc         x/i $pc$eax 0x00000063
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1395		jne 3b

$pc         x/i $pc$eax 0x00000063
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1393		call _KEY

$pc         x/i $pc$eax 0x00000063
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_KEY () at jonesforth.S:1272
1272		mov (currkey),%ebx

$pc         x/i $pc$eax 0x00000063
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1273		cmp (bufftop),%ebx

$pc         x/i $pc$eax 0x00000063
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1274		jge 1f			// exhausted the input buffer?

$pc         x/i $pc$eax 0x00000063
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1275		xor %eax,%eax

$pc         x/i $pc$eax 0x00000063
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1276		mov (%ebx),%al		// get next key from input buffer

$pc         x/i $pc$eax 0x00000000
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1277		inc %ebx

$pc         x/i $pc$eax 0x0000006f
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1278		mov %ebx,(currkey)	// increment currkey

$pc         x/i $pc$eax 0x0000006f
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1279		ret

$pc         x/i $pc$eax 0x0000006f
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_WORD () at jonesforth.S:1394
1394		cmpb $'\n',%al		// end of line yet?

$pc         x/i $pc$eax 0x0000006f
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1395		jne 3b

$pc         x/i $pc$eax 0x0000006f
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1393		call _KEY

$pc         x/i $pc$eax 0x0000006f
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_KEY () at jonesforth.S:1272
1272		mov (currkey),%ebx

$pc         x/i $pc$eax 0x0000006f
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1273		cmp (bufftop),%ebx

$pc         x/i $pc$eax 0x0000006f
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1274		jge 1f			// exhausted the input buffer?

$pc         x/i $pc$eax 0x0000006f
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1275		xor %eax,%eax

$pc         x/i $pc$eax 0x0000006f
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1276		mov (%ebx),%al		// get next key from input buffer

$pc         x/i $pc$eax 0x00000000
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1277		inc %ebx

$pc         x/i $pc$eax 0x0000006d
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1278		mov %ebx,(currkey)	// increment currkey

$pc         x/i $pc$eax 0x0000006d
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1279		ret

$pc         x/i $pc$eax 0x0000006d
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_WORD () at jonesforth.S:1394
1394		cmpb $'\n',%al		// end of line yet?

$pc         x/i $pc$eax 0x0000006d
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1395		jne 3b

$pc         x/i $pc$eax 0x0000006d
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1393		call _KEY

$pc         x/i $pc$eax 0x0000006d
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_KEY () at jonesforth.S:1272
1272		mov (currkey),%ebx

$pc         x/i $pc$eax 0x0000006d
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1273		cmp (bufftop),%ebx

$pc         x/i $pc$eax 0x0000006d
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1274		jge 1f			// exhausted the input buffer?

$pc         x/i $pc$eax 0x0000006d
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1275		xor %eax,%eax

$pc         x/i $pc$eax 0x0000006d
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1276		mov (%ebx),%al		// get next key from input buffer

$pc         x/i $pc$eax 0x00000000
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1277		inc %ebx

$pc         x/i $pc$eax 0x00000070
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1278		mov %ebx,(currkey)	// increment currkey

$pc         x/i $pc$eax 0x00000070
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1279		ret

$pc         x/i $pc$eax 0x00000070
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_WORD () at jonesforth.S:1394
1394		cmpb $'\n',%al		// end of line yet?

$pc         x/i $pc$eax 0x00000070
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1395		jne 3b

$pc         x/i $pc$eax 0x00000070
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1393		call _KEY

$pc         x/i $pc$eax 0x00000070
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_KEY () at jonesforth.S:1272
1272		mov (currkey),%ebx

$pc         x/i $pc$eax 0x00000070
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1273		cmp (bufftop),%ebx

$pc         x/i $pc$eax 0x00000070
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1274		jge 1f			// exhausted the input buffer?

$pc         x/i $pc$eax 0x00000070
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1275		xor %eax,%eax

$pc         x/i $pc$eax 0x00000070
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1276		mov (%ebx),%al		// get next key from input buffer

$pc         x/i $pc$eax 0x00000000
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1277		inc %ebx

$pc         x/i $pc$eax 0x00000069
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1278		mov %ebx,(currkey)	// increment currkey

$pc         x/i $pc$eax 0x00000069
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1279		ret

$pc         x/i $pc$eax 0x00000069
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_WORD () at jonesforth.S:1394
1394		cmpb $'\n',%al		// end of line yet?

$pc         x/i $pc$eax 0x00000069
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1395		jne 3b

$pc         x/i $pc$eax 0x00000069
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1393		call _KEY

$pc         x/i $pc$eax 0x00000069
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_KEY () at jonesforth.S:1272
1272		mov (currkey),%ebx

$pc         x/i $pc$eax 0x00000069
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1273		cmp (bufftop),%ebx

$pc         x/i $pc$eax 0x00000069
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1274		jge 1f			// exhausted the input buffer?

$pc         x/i $pc$eax 0x00000069
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1275		xor %eax,%eax

$pc         x/i $pc$eax 0x00000069
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1276		mov (%ebx),%al		// get next key from input buffer

$pc         x/i $pc$eax 0x00000000
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1277		inc %ebx

$pc         x/i $pc$eax 0x0000006c
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1278		mov %ebx,(currkey)	// increment currkey

$pc         x/i $pc$eax 0x0000006c
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1279		ret

$pc         x/i $pc$eax 0x0000006c
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_WORD () at jonesforth.S:1394
1394		cmpb $'\n',%al		// end of line yet?

$pc         x/i $pc$eax 0x0000006c
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1395		jne 3b

$pc         x/i $pc$eax 0x0000006c
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1393		call _KEY

$pc         x/i $pc$eax 0x0000006c
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_KEY () at jonesforth.S:1272
1272		mov (currkey),%ebx

$pc         x/i $pc$eax 0x0000006c
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1273		cmp (bufftop),%ebx

$pc         x/i $pc$eax 0x0000006c
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1274		jge 1f			// exhausted the input buffer?

$pc         x/i $pc$eax 0x0000006c
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1275		xor %eax,%eax

$pc         x/i $pc$eax 0x0000006c
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1276		mov (%ebx),%al		// get next key from input buffer

$pc         x/i $pc$eax 0x00000000
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1277		inc %ebx

$pc         x/i $pc$eax 0x00000065
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1278		mov %ebx,(currkey)	// increment currkey

$pc         x/i $pc$eax 0x00000065
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1279		ret

$pc         x/i $pc$eax 0x00000065
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_WORD () at jonesforth.S:1394
1394		cmpb $'\n',%al		// end of line yet?

$pc         x/i $pc$eax 0x00000065
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1395		jne 3b

$pc         x/i $pc$eax 0x00000065
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1393		call _KEY

$pc         x/i $pc$eax 0x00000065
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_KEY () at jonesforth.S:1272
1272		mov (currkey),%ebx

$pc         x/i $pc$eax 0x00000065
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1273		cmp (bufftop),%ebx

$pc         x/i $pc$eax 0x00000065
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1274		jge 1f			// exhausted the input buffer?

$pc         x/i $pc$eax 0x00000065
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1275		xor %eax,%eax

$pc         x/i $pc$eax 0x00000065
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1276		mov (%ebx),%al		// get next key from input buffer

$pc         x/i $pc$eax 0x00000000
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1277		inc %ebx

$pc         x/i $pc$eax 0x00000072
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1278		mov %ebx,(currkey)	// increment currkey

$pc         x/i $pc$eax 0x00000072
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1279		ret

$pc         x/i $pc$eax 0x00000072
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_WORD () at jonesforth.S:1394
1394		cmpb $'\n',%al		// end of line yet?

$pc         x/i $pc$eax 0x00000072
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1395		jne 3b

$pc         x/i $pc$eax 0x00000072
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1393		call _KEY

$pc         x/i $pc$eax 0x00000072
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_KEY () at jonesforth.S:1272
1272		mov (currkey),%ebx

$pc         x/i $pc$eax 0x00000072
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1273		cmp (bufftop),%ebx

$pc         x/i $pc$eax 0x00000072
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1274		jge 1f			// exhausted the input buffer?

$pc         x/i $pc$eax 0x00000072
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1275		xor %eax,%eax

$pc         x/i $pc$eax 0x00000072
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1276		mov (%ebx),%al		// get next key from input buffer

$pc         x/i $pc$eax 0x00000000
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1277		inc %ebx

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1278		mov %ebx,(currkey)	// increment currkey

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1279		ret

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_WORD () at jonesforth.S:1394
1394		cmpb $'\n',%al		// end of line yet?

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1395		jne 3b

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1393		call _KEY

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_KEY () at jonesforth.S:1272
1272		mov (currkey),%ebx

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1273		cmp (bufftop),%ebx

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1274		jge 1f			// exhausted the input buffer?

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1275		xor %eax,%eax

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1276		mov (%ebx),%al		// get next key from input buffer

$pc         x/i $pc$eax 0x00000000
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1277		inc %ebx

$pc         x/i $pc$eax 0x00000061
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1278		mov %ebx,(currkey)	// increment currkey

$pc         x/i $pc$eax 0x00000061
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1279		ret

$pc         x/i $pc$eax 0x00000061
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_WORD () at jonesforth.S:1394
1394		cmpb $'\n',%al		// end of line yet?

$pc         x/i $pc$eax 0x00000061
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1395		jne 3b

$pc         x/i $pc$eax 0x00000061
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1393		call _KEY

$pc         x/i $pc$eax 0x00000061
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_KEY () at jonesforth.S:1272
1272		mov (currkey),%ebx

$pc         x/i $pc$eax 0x00000061
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1273		cmp (bufftop),%ebx

$pc         x/i $pc$eax 0x00000061
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1274		jge 1f			// exhausted the input buffer?

$pc         x/i $pc$eax 0x00000061
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1275		xor %eax,%eax

$pc         x/i $pc$eax 0x00000061
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1276		mov (%ebx),%al		// get next key from input buffer

$pc         x/i $pc$eax 0x00000000
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1277		inc %ebx

$pc         x/i $pc$eax 0x0000006e
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1278		mov %ebx,(currkey)	// increment currkey

$pc         x/i $pc$eax 0x0000006e
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1279		ret

$pc         x/i $pc$eax 0x0000006e
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_WORD () at jonesforth.S:1394
1394		cmpb $'\n',%al		// end of line yet?

$pc         x/i $pc$eax 0x0000006e
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1395		jne 3b

$pc         x/i $pc$eax 0x0000006e
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1393		call _KEY

$pc         x/i $pc$eax 0x0000006e
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_KEY () at jonesforth.S:1272
1272		mov (currkey),%ebx

$pc         x/i $pc$eax 0x0000006e
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1273		cmp (bufftop),%ebx

$pc         x/i $pc$eax 0x0000006e
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1274		jge 1f			// exhausted the input buffer?

$pc         x/i $pc$eax 0x0000006e
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1275		xor %eax,%eax

$pc         x/i $pc$eax 0x0000006e
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1276		mov (%ebx),%al		// get next key from input buffer

$pc         x/i $pc$eax 0x00000000
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1277		inc %ebx

$pc         x/i $pc$eax 0x00000064
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1278		mov %ebx,(currkey)	// increment currkey

$pc         x/i $pc$eax 0x00000064
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1279		ret

$pc         x/i $pc$eax 0x00000064
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_WORD () at jonesforth.S:1394
1394		cmpb $'\n',%al		// end of line yet?

$pc         x/i $pc$eax 0x00000064
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1395		jne 3b

$pc         x/i $pc$eax 0x00000064
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1393		call _KEY

$pc         x/i $pc$eax 0x00000064
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_KEY () at jonesforth.S:1272
1272		mov (currkey),%ebx

$pc         x/i $pc$eax 0x00000064
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1273		cmp (bufftop),%ebx

$pc         x/i $pc$eax 0x00000064
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1274		jge 1f			// exhausted the input buffer?

$pc         x/i $pc$eax 0x00000064
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1275		xor %eax,%eax

$pc         x/i $pc$eax 0x00000064
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1276		mov (%ebx),%al		// get next key from input buffer

$pc         x/i $pc$eax 0x00000000
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1277		inc %ebx

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1278		mov %ebx,(currkey)	// increment currkey

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1279		ret

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_WORD () at jonesforth.S:1394
1394		cmpb $'\n',%al		// end of line yet?

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1395		jne 3b

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1393		call _KEY

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_KEY () at jonesforth.S:1272
1272		mov (currkey),%ebx

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1273		cmp (bufftop),%ebx

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1274		jge 1f			// exhausted the input buffer?

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1275		xor %eax,%eax

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1276		mov (%ebx),%al		// get next key from input buffer

$pc         x/i $pc$eax 0x00000000
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1277		inc %ebx

$pc         x/i $pc$eax 0x00000074
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1278		mov %ebx,(currkey)	// increment currkey

$pc         x/i $pc$eax 0x00000074
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1279		ret

$pc         x/i $pc$eax 0x00000074
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_WORD () at jonesforth.S:1394
1394		cmpb $'\n',%al		// end of line yet?

$pc         x/i $pc$eax 0x00000074
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1395		jne 3b

$pc         x/i $pc$eax 0x00000074
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1393		call _KEY

$pc         x/i $pc$eax 0x00000074
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_KEY () at jonesforth.S:1272
1272		mov (currkey),%ebx

$pc         x/i $pc$eax 0x00000074
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1273		cmp (bufftop),%ebx

$pc         x/i $pc$eax 0x00000074
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1274		jge 1f			// exhausted the input buffer?

$pc         x/i $pc$eax 0x00000074
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1275		xor %eax,%eax

$pc         x/i $pc$eax 0x00000074
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1276		mov (%ebx),%al		// get next key from input buffer

$pc         x/i $pc$eax 0x00000000
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1277		inc %ebx

$pc         x/i $pc$eax 0x00000075
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1278		mov %ebx,(currkey)	// increment currkey

$pc         x/i $pc$eax 0x00000075
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1279		ret

$pc         x/i $pc$eax 0x00000075
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_WORD () at jonesforth.S:1394
1394		cmpb $'\n',%al		// end of line yet?

$pc         x/i $pc$eax 0x00000075
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1395		jne 3b

$pc         x/i $pc$eax 0x00000075
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1393		call _KEY

$pc         x/i $pc$eax 0x00000075
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_KEY () at jonesforth.S:1272
1272		mov (currkey),%ebx

$pc         x/i $pc$eax 0x00000075
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1273		cmp (bufftop),%ebx

$pc         x/i $pc$eax 0x00000075
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1274		jge 1f			// exhausted the input buffer?

$pc         x/i $pc$eax 0x00000075
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1275		xor %eax,%eax

$pc         x/i $pc$eax 0x00000075
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1276		mov (%ebx),%al		// get next key from input buffer

$pc         x/i $pc$eax 0x00000000
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1277		inc %ebx

$pc         x/i $pc$eax 0x00000074
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1278		mov %ebx,(currkey)	// increment currkey

$pc         x/i $pc$eax 0x00000074
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1279		ret

$pc         x/i $pc$eax 0x00000074
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_WORD () at jonesforth.S:1394
1394		cmpb $'\n',%al		// end of line yet?

$pc         x/i $pc$eax 0x00000074
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1395		jne 3b

$pc         x/i $pc$eax 0x00000074
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1393		call _KEY

$pc         x/i $pc$eax 0x00000074
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_KEY () at jonesforth.S:1272
1272		mov (currkey),%ebx

$pc         x/i $pc$eax 0x00000074
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1273		cmp (bufftop),%ebx

$pc         x/i $pc$eax 0x00000074
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1274		jge 1f			// exhausted the input buffer?

$pc         x/i $pc$eax 0x00000074
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1275		xor %eax,%eax

$pc         x/i $pc$eax 0x00000074
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1276		mov (%ebx),%al		// get next key from input buffer

$pc         x/i $pc$eax 0x00000000
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1277		inc %ebx

$pc         x/i $pc$eax 0x0000006f
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1278		mov %ebx,(currkey)	// increment currkey

$pc         x/i $pc$eax 0x0000006f
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1279		ret

$pc         x/i $pc$eax 0x0000006f
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_WORD () at jonesforth.S:1394
1394		cmpb $'\n',%al		// end of line yet?

$pc         x/i $pc$eax 0x0000006f
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1395		jne 3b

$pc         x/i $pc$eax 0x0000006f
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1393		call _KEY

$pc         x/i $pc$eax 0x0000006f
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_KEY () at jonesforth.S:1272
1272		mov (currkey),%ebx

$pc         x/i $pc$eax 0x0000006f
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1273		cmp (bufftop),%ebx

$pc         x/i $pc$eax 0x0000006f
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1274		jge 1f			// exhausted the input buffer?

$pc         x/i $pc$eax 0x0000006f
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1275		xor %eax,%eax

$pc         x/i $pc$eax 0x0000006f
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1276		mov (%ebx),%al		// get next key from input buffer

$pc         x/i $pc$eax 0x00000000
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1277		inc %ebx

$pc         x/i $pc$eax 0x00000072
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1278		mov %ebx,(currkey)	// increment currkey

$pc         x/i $pc$eax 0x00000072
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1279		ret

$pc         x/i $pc$eax 0x00000072
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_WORD () at jonesforth.S:1394
1394		cmpb $'\n',%al		// end of line yet?

$pc         x/i $pc$eax 0x00000072
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1395		jne 3b

$pc         x/i $pc$eax 0x00000072
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1393		call _KEY

$pc         x/i $pc$eax 0x00000072
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_KEY () at jonesforth.S:1272
1272		mov (currkey),%ebx

$pc         x/i $pc$eax 0x00000072
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1273		cmp (bufftop),%ebx

$pc         x/i $pc$eax 0x00000072
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1274		jge 1f			// exhausted the input buffer?

$pc         x/i $pc$eax 0x00000072
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1275		xor %eax,%eax

$pc         x/i $pc$eax 0x00000072
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1276		mov (%ebx),%al		// get next key from input buffer

$pc         x/i $pc$eax 0x00000000
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1277		inc %ebx

$pc         x/i $pc$eax 0x00000069
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1278		mov %ebx,(currkey)	// increment currkey

$pc         x/i $pc$eax 0x00000069
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1279		ret

$pc         x/i $pc$eax 0x00000069
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_WORD () at jonesforth.S:1394
1394		cmpb $'\n',%al		// end of line yet?

$pc         x/i $pc$eax 0x00000069
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1395		jne 3b

$pc         x/i $pc$eax 0x00000069
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1393		call _KEY

$pc         x/i $pc$eax 0x00000069
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_KEY () at jonesforth.S:1272
1272		mov (currkey),%ebx

$pc         x/i $pc$eax 0x00000069
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1273		cmp (bufftop),%ebx

$pc         x/i $pc$eax 0x00000069
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1274		jge 1f			// exhausted the input buffer?

$pc         x/i $pc$eax 0x00000069
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1275		xor %eax,%eax

$pc         x/i $pc$eax 0x00000069
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1276		mov (%ebx),%al		// get next key from input buffer

$pc         x/i $pc$eax 0x00000000
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1277		inc %ebx

$pc         x/i $pc$eax 0x00000061
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1278		mov %ebx,(currkey)	// increment currkey

$pc         x/i $pc$eax 0x00000061
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1279		ret

$pc         x/i $pc$eax 0x00000061
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_WORD () at jonesforth.S:1394
1394		cmpb $'\n',%al		// end of line yet?

$pc         x/i $pc$eax 0x00000061
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1395		jne 3b

$pc         x/i $pc$eax 0x00000061
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1393		call _KEY

$pc         x/i $pc$eax 0x00000061
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_KEY () at jonesforth.S:1272
1272		mov (currkey),%ebx

$pc         x/i $pc$eax 0x00000061
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1273		cmp (bufftop),%ebx

$pc         x/i $pc$eax 0x00000061
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1274		jge 1f			// exhausted the input buffer?

$pc         x/i $pc$eax 0x00000061
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1275		xor %eax,%eax

$pc         x/i $pc$eax 0x00000061
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1276		mov (%ebx),%al		// get next key from input buffer

$pc         x/i $pc$eax 0x00000000
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1277		inc %ebx

$pc         x/i $pc$eax 0x0000006c
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1278		mov %ebx,(currkey)	// increment currkey

$pc         x/i $pc$eax 0x0000006c
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1279		ret

$pc         x/i $pc$eax 0x0000006c
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_WORD () at jonesforth.S:1394
1394		cmpb $'\n',%al		// end of line yet?

$pc         x/i $pc$eax 0x0000006c
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1395		jne 3b

$pc         x/i $pc$eax 0x0000006c
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1393		call _KEY

$pc         x/i $pc$eax 0x0000006c
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_KEY () at jonesforth.S:1272
1272		mov (currkey),%ebx

$pc         x/i $pc$eax 0x0000006c
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1273		cmp (bufftop),%ebx

$pc         x/i $pc$eax 0x0000006c
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1274		jge 1f			// exhausted the input buffer?

$pc         x/i $pc$eax 0x0000006c
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1275		xor %eax,%eax

$pc         x/i $pc$eax 0x0000006c
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1276		mov (%ebx),%al		// get next key from input buffer

$pc         x/i $pc$eax 0x00000000
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1277		inc %ebx

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1278		mov %ebx,(currkey)	// increment currkey

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1279		ret

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_WORD () at jonesforth.S:1394
1394		cmpb $'\n',%al		// end of line yet?

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1395		jne 3b

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1393		call _KEY

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_KEY () at jonesforth.S:1272
1272		mov (currkey),%ebx

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1273		cmp (bufftop),%ebx

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1274		jge 1f			// exhausted the input buffer?

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1275		xor %eax,%eax

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1276		mov (%ebx),%al		// get next key from input buffer

$pc         x/i $pc$eax 0x00000000
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1277		inc %ebx

$pc         x/i $pc$eax 0x00000066
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1278		mov %ebx,(currkey)	// increment currkey

$pc         x/i $pc$eax 0x00000066
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1279		ret

$pc         x/i $pc$eax 0x00000066
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_WORD () at jonesforth.S:1394
1394		cmpb $'\n',%al		// end of line yet?

$pc         x/i $pc$eax 0x00000066
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1395		jne 3b

$pc         x/i $pc$eax 0x00000066
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1393		call _KEY

$pc         x/i $pc$eax 0x00000066
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_KEY () at jonesforth.S:1272
1272		mov (currkey),%ebx

$pc         x/i $pc$eax 0x00000066
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1273		cmp (bufftop),%ebx

$pc         x/i $pc$eax 0x00000066
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1274		jge 1f			// exhausted the input buffer?

$pc         x/i $pc$eax 0x00000066
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1275		xor %eax,%eax

$pc         x/i $pc$eax 0x00000066
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1276		mov (%ebx),%al		// get next key from input buffer

$pc         x/i $pc$eax 0x00000000
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1277		inc %ebx

$pc         x/i $pc$eax 0x0000006f
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1278		mov %ebx,(currkey)	// increment currkey

$pc         x/i $pc$eax 0x0000006f
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1279		ret

$pc         x/i $pc$eax 0x0000006f
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_WORD () at jonesforth.S:1394
1394		cmpb $'\n',%al		// end of line yet?

$pc         x/i $pc$eax 0x0000006f
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1395		jne 3b

$pc         x/i $pc$eax 0x0000006f
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1393		call _KEY

$pc         x/i $pc$eax 0x0000006f
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_KEY () at jonesforth.S:1272
1272		mov (currkey),%ebx

$pc         x/i $pc$eax 0x0000006f
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1273		cmp (bufftop),%ebx

$pc         x/i $pc$eax 0x0000006f
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1274		jge 1f			// exhausted the input buffer?

$pc         x/i $pc$eax 0x0000006f
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1275		xor %eax,%eax

$pc         x/i $pc$eax 0x0000006f
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1276		mov (%ebx),%al		// get next key from input buffer

$pc         x/i $pc$eax 0x00000000
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1277		inc %ebx

$pc         x/i $pc$eax 0x00000072
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1278		mov %ebx,(currkey)	// increment currkey

$pc         x/i $pc$eax 0x00000072
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1279		ret

$pc         x/i $pc$eax 0x00000072
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_WORD () at jonesforth.S:1394
1394		cmpb $'\n',%al		// end of line yet?

$pc         x/i $pc$eax 0x00000072
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1395		jne 3b

$pc         x/i $pc$eax 0x00000072
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1393		call _KEY

$pc         x/i $pc$eax 0x00000072
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_KEY () at jonesforth.S:1272
1272		mov (currkey),%ebx

$pc         x/i $pc$eax 0x00000072
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1273		cmp (bufftop),%ebx

$pc         x/i $pc$eax 0x00000072
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1274		jge 1f			// exhausted the input buffer?

$pc         x/i $pc$eax 0x00000072
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1275		xor %eax,%eax

$pc         x/i $pc$eax 0x00000072
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1276		mov (%ebx),%al		// get next key from input buffer

$pc         x/i $pc$eax 0x00000000
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1277		inc %ebx

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1278		mov %ebx,(currkey)	// increment currkey

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1279		ret

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_WORD () at jonesforth.S:1394
1394		cmpb $'\n',%al		// end of line yet?

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1395		jne 3b

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1393		call _KEY

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_KEY () at jonesforth.S:1272
1272		mov (currkey),%ebx

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1273		cmp (bufftop),%ebx

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1274		jge 1f			// exhausted the input buffer?

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1275		xor %eax,%eax

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1276		mov (%ebx),%al		// get next key from input buffer

$pc         x/i $pc$eax 0x00000000
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1277		inc %ebx

$pc         x/i $pc$eax 0x0000004c
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1278		mov %ebx,(currkey)	// increment currkey

$pc         x/i $pc$eax 0x0000004c
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1279		ret

$pc         x/i $pc$eax 0x0000004c
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_WORD () at jonesforth.S:1394
1394		cmpb $'\n',%al		// end of line yet?

$pc         x/i $pc$eax 0x0000004c
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1395		jne 3b

$pc         x/i $pc$eax 0x0000004c
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1393		call _KEY

$pc         x/i $pc$eax 0x0000004c
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_KEY () at jonesforth.S:1272
1272		mov (currkey),%ebx

$pc         x/i $pc$eax 0x0000004c
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1273		cmp (bufftop),%ebx

$pc         x/i $pc$eax 0x0000004c
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1274		jge 1f			// exhausted the input buffer?

$pc         x/i $pc$eax 0x0000004c
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1275		xor %eax,%eax

$pc         x/i $pc$eax 0x0000004c
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1276		mov (%ebx),%al		// get next key from input buffer

$pc         x/i $pc$eax 0x00000000
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1277		inc %ebx

$pc         x/i $pc$eax 0x00000069
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1278		mov %ebx,(currkey)	// increment currkey

$pc         x/i $pc$eax 0x00000069
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1279		ret

$pc         x/i $pc$eax 0x00000069
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_WORD () at jonesforth.S:1394
1394		cmpb $'\n',%al		// end of line yet?

$pc         x/i $pc$eax 0x00000069
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1395		jne 3b

$pc         x/i $pc$eax 0x00000069
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1393		call _KEY

$pc         x/i $pc$eax 0x00000069
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_KEY () at jonesforth.S:1272
1272		mov (currkey),%ebx

$pc         x/i $pc$eax 0x00000069
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1273		cmp (bufftop),%ebx

$pc         x/i $pc$eax 0x00000069
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1274		jge 1f			// exhausted the input buffer?

$pc         x/i $pc$eax 0x00000069
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1275		xor %eax,%eax

$pc         x/i $pc$eax 0x00000069
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1276		mov (%ebx),%al		// get next key from input buffer

$pc         x/i $pc$eax 0x00000000
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1277		inc %ebx

$pc         x/i $pc$eax 0x0000006e
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1278		mov %ebx,(currkey)	// increment currkey

$pc         x/i $pc$eax 0x0000006e
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1279		ret

$pc         x/i $pc$eax 0x0000006e
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_WORD () at jonesforth.S:1394
1394		cmpb $'\n',%al		// end of line yet?

$pc         x/i $pc$eax 0x0000006e
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1395		jne 3b

$pc         x/i $pc$eax 0x0000006e
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1393		call _KEY

$pc         x/i $pc$eax 0x0000006e
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_KEY () at jonesforth.S:1272
1272		mov (currkey),%ebx

$pc         x/i $pc$eax 0x0000006e
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1273		cmp (bufftop),%ebx

$pc         x/i $pc$eax 0x0000006e
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1274		jge 1f			// exhausted the input buffer?

$pc         x/i $pc$eax 0x0000006e
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1275		xor %eax,%eax

$pc         x/i $pc$eax 0x0000006e
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1276		mov (%ebx),%al		// get next key from input buffer

$pc         x/i $pc$eax 0x00000000
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1277		inc %ebx

$pc         x/i $pc$eax 0x00000075
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1278		mov %ebx,(currkey)	// increment currkey

$pc         x/i $pc$eax 0x00000075
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1279		ret

$pc         x/i $pc$eax 0x00000075
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_WORD () at jonesforth.S:1394
1394		cmpb $'\n',%al		// end of line yet?

$pc         x/i $pc$eax 0x00000075
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1395		jne 3b

$pc         x/i $pc$eax 0x00000075
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1393		call _KEY

$pc         x/i $pc$eax 0x00000075
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_KEY () at jonesforth.S:1272
1272		mov (currkey),%ebx

$pc         x/i $pc$eax 0x00000075
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1273		cmp (bufftop),%ebx

$pc         x/i $pc$eax 0x00000075
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1274		jge 1f			// exhausted the input buffer?

$pc         x/i $pc$eax 0x00000075
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1275		xor %eax,%eax

$pc         x/i $pc$eax 0x00000075
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1276		mov (%ebx),%al		// get next key from input buffer

$pc         x/i $pc$eax 0x00000000
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1277		inc %ebx

$pc         x/i $pc$eax 0x00000078
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1278		mov %ebx,(currkey)	// increment currkey

$pc         x/i $pc$eax 0x00000078
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1279		ret

$pc         x/i $pc$eax 0x00000078
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_WORD () at jonesforth.S:1394
1394		cmpb $'\n',%al		// end of line yet?

$pc         x/i $pc$eax 0x00000078
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1395		jne 3b

$pc         x/i $pc$eax 0x00000078
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1393		call _KEY

$pc         x/i $pc$eax 0x00000078
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_KEY () at jonesforth.S:1272
1272		mov (currkey),%ebx

$pc         x/i $pc$eax 0x00000078
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1273		cmp (bufftop),%ebx

$pc         x/i $pc$eax 0x00000078
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1274		jge 1f			// exhausted the input buffer?

$pc         x/i $pc$eax 0x00000078
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1275		xor %eax,%eax

$pc         x/i $pc$eax 0x00000078
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1276		mov (%ebx),%al		// get next key from input buffer

$pc         x/i $pc$eax 0x00000000
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1277		inc %ebx

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1278		mov %ebx,(currkey)	// increment currkey

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1279		ret

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_WORD () at jonesforth.S:1394
1394		cmpb $'\n',%al		// end of line yet?

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1395		jne 3b

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1393		call _KEY

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_KEY () at jonesforth.S:1272
1272		mov (currkey),%ebx

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1273		cmp (bufftop),%ebx

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1274		jge 1f			// exhausted the input buffer?

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1275		xor %eax,%eax

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1276		mov (%ebx),%al		// get next key from input buffer

$pc         x/i $pc$eax 0x00000000
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1277		inc %ebx

$pc         x/i $pc$eax 0x0000002f
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1278		mov %ebx,(currkey)	// increment currkey

$pc         x/i $pc$eax 0x0000002f
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1279		ret

$pc         x/i $pc$eax 0x0000002f
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_WORD () at jonesforth.S:1394
1394		cmpb $'\n',%al		// end of line yet?

$pc         x/i $pc$eax 0x0000002f
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1395		jne 3b

$pc         x/i $pc$eax 0x0000002f
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1393		call _KEY

$pc         x/i $pc$eax 0x0000002f
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_KEY () at jonesforth.S:1272
1272		mov (currkey),%ebx

$pc         x/i $pc$eax 0x0000002f
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1273		cmp (bufftop),%ebx

$pc         x/i $pc$eax 0x0000002f
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1274		jge 1f			// exhausted the input buffer?

$pc         x/i $pc$eax 0x0000002f
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1275		xor %eax,%eax

$pc         x/i $pc$eax 0x0000002f
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1276		mov (%ebx),%al		// get next key from input buffer

$pc         x/i $pc$eax 0x00000000
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1277		inc %ebx

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1278		mov %ebx,(currkey)	// increment currkey

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1279		ret

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_WORD () at jonesforth.S:1394
1394		cmpb $'\n',%al		// end of line yet?

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1395		jne 3b

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1393		call _KEY

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_KEY () at jonesforth.S:1272
1272		mov (currkey),%ebx

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1273		cmp (bufftop),%ebx

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1274		jge 1f			// exhausted the input buffer?

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1275		xor %eax,%eax

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1276		mov (%ebx),%al		// get next key from input buffer

$pc         x/i $pc$eax 0x00000000
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1277		inc %ebx

$pc         x/i $pc$eax 0x00000069
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1278		mov %ebx,(currkey)	// increment currkey

$pc         x/i $pc$eax 0x00000069
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1279		ret

$pc         x/i $pc$eax 0x00000069
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_WORD () at jonesforth.S:1394
1394		cmpb $'\n',%al		// end of line yet?

$pc         x/i $pc$eax 0x00000069
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1395		jne 3b

$pc         x/i $pc$eax 0x00000069
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1393		call _KEY

$pc         x/i $pc$eax 0x00000069
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_KEY () at jonesforth.S:1272
1272		mov (currkey),%ebx

$pc         x/i $pc$eax 0x00000069
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1273		cmp (bufftop),%ebx

$pc         x/i $pc$eax 0x00000069
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1274		jge 1f			// exhausted the input buffer?

$pc         x/i $pc$eax 0x00000069
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1275		xor %eax,%eax

$pc         x/i $pc$eax 0x00000069
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1276		mov (%ebx),%al		// get next key from input buffer

$pc         x/i $pc$eax 0x00000000
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1277		inc %ebx

$pc         x/i $pc$eax 0x00000033
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1278		mov %ebx,(currkey)	// increment currkey

$pc         x/i $pc$eax 0x00000033
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1279		ret

$pc         x/i $pc$eax 0x00000033
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_WORD () at jonesforth.S:1394
1394		cmpb $'\n',%al		// end of line yet?

$pc         x/i $pc$eax 0x00000033
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1395		jne 3b

$pc         x/i $pc$eax 0x00000033
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1393		call _KEY

$pc         x/i $pc$eax 0x00000033
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_KEY () at jonesforth.S:1272
1272		mov (currkey),%ebx

$pc         x/i $pc$eax 0x00000033
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1273		cmp (bufftop),%ebx

$pc         x/i $pc$eax 0x00000033
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1274		jge 1f			// exhausted the input buffer?

$pc         x/i $pc$eax 0x00000033
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1275		xor %eax,%eax

$pc         x/i $pc$eax 0x00000033
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1276		mov (%ebx),%al		// get next key from input buffer

$pc         x/i $pc$eax 0x00000000
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1277		inc %ebx

$pc         x/i $pc$eax 0x00000038
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1278		mov %ebx,(currkey)	// increment currkey

$pc         x/i $pc$eax 0x00000038
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1279		ret

$pc         x/i $pc$eax 0x00000038
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_WORD () at jonesforth.S:1394
1394		cmpb $'\n',%al		// end of line yet?

$pc         x/i $pc$eax 0x00000038
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1395		jne 3b

$pc         x/i $pc$eax 0x00000038
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1393		call _KEY

$pc         x/i $pc$eax 0x00000038
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_KEY () at jonesforth.S:1272
1272		mov (currkey),%ebx

$pc         x/i $pc$eax 0x00000038
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1273		cmp (bufftop),%ebx

$pc         x/i $pc$eax 0x00000038
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1274		jge 1f			// exhausted the input buffer?

$pc         x/i $pc$eax 0x00000038
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1275		xor %eax,%eax

$pc         x/i $pc$eax 0x00000038
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1276		mov (%ebx),%al		// get next key from input buffer

$pc         x/i $pc$eax 0x00000000
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1277		inc %ebx

$pc         x/i $pc$eax 0x00000036
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1278		mov %ebx,(currkey)	// increment currkey

$pc         x/i $pc$eax 0x00000036
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1279		ret

$pc         x/i $pc$eax 0x00000036
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_WORD () at jonesforth.S:1394
1394		cmpb $'\n',%al		// end of line yet?

$pc         x/i $pc$eax 0x00000036
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1395		jne 3b

$pc         x/i $pc$eax 0x00000036
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1393		call _KEY

$pc         x/i $pc$eax 0x00000036
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_KEY () at jonesforth.S:1272
1272		mov (currkey),%ebx

$pc         x/i $pc$eax 0x00000036
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1273		cmp (bufftop),%ebx

$pc         x/i $pc$eax 0x00000036
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1274		jge 1f			// exhausted the input buffer?

$pc         x/i $pc$eax 0x00000036
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1275		xor %eax,%eax

$pc         x/i $pc$eax 0x00000036
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1276		mov (%ebx),%al		// get next key from input buffer

$pc         x/i $pc$eax 0x00000000
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1277		inc %ebx

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1278		mov %ebx,(currkey)	// increment currkey

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1279		ret

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_WORD () at jonesforth.S:1394
1394		cmpb $'\n',%al		// end of line yet?

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1395		jne 3b

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1393		call _KEY

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_KEY () at jonesforth.S:1272
1272		mov (currkey),%ebx

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1273		cmp (bufftop),%ebx

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1274		jge 1f			// exhausted the input buffer?

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1275		xor %eax,%eax

$pc         x/i $pc$eax 0x00000020
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1276		mov (%ebx),%al		// get next key from input buffer

$pc         x/i $pc$eax 0x00000000
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1277		inc %ebx

$pc         x/i $pc$eax 0x00000073
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1278		mov %ebx,(currkey)	// increment currkey

$pc         x/i $pc$eax 0x00000073
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1279		ret

$pc         x/i $pc$eax 0x00000073
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_WORD () at jonesforth.S:1394
1394		cmpb $'\n',%al		// end of line yet?

$pc         x/i $pc$eax 0x00000073
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1395		jne 3b

$pc         x/i $pc$eax 0x00000073
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1393		call _KEY

$pc         x/i $pc$eax 0x00000073
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_KEY () at jonesforth.S:1272
1272		mov (currkey),%ebx

$pc         x/i $pc$eax 0x00000073
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1273		cmp (bufftop),%ebx

$pc         x/i $pc$eax 0x00000073
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1274		jge 1f			// exhausted the input buffer?

$pc         x/i $pc$eax 0x00000073
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1275		xor %eax,%eax

$pc         x/i $pc$eax 0x00000073
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1276		mov (%ebx),%al		// get next key from input buffer

$pc         x/i $pc$eax 0x00000000
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1277		inc %ebx

$pc         x/i $pc$eax 0x00000079
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1278		mov %ebx,(currkey)	// increment currkey

$pc         x/i $pc$eax 0x00000079
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1279		ret

$pc         x/i $pc$eax 0x00000079
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_WORD () at jonesforth.S:1394
1394		cmpb $'\n',%al		// end of line yet?

$pc         x/i $pc$eax 0x00000079
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1395		jne 3b

$pc         x/i $pc$eax 0x00000079
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1393		call _KEY

$pc         x/i $pc$eax 0x00000079
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_KEY () at jonesforth.S:1272
1272		mov (currkey),%ebx

$pc         x/i $pc$eax 0x00000079
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1273		cmp (bufftop),%ebx

$pc         x/i $pc$eax 0x00000079
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1274		jge 1f			// exhausted the input buffer?

$pc         x/i $pc$eax 0x00000079
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1275		xor %eax,%eax

$pc         x/i $pc$eax 0x00000079
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1276		mov (%ebx),%al		// get next key from input buffer

$pc         x/i $pc$eax 0x00000000
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1277		inc %ebx

$pc         x/i $pc$eax 0x00000073
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1278		mov %ebx,(currkey)	// increment currkey

$pc         x/i $pc$eax 0x00000073
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1279		ret

$pc         x/i $pc$eax 0x00000073
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_WORD () at jonesforth.S:1394
1394		cmpb $'\n',%al		// end of line yet?

$pc         x/i $pc$eax 0x00000073
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1395		jne 3b

$pc         x/i $pc$eax 0x00000073
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1393		call _KEY

$pc         x/i $pc$eax 0x00000073
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_KEY () at jonesforth.S:1272
1272		mov (currkey),%ebx

$pc         x/i $pc$eax 0x00000073
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1273		cmp (bufftop),%ebx

$pc         x/i $pc$eax 0x00000073
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1274		jge 1f			// exhausted the input buffer?

$pc         x/i $pc$eax 0x00000073
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1275		xor %eax,%eax

$pc         x/i $pc$eax 0x00000073
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1276		mov (%ebx),%al		// get next key from input buffer

$pc         x/i $pc$eax 0x00000000
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1277		inc %ebx

$pc         x/i $pc$eax 0x00000074
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1278		mov %ebx,(currkey)	// increment currkey

$pc         x/i $pc$eax 0x00000074
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1279		ret

$pc         x/i $pc$eax 0x00000074
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_WORD () at jonesforth.S:1394
1394		cmpb $'\n',%al		// end of line yet?

$pc         x/i $pc$eax 0x00000074
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1395		jne 3b

$pc         x/i $pc$eax 0x00000074
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1393		call _KEY

$pc         x/i $pc$eax 0x00000074
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_KEY () at jonesforth.S:1272
1272		mov (currkey),%ebx

$pc         x/i $pc$eax 0x00000074
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1273		cmp (bufftop),%ebx

$pc         x/i $pc$eax 0x00000074
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1274		jge 1f			// exhausted the input buffer?

$pc         x/i $pc$eax 0x00000074
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1275		xor %eax,%eax

$pc         x/i $pc$eax 0x00000074
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1276		mov (%ebx),%al		// get next key from input buffer

$pc         x/i $pc$eax 0x00000000
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1277		inc %ebx

$pc         x/i $pc$eax 0x00000065
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1278		mov %ebx,(currkey)	// increment currkey

$pc         x/i $pc$eax 0x00000065
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1279		ret

$pc         x/i $pc$eax 0x00000065
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
_WORD () at jonesforth.S:1394
1394		cmpb $'\n',%al		// end of line yet?

$pc         x/i $pc$eax 0x00000065
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp--------------------
1395		jne 3b

$pc         x/i $pc$eax 0x00000065
$esi 0x0804a634  QUIT + 16
$esp         x/4dw $esp``` 
