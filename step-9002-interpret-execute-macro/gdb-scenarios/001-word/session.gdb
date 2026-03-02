# Scenario 001: explore _WORD state evolution while stepping.

set pagination off
set confirm off

source gdb-scenarios/common.gdb
source ../python-gdb-ui/gdb_program_ui.py

delete breakpoints
break _WORD

define word-run
  run < gdb-scenarios/001-word/input.f
end

document word-run
Run jonesforth with this scenario input and stop at _WORD.
end

define word-show
  x/i $pc
  ui-reg eax ecx edx esi edi
  ui-mem &currkey
  ui-mem &bufftop
  ui-buffer
  echo &word_buffer (bytes)

  x/32cb &word_buffer
  echo &word_buffer (string, best effort)

  x/s &word_buffer
end

document word-show
Show _WORD-related execution state and current word_buffer contents.
end

define word-step
  stepi
  word-show
end

document word-step
Step one instruction and show _WORD-related state.
end

define word-steps
  if $argc == 0
    set $n = 1
  else
    set $n = $arg0
  end
  while $n > 0
    word-step
    echo --------------------\n
    set $n = $n - 1
  end
end

document word-steps
Run word-step N times (default: 1).
end

define word-go
  continue
end

document word-go
Continue execution to the next stop.
end

scenario-ui-on

echo Scenario 001 (_WORD) loaded.\n
echo Use: word-run, word-show, word-step, word-steps N, word-go\n
