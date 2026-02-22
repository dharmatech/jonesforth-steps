# Scenario 003: explore INTERPRET state evolution while stepping.

set pagination off
set confirm off

source gdb-scenarios/common.gdb
source ../python-gdb-ui/gdb_program_ui.py

delete breakpoints
break code_INTERPRET

define interpret-run
  run < gdb-scenarios/003-interpret/input.f
end

document interpret-run
Run jonesforth with this scenario input and stop at INTERPRET.
end

define interpret-show
  x/i $pc
  ui-reg eax ebx ecx edx esi edi
  ui-mem &var_STATE
  ui-mem &interpret_is_lit
  ui-mem &currkey
  ui-mem &bufftop
  ui-buffer
  echo &word_buffer (bytes)

  x/32cb &word_buffer
  echo &word_buffer (string, best effort)

  x/s &word_buffer
end

document interpret-show
Show INTERPRET-related state including parser flags and buffers.
end

define interpret-step
  stepi
  interpret-show
end

document interpret-step
Step one instruction and show INTERPRET-related state.
end

define interpret-steps
  if $argc == 0
    set $n = 1
  else
    set $n = $arg0
  end
  while $n > 0
    interpret-step
    echo --------------------\n
    set $n = $n - 1
  end
end

document interpret-steps
Run interpret-step N times (default: 1).
end

define interpret-go
  continue
end

document interpret-go
Continue execution to the next stop.
end

define interpret-continue
  continue
  interpret-show
end

document interpret-continue
Continue to the next INTERPRET breakpoint and then show state.
end

define interpret-next
  next
  interpret-show
end

document interpret-next
Run gdb 'next' and then show INTERPRET-related state.
end

scenario-ui-on

echo Scenario 003 (INTERPRET) loaded.\n
echo Use: interpret-run, interpret-show, interpret-step, interpret-steps N, interpret-go, interpret-continue, interpret-next\n
