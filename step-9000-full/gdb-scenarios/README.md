# GDB Scenarios

`gdb-scenarios` contains focused, pre-wired debugging sessions for exploring
specific routines in JonesForth.

Each scenario directory should include:

- `session.gdb`: scenario-specific GDB setup and helper commands.
- `input.f`: example FORTH input used by the scenario.
- `README.md`: quick usage notes and what to explore.

Scenarios are intended to be run from `step-9000-full`.

