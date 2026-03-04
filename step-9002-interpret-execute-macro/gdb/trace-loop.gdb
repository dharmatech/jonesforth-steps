
set pagination off

source ../python-gdb-ui/gdb_program_ui.py

# break _WORD
break code_INTERPRET

# break code_WORD
# break code_FIND

# break _WORD
# break _FIND
break DOCOL

# set variable $action = 0
set variable $action = 1

# define trace-loop

#     # set pagination off

#     # while (1 < 2)
#     while (*(int*)$esp != 123)    

#         # print ($pc >= _KEY) && ($pc < _KEY_end)

#         # print ((unsigned int)$pc >= (unsigned int)&_KEY) && ((unsigned int)$pc < (unsigned int)&_KEY_end)


#         # if ($pc >= _KEY) && ($pc < _KEY_end)
#         if (((unsigned int)$pc >= (unsigned int)&_KEY) && ((unsigned int)$pc < (unsigned int)&_KEY_end)) || (((unsigned int)$pc >= (unsigned int)&_FIND) && ((unsigned int)$pc < (unsigned int)&_FIND_end))
#             # Return address for current _KEY call is at top of stack.
            
#             # tbreak *(*(void **)$esp)

#             # set $ret = *(unsigned int *)$esp
#             # tbreak *$ret            

#             continue
#             # stepi
#         else
#             if ((unsigned int)$pc >= (unsigned int)&_NUMBER) && ((unsigned int)$pc < (unsigned int)&_NUMBER_end)
#                 continue
#             else
#                 if $action == 0
#                     continue
#                 else
#                     if $action == 1
#                         stepi
#                     end
#                 end
#             end
#         end
        
#         # x/i $pc


#         # if $action == 0
#         #     continue
#         # else
#         #     if $action == 1
#         #         stepi
#         #     end
#         # end
        
#         # stepi
#         # continue

#         # x %eax
#         # print/x $eax
#         # printf "pc=%#x eax=%#x\n", $pc, $eax
#         # ui-reg pc
#         x/i $pc
#         # ui-reg eax
#         # ui-reg ebx
#         # ui-reg esi
#         # echo edi \ 
#         # x/4dw $edi
#         # ui-mem &currkey
#         # ui-mem &bufftop
#         # ui-buffer
        
#         # echo (*(int*)$esp)$esp \ 
#         # print (*(int*)$esp)
#         # print (*(int*)$esp == 123)

#         echo &return_stack     \ 
#         x/3xw &return_stack
#         echo &return_stack_top \ 
#         x/3xw &return_stack_top
#         echo data stack: \ 
#         x/8dw $esp
#         echo --------------------------------------------------\n

#         # if (*(int*)$esp == 123)
#         #     break
#         # end
#     end
# end





define show-state
    print/x $eax
    printf "pc=%#x eax=%#x\n", $pc, $eax
    ui-reg pc
    x/i $pc
    ui-reg eax
    ui-reg ebx
    ui-reg esi
    echo edi \ 
    x/4dw $edi
    ui-mem &currkey
    ui-mem &bufftop
    ui-buffer

    echo &return_stack     \ 
    x/3xw &return_stack
    echo &return_stack_top \ 
    x/3xw &return_stack_top
    echo data stack: \ 
    x/8dw $esp
    echo --------------------------------------------------\n
end

# define trace-loop
#     while 1
#         show-state
#     end
# end
