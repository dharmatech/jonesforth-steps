
# Tips:
# vim: Use * to highlight symbol under cursor

set logging file trace.md
set logging overwrite on
set logging enabled on

echo # JonesForth Step-0000 GDB Session \n

echo ## Help \n

echo ### nvim \n

echo ``` \n
echo  *    Highlight item under cursor \n
echo ``` \n

echo ### Emacs \n

echo ``` \n
echo M-s h .     Highlight item under cursor \n
echo ``` \n

echo # Setup \n

echo ``` \n
break _start

# display/i $pc
# display/x   $eax
# display/x   $esi
# display/4dw $esp

run

set pagination off

echo ``` \n

echo \n
echo # `info files` \n

echo ``` \n
info files
echo ``` \n

echo \n
echo # `info proc mappings` \n

echo ``` \n
info proc mappings
echo ``` \n



echo \n
echo # Memory Map Visualization \n

set $text_start   = (unsigned int)code_LIT
set $text_end     = (unsigned int)_start + 18
set $rodata_start = (unsigned int)&LIT
set $rodata_end   = (unsigned int)&cold_start + 24
set $rodata_words = ($rodata_end - $rodata_start) / 4

# echo ## Anchors \n

# echo ``` \n
# printf "code_LIT    = 0x%08x\n", (unsigned int)code_LIT
# printf "_start      = 0x%08x\n", (unsigned int)_start
# printf "&LIT        = 0x%08x\n", (unsigned int)&LIT
# printf "&DUP        = 0x%08x\n", (unsigned int)&DUP
# printf "&DROP       = 0x%08x\n", (unsigned int)&DROP
# printf "&ADD        = 0x%08x\n", (unsigned int)&ADD
# printf "&BYE        = 0x%08x\n", (unsigned int)&BYE
# printf "&cold_start = 0x%08x\n", (unsigned int)&cold_start
# echo ``` \n

echo \n
# echo ## .text (disassemble with opcode bytes) \n

# echo ``` \n
# disassemble /r $text_start, $text_end
# echo ``` \n

# echo \n-- .rodata (32-bit words) --\n
# eval "x/%dxw $rodata_start", $rodata_words

# echo \n
# echo .rodata\n

# x/1xw $rodata_start
# x/1xw
# x/1xw
# x/1xw
# x/1xw
# x/1xw

echo \n
# echo ## .rodata \n

# printf "&LIT = 0x%08x   0x%08x\n", (unsigned int)&LIT, *(unsigned int*)&LIT

# echo ``` \n
# printf "LIT   0x%08x   0x%08x\n", &LIT,  (unsigned int)LIT
# printf "DUP   0x%08x   0x%08x\n", &DUP,  (unsigned int)DUP
# printf "DROP  0x%08x   0x%08x\n", &DROP, (unsigned int)DROP
# printf "ADD   0x%08x   0x%08x\n", &ADD,  (unsigned int)ADD
# printf "BYE   0x%08x   0x%08x\n", &BYE,  (unsigned int)BYE

echo \n

# printf "cold_start 0x%08x   0x%08x\n", &cold_start,  *(unsigned int*)&cold_start
# printf "           0x%08x   0x%08x\n", (int)&cold_start + 4,  *(unsigned int*)&cold_start
# printf "           0x%08x   0x%08x\n", (int)&cold_start + 4,  *(unsigned int*) ((int)&cold_start + 4)
echo \n

# x/1xw &cold_start
# x/1xw 
# x/1xw
# x/1xw
# x/1xw
# x/1xw
echo ``` \n

source ../python-gdb-ui/gdb_program_ui.py

# ui-text
# ui-rodata
ui-sections

# printf "&LIT = 0x%08x   0x%08x\n", LIT, *(unsigned int*)&LIT

echo \n
echo # Single Stepping \n

echo ``` \n
set $n = 1000
while $n > 0    &&    $_isvoid($_exitcode)
    # echo \n

    echo --------------------\n
    stepi    

    echo \n

    if $_isvoid($_exitcode)
        echo $pc \ 
        x/i   $pc
        ui-reg eax
        ui-reg esi
        echo $esp \ 
        x/4dw $esp
    end
           
    set $n = $n - 1
end
echo ``` \n

set logging enabled off
