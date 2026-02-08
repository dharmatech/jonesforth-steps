set disassemble-next-line on

break _start
break code_LIT
break code_ADD
break code_BYE

display/i $pc
display/x $eax
display/x $esi
display/x $esp

echo \nPreloaded commands active. Type 'run' to start.\n
