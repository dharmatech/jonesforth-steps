# Minimal interactive demo for ui-buffer around _KEY.
#
# Usage (from step-9000-full):
#   gdb -q ./jonesforth
#   (gdb) source tmp/ui-buffer-demo.gdb
#   (gdb) run < .trace.input.f
#   (gdb) key-step
#   (gdb) key-steps 10

set pagination off
set confirm off

python
import os
import gdb
scriptdir = str(gdb.parse_and_eval('$_scriptdir')).strip('"')
ui_py = os.path.normpath(os.path.join(scriptdir, '..', '..', 'python-gdb-ui', 'gdb_program_ui.py'))
gdb.execute(f'source {ui_py}')
end

delete breakpoints
break _KEY

# Single instruction step + focused state dump.
define key-step
  stepi
  x/i $pc
  ui-mem &currkey
  ui-mem &bufftop
  ui-buffer
end

document key-step
Step one instruction and display currkey/bufftop plus ui-buffer view.
end

# Repeat key-step N times (default 1).
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
Continue execution to next breakpoint (starts at _KEY).
end

echo Loaded ui-buffer demo. Breakpoint set at _KEY.\n
echo Run the program, then use: key-step / key-steps N / key-go\n
