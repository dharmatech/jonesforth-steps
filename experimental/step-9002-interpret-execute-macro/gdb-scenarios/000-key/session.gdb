# Scenario 000: explore _KEY state evolution while stepping.

set pagination off
set confirm off

source gdb-scenarios/common.gdb
source ../python-gdb-ui/gdb_program_ui.py

delete breakpoints
break _KEY

define key-run
  run < gdb-scenarios/000-key/input.f
end

document key-run
Run jonesforth with this scenario input and stop at _KEY.
end

define key-step
  stepi
  x/i $pc
  ui-mem &currkey
  ui-mem &bufftop
  ui-buffer
end

document key-step
Step one instruction and show _KEY-related buffer state.
end

define key-steps
  if $argc == 0
    set $n = 1
  else
    set $n = $arg0
  end
  while $n > 0
    key-step
    echo --------------------\n
    set $n = $n - 1
  end
end

document key-steps
Run key-step N times (default: 1).
end

define key-go
  continue
end

document key-go
Continue execution to the next stop.
end

scenario-ui-on

echo Scenario 000 (_KEY) loaded.\n
echo Use: key-run, key-step, key-steps N, key-go\n
