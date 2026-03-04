
In this example:

- Load `jonesforth.f`
- `break`
- Ready to step through loading `examples/words.f`
- `forth-until-silent cde` is used to skip to when `cde` is executing

```
cat jonesforth.f examples/trace-gate.f examples/words.f > .debug.input.f

gdb -q ./jonesforth \
  -ex 'source gdb/forth-dict.gdb' \
  -ex "break-interpret-word __TRACE_GATE__" \
  -ex 'run < .debug.input.f' \
  -ex 'delete 1' \
  -ex 'forth-until-silent cde'
```