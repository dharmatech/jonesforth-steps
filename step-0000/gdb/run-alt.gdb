
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

echo \n

echo ``` \n

source ../python-gdb-ui/gdb_program_ui.py

# ui-text
# ui-rodata
ui-sections

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
