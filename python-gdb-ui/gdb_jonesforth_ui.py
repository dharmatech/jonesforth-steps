"""GDB Python commands for aligned program views.

Generic commands:
- ui-text [start_expr] [end_expr]
- ui-words [start_expr] [end_expr] [--labels FILE] [--word-size N]

Compatibility aliases:
- jf-text ...   (alias of ui-text)
- jf-rodata ... (alias of ui-words)
"""

from __future__ import annotations

import re
from dataclasses import dataclass
from pathlib import Path

import gdb


TEXT_LINE_RE = re.compile(
    r"^\s*(?:=>\s*)?(0x[0-9a-fA-F]+)"
    r"(?:\s+<([^>]+)>)?:\s*"
    r"(?:(?P<bytes>[0-9a-fA-F]{2}(?:\s+[0-9a-fA-F]{2})*)\s+)?"
    r"(?P<instr>.*\S)?\s*$"
)

SECTION_LINE_RE = re.compile(
    r"^\s*\[\d+\]\s+(0x[0-9a-fA-F]+)->(0x[0-9a-fA-F]+).*:\s+(\S+)\b"
)


@dataclass
class TextRow:
    label: str
    address: str
    byte_values: str
    instruction: str


@dataclass
class WordRow:
    label: str
    address: str
    value: str
    points_to: str


def eval_uint(expr: str) -> int:
    value = gdb.parse_and_eval(expr)
    ull = gdb.lookup_type("unsigned long long")
    return int(value.cast(ull))


def pointer_size_bytes() -> int:
    return int(gdb.parse_and_eval("sizeof(void*)"))


def format_hex(value: int, width_bytes: int) -> str:
    return f"0x{value:0{width_bytes * 2}x}"


def section_bounds(name: str) -> tuple[int, int] | None:
    out = gdb.execute("maintenance info sections", to_string=True)
    for line in out.splitlines():
        m = SECTION_LINE_RE.match(line)
        if not m:
            continue
        start_s, end_s, sec_name = m.groups()
        if sec_name == name:
            return int(start_s, 16), int(end_s, 16)
    return None


def symbol_name_at(addr: int, exact: bool = True) -> str:
    info = gdb.execute(f"info symbol 0x{addr:x}", to_string=True).strip()
    if not info or info.startswith("No symbol matches"):
        return ""

    base = info.split(" in section", 1)[0].strip()
    if " + " in base:
        name, off = base.split(" + ", 1)
        if exact and off.strip() != "0":
            return ""
        return name.strip()

    return base


def load_label_overrides(path: str | None) -> dict[int, str]:
    if not path:
        return {}

    labels: dict[int, str] = {}
    p = Path(path)
    for idx, raw in enumerate(p.read_text().splitlines(), start=1):
        line = raw.strip()
        if not line or line.startswith("#"):
            continue

        if "=" in line:
            left, right = line.split("=", 1)
            addr_s = left.strip()
            label = right.strip()
        else:
            parts = line.split(None, 1)
            if len(parts) != 2:
                raise gdb.GdbError(f"Invalid label file line {idx}: {raw}")
            addr_s, label = parts[0], parts[1].strip()

        try:
            addr = int(addr_s, 0)
        except ValueError as exc:
            raise gdb.GdbError(f"Invalid address on line {idx}: {addr_s}") from exc

        labels[addr] = label

    return labels


def parse_text_rows(disasm: str) -> list[TextRow]:
    rows: list[TextRow] = []
    for line in disasm.splitlines():
        m = TEXT_LINE_RE.match(line)
        if not m:
            continue

        address = m.group(1).lower()
        symbol = (m.group(2) or "").strip()
        byte_values = (m.group("bytes") or "").lower()
        instruction = (m.group("instr") or "").strip()
        if not byte_values and not instruction:
            continue

        label = ""
        if symbol:
            label_part = symbol.split("+", 1)[0].strip()
            if "+0" in symbol or symbol == label_part:
                label = label_part

        rows.append(TextRow(label, address, byte_values, instruction))

    return rows


def render_text(rows: list[TextRow]) -> str:
    if not rows:
        return ""

    label_w = max(len(r.label) for r in rows)
    addr_w = max(len(r.address) for r in rows)
    bytes_w = max(len(r.byte_values) for r in rows)

    lines: list[str] = []
    for row in rows:
        lines.append(
            f"{row.label:<{label_w}}  "
            f"{row.address:<{addr_w}} "
            f"{row.byte_values:<{bytes_w}} "
            f"{row.instruction}"
        )
    return "\n".join(lines)


def render_words(rows: list[WordRow]) -> str:
    if not rows:
        return ""

    label_w = max(len(r.label) for r in rows)
    addr_w = max(len(r.address) for r in rows)
    value_w = max(len(r.value) for r in rows)

    lines: list[str] = []
    for row in rows:
        lines.append(
            f"{row.label:<{label_w}}  "
            f"{row.address:<{addr_w}} "
            f"{row.value:<{value_w}}"
            f"  {row.points_to}".rstrip()
        )
    return "\n".join(lines)


