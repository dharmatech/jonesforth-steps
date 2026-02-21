# Scenario 002: explore _FIND state evolution while stepping.

set pagination off
set confirm off

source gdb-scenarios/common.gdb
source ../python-gdb-ui/gdb_program_ui.py

delete breakpoints
break _FIND

define find-run
  run < gdb-scenarios/002-find/input.f
end

document find-run
Run jonesforth with this scenario input and stop at _FIND.
end

define find-show
  x/i $pc
  ui-find
  ui-mem &currkey
  ui-mem &bufftop
  ui-buffer
end

document find-show
Show _FIND-focused state using ui-find plus input-buffer context.
end

define find-step
  stepi-FIND_
  ui-mem &currkey
  ui-mem &bufftop
  ui-buffer
end

document find-step
Step one instruction with stepi-FIND_ and show buffer context.
end

define find-steps
  if $argc == 0
    set $n = 1
  else
    set $n = $arg0
  end
  while $n > 0
    find-step
    echo --------------------\n
    set $n = $n - 1
  end
end

document find-steps
Run find-step N times (default: 1).
end

define find-go
  continue
end

document find-go
Continue execution to the next stop.
end

scenario-ui-on

echo Scenario 002 (_FIND) loaded.\n
echo Use: find-run, find-show, find-step, find-steps N, find-go\n
