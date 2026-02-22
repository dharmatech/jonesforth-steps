# Minimal interactive demo for _FIND stepping.
#
# Usage (from step-9000-full):
#   gdb -q ./jonesforth
#   (gdb) source tmp/ui-find-demo.gdb
#   (gdb) run < .trace.input.f
#   (gdb) stepi-FIND_
#   (gdb) stepi-FIND_
#   (gdb) find-go

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
break _FIND

define find-go
  continue
end

define continue-find
  continue
  ui-find
end

document find-go
Continue execution to next _FIND breakpoint.
end

echo Loaded _FIND demo. Breakpoint set at _FIND.\n
echo Use stepi-FIND_ to single-step with ui-find visualization.\n
echo Use find-go to continue to the next _FIND call.\n
