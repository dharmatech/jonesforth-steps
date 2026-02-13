
source ../python-gdb-ui/gdb_program_ui.py

define show-data

    echo $pc \ 
    x/i $pc
    ui-reg eax
    ui-reg ebx
    ui-reg esi

    # if $edi >= 0x08000000
    #     echo $edi \ 
    #     x/4dw $edi
    # end

    # x/4dw $edi

    ui-reg edi

    echo $esp \ 
    x/4dw $esp

    ui-mem &currkey
    ui-mem &bufftop
    echo &return_stack     \ 
    x/3xw &return_stack
    echo &return_stack_top \ 
    x/3xw &return_stack_top
    echo &buffer           \ 
    x/3xw &buffer

end