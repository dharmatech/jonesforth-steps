# Shared helpers for scenario sessions.

define scenario-ui-on
  python
import gdb
try:
    gdb.execute("tui new-layout example {-horizontal src 1 asm 1} 2 status 0 cmd 1")
    gdb.execute("layout example")
    gdb.execute("winheight src -10")
    gdb.execute("focus cmd")
except gdb.error as exc:
    gdb.write(f"(scenario-ui-on skipped: {exc})\n")
  end
end

document scenario-ui-on
Enable the standard scenario TUI layout.
end

define scenario-ui-off
  python
import gdb
try:
    gdb.execute("tui disable")
except gdb.error as exc:
    gdb.write(f"(scenario-ui-off skipped: {exc})\n")
  end
end

document scenario-ui-off
Disable TUI mode.
end
