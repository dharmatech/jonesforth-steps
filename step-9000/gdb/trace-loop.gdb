
source ../python-gdb-ui/gdb_program_ui.py

define trace-loop

    # set pagination off

    while (1 < 2)
        stepi
        # x %eax
        # print/x $eax
        # printf "pc=%#x eax=%#x\n", $pc, $eax
        # ui-reg pc
        x/i $pc
        ui-reg eax
        ui-reg ebx
        ui-reg esi
        echo edi \ 
        x/4dw $edi
        ui-mem &currkey
        ui-mem &bufftop
        echo &return_stack     \ 
        x/3xw &return_stack
        echo &return_stack_top \ 
        x/3xw &return_stack_top
        echo &buffer           \ 
        x/3xw &buffer
        echo --------------------------------------------------\n
    end
end