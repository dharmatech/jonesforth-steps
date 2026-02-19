set pagination off
set confirm off

source gdb/jf_test.py
jf-config abc 123
jf-config bcd 234

break code_INTERPRET
commands
  silent
  jf-update
  continue
end

catch syscall write
commands
  silent
  jf-check-parse-error
  continue
end

catch signal SIGSEGV
commands
  silent
  printf "FAIL: received SIGSEGV\n"
  quit 1
end

run < tests/test_define_abc_123.f

jf-assert
quit 0
