delete breakpoints
source gdb/forth-dict.gdb
break code_LBRAC if $ecx == 1 && *(char *)&word_buffer == ';'
commands
  silent
  forth-dict 20
  echo ----\n
  continue
end
run < examples/words.f
