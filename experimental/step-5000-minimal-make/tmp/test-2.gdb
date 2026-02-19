delete breakpoints
source gdb/forth-dict.gdb
break code_LBRAC if *(int*)var_STATE != 0
commands
  silent
  forth-dict 5
  echo ----\n
  continue
end
run < examples/words.f