def read_words(start_addr: int, end_addr: int, word_size: int) -> list[tuple[int, int]]:
    if end_addr <= start_addr:
        raise gdb.GdbError("end address must be greater than start address")
    if word_size <= 0:
        raise gdb.GdbError("word size must be positive")
    if (end_addr - start_addr) % word_size != 0:
        raise gdb.GdbError("range size must be divisible by word size")

    count = (end_addr - start_addr) // word_size
    mem = gdb.selected_inferior().read_memory(start_addr, count * word_size)
    data = bytes(mem)

    words: list[tuple[int, int]] = []
    for i in range(count):
        addr = start_addr + i * word_size
        value = int.from_bytes(
            data[i * word_size : i * word_size + word_size],
            byteorder="little",
            signed=False,
        )
        words.append((addr, value))
    return words


def parse_words_args(argv: list[str]) -> tuple[str | None, str | None, str | None, int | None]:
    labels_file: str | None = None
    word_size: int | None = None
    positional: list[str] = []

    i = 0
    while i < len(argv):
        token = argv[i]
        if token == "--labels":
            if i + 1 >= len(argv):
                raise gdb.GdbError("--labels requires a file path")
            labels_file = argv[i + 1]
            i += 2
            continue
        if token == "--word-size":
            if i + 1 >= len(argv):
                raise gdb.GdbError("--word-size requires a number")
            try:
                word_size = int(argv[i + 1], 0)
            except ValueError as exc:
                raise gdb.GdbError(f"Invalid --word-size: {argv[i + 1]}") from exc
            i += 2
            continue

        positional.append(token)
        i += 1

    if len(positional) > 2:
        raise gdb.GdbError(
            "Usage: ui-words [start_expr] [end_expr] [--labels FILE] [--word-size N]"
        )

    start_expr = positional[0] if len(positional) >= 1 else None
    end_expr = positional[1] if len(positional) >= 2 else None
    return start_expr, end_expr, labels_file, word_size


class UiTextCommand(gdb.Command):
    def __init__(self) -> None:
        super().__init__("ui-text", gdb.COMMAND_DATA)

    def invoke(self, arg: str, from_tty: bool) -> None:
        _ = from_tty
        argv = gdb.string_to_argv(arg)
        if len(argv) > 2:
            raise gdb.GdbError("Usage: ui-text [start_expr] [end_expr]")

        if len(argv) >= 1:
            start_addr = eval_uint(argv[0])
        else:
            bounds = section_bounds(".text")
            if not bounds:
                raise gdb.GdbError("Could not find .text section; pass start/end explicitly")
            start_addr, _ = bounds

        if len(argv) >= 2:
            end_addr = eval_uint(argv[1])
        else:
            bounds = section_bounds(".text")
            if not bounds:
                raise gdb.GdbError("Could not find .text section; pass start/end explicitly")
            _, sec_end = bounds
            end_addr = sec_end - 1

        if end_addr <= start_addr:
            raise gdb.GdbError("text end must be greater than text start")

        gdb.execute(f"set $ui_text_start=(unsigned long long){start_addr}")
        gdb.execute(f"set $ui_text_end=(unsigned long long){end_addr}")
        disasm = gdb.execute("disassemble /r $ui_text_start,$ui_text_end", to_string=True)

        rows = parse_text_rows(disasm)
        if not rows:
            raise gdb.GdbError("No disassembly rows parsed from gdb output")

        gdb.write(render_text(rows) + "\n")


class UiWordsCommand(gdb.Command):
    def __init__(self) -> None:
        super().__init__("ui-words", gdb.COMMAND_DATA)

    def invoke(self, arg: str, from_tty: bool) -> None:
        _ = from_tty
        start_expr, end_expr, labels_file, word_size_arg = parse_words_args(
            gdb.string_to_argv(arg)
        )

        if start_expr is None or end_expr is None:
            bounds = section_bounds(".rodata")
            if not bounds:
                raise gdb.GdbError(
                    "Could not find .rodata section; pass start/end explicitly"
                )
            default_start, default_end = bounds
            start_addr = default_start if start_expr is None else eval_uint(start_expr)
            end_addr = default_end if end_expr is None else eval_uint(end_expr)
        else:
            start_addr = eval_uint(start_expr)
            end_addr = eval_uint(end_expr)

        word_size = word_size_arg if word_size_arg is not None else pointer_size_bytes()
        words = read_words(start_addr, end_addr, word_size)
        if not words:
            raise gdb.GdbError("No words found")

        overrides = load_label_overrides(labels_file)
        rows: list[WordRow] = []

        for addr, value in words:
            row_label = overrides.get(addr) or symbol_name_at(addr, exact=True)
            points_to = overrides.get(value) or symbol_name_at(value, exact=True)
            rows.append(
                WordRow(
                    label=row_label,
                    address=format_hex(addr, pointer_size_bytes()),
                    value=format_hex(value, word_size),
                    points_to=points_to,
                )
            )

        gdb.write(render_words(rows) + "\n")


class AliasTextCommand(gdb.Command):
    def __init__(self) -> None:
        super().__init__("jf-text", gdb.COMMAND_DATA)

    def invoke(self, arg: str, from_tty: bool) -> None:
        _ = from_tty
        gdb.execute(f"ui-text {arg}")


class AliasRodataCommand(gdb.Command):
    def __init__(self) -> None:
        super().__init__("jf-rodata", gdb.COMMAND_DATA)

    def invoke(self, arg: str, from_tty: bool) -> None:
        _ = from_tty
        gdb.execute(f"ui-words {arg}")


UiTextCommand()
UiWordsCommand()
AliasTextCommand()
AliasRodataCommand()

gdb.write("Loaded commands: ui-text, ui-words (aliases: jf-text, jf-rodata)\n")
