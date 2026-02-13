"""GDB Python commands for aligned program views.

Generic commands:
- ui-text [start_expr] [end_expr]
- ui-rodata [start_expr] [end_expr] [--labels FILE] [--word-size N]
- ui-data [start_expr] [end_expr] [--labels FILE] [--word-size N]
- ui-sections [--labels FILE] [--word-size N] [--md]
- ui-reg <reg> [reg ...]
- ui-mem <expr> [expr ...]

Compatibility aliases:
- ui-words ...  (alias of ui-rodata)
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


def symbol_desc_at(addr: int) -> str:
    info = gdb.execute(f"info symbol 0x{addr:x}", to_string=True).strip()
    if not info or info.startswith("No symbol matches"):
        return ""
    return info.split(" in section", 1)[0].strip()


def try_read_uint(addr: int, width_bytes: int) -> int | None:
    try:
        mem = gdb.selected_inferior().read_memory(addr, width_bytes)
    except gdb.MemoryError:
        return None
    return int.from_bytes(bytes(mem), byteorder="little", signed=False)


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


def render_text_with_widths(
    rows: list[TextRow], label_w: int, addr_w: int, data_w: int
) -> str:
    lines: list[str] = []
    for row in rows:
        lines.append(
            f"{row.label:<{label_w}}  "
            f"{row.address:<{addr_w}} "
            f"{row.byte_values:<{data_w}} "
            f"{row.instruction}"
        )
    return "\n".join(lines)


def render_words_with_widths(
    rows: list[WordRow], label_w: int, addr_w: int, data_w: int
) -> str:
    lines: list[str] = []
    for row in rows:
        lines.append(
            f"{row.label:<{label_w}}  "
            f"{row.address:<{addr_w}} "
            f"{row.value:<{data_w}}"
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
            "Usage: ui-rodata [start_expr] [end_expr] [--labels FILE] [--word-size N]"
        )

    start_expr = positional[0] if len(positional) >= 1 else None
    end_expr = positional[1] if len(positional) >= 2 else None
    return start_expr, end_expr, labels_file, word_size


def parse_sections_args(argv: list[str]) -> tuple[str | None, int | None, bool]:
    labels_file: str | None = None
    word_size: int | None = None
    markdown = False

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
        if token == "--md":
            markdown = True
            i += 1
            continue

        raise gdb.GdbError("Usage: ui-sections [--labels FILE] [--word-size N] [--md]")

    return labels_file, word_size, markdown


def get_text_rows(start_expr: str | None, end_expr: str | None) -> list[TextRow]:
    if start_expr is None:
        bounds = section_bounds(".text")
        if not bounds:
            raise gdb.GdbError("Could not find .text section; pass start/end explicitly")
        start_addr, _ = bounds
    else:
        start_addr = eval_uint(start_expr)

    if end_expr is None:
        bounds = section_bounds(".text")
        if not bounds:
            raise gdb.GdbError("Could not find .text section; pass start/end explicitly")
        _, sec_end = bounds
        end_addr = sec_end - 1
    else:
        end_addr = eval_uint(end_expr)

    if end_addr <= start_addr:
        raise gdb.GdbError("text end must be greater than text start")

    gdb.execute(f"set $ui_text_start=(unsigned long long){start_addr}")
    gdb.execute(f"set $ui_text_end=(unsigned long long){end_addr}")
    disasm = gdb.execute("disassemble /r $ui_text_start,$ui_text_end", to_string=True)

    rows = parse_text_rows(disasm)
    if not rows:
        raise gdb.GdbError("No disassembly rows parsed from gdb output")
    return rows


def get_rodata_rows(
    start_expr: str | None,
    end_expr: str | None,
    labels_file: str | None,
    word_size_arg: int | None,
) -> list[WordRow]:
    rows = get_section_word_rows(
        ".rodata",
        start_expr,
        end_expr,
        labels_file,
        word_size_arg,
        allow_missing=False,
    )
    if rows is None:
        raise gdb.GdbError("Could not find .rodata section; pass start/end explicitly")
    return rows


def get_data_rows(
    start_expr: str | None,
    end_expr: str | None,
    labels_file: str | None,
    word_size_arg: int | None,
) -> list[WordRow]:
    rows = get_section_word_rows(
        ".data",
        start_expr,
        end_expr,
        labels_file,
        word_size_arg,
        allow_missing=False,
    )
    if rows is None:
        raise gdb.GdbError("Could not find .data section; pass start/end explicitly")
    return rows


def get_section_word_rows(
    section_name: str,
    start_expr: str | None,
    end_expr: str | None,
    labels_file: str | None,
    word_size_arg: int | None,
    allow_missing: bool,
) -> list[WordRow] | None:
    if start_expr is None or end_expr is None:
        bounds = section_bounds(section_name)
        if not bounds:
            if allow_missing:
                return None
            raise gdb.GdbError(
                f"Could not find {section_name} section; pass start/end explicitly"
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

    return rows


class UiTextCommand(gdb.Command):
    def __init__(self) -> None:
        super().__init__("ui-text", gdb.COMMAND_DATA)

    def invoke(self, arg: str, from_tty: bool) -> None:
        _ = from_tty
        argv = gdb.string_to_argv(arg)
        if len(argv) > 2:
            raise gdb.GdbError("Usage: ui-text [start_expr] [end_expr]")

        start_expr = argv[0] if len(argv) >= 1 else None
        end_expr = argv[1] if len(argv) >= 2 else None
        rows = get_text_rows(start_expr, end_expr)
        gdb.write(render_text(rows) + "\n")


class UiWordsCommand(gdb.Command):
    def __init__(self) -> None:
        super().__init__("ui-rodata", gdb.COMMAND_DATA)

    def invoke(self, arg: str, from_tty: bool) -> None:
        _ = from_tty
        start_expr, end_expr, labels_file, word_size_arg = parse_words_args(
            gdb.string_to_argv(arg)
        )

        rows = get_rodata_rows(start_expr, end_expr, labels_file, word_size_arg)
        gdb.write(render_words(rows) + "\n")


class UiDataCommand(gdb.Command):
    def __init__(self) -> None:
        super().__init__("ui-data", gdb.COMMAND_DATA)

    def invoke(self, arg: str, from_tty: bool) -> None:
        _ = from_tty
        start_expr, end_expr, labels_file, word_size_arg = parse_words_args(
            gdb.string_to_argv(arg)
        )

        rows = get_data_rows(start_expr, end_expr, labels_file, word_size_arg)
        gdb.write(render_words(rows) + "\n")


class UiSectionsCommand(gdb.Command):
    def __init__(self) -> None:
        super().__init__("ui-sections", gdb.COMMAND_DATA)

    def invoke(self, arg: str, from_tty: bool) -> None:
        _ = from_tty
        labels_file, word_size, markdown = parse_sections_args(gdb.string_to_argv(arg))
        text_rows = get_text_rows(None, None)
        rodata_rows = get_section_word_rows(
            ".rodata", None, None, labels_file, word_size, allow_missing=True
        )
        data_rows = get_section_word_rows(
            ".data", None, None, labels_file, word_size, allow_missing=True
        )

        label_w = max(len(r.label) for r in text_rows)
        addr_w = max(len(r.address) for r in text_rows)
        data_w = max(len(r.byte_values) for r in text_rows)
        for rows in (rodata_rows, data_rows):
            if rows:
                label_w = max(label_w, max(len(r.label) for r in rows))
                addr_w = max(addr_w, max(len(r.address) for r in rows))
                data_w = max(data_w, max(len(r.value) for r in rows))

        text_out = render_text_with_widths(text_rows, label_w, addr_w, data_w)
        rodata_out = (
            render_words_with_widths(rodata_rows, label_w, addr_w, data_w)
            if rodata_rows is not None
            else "(section not found)"
        )
        data_out = (
            render_words_with_widths(data_rows, label_w, addr_w, data_w)
            if data_rows is not None
            else "(section not found)"
        )

        if markdown:
            out_parts = [
                "## .text",
                "```",
                text_out,
                "```",
                "",
                "## .rodata",
                "```",
                rodata_out,
                "```",
                "",
                "## .data",
                "```",
                data_out,
                "```",
            ]
        else:
            out_parts = [
                ".text",
                text_out,
                "",
                ".rodata",
                rodata_out,
                "",
                ".data",
                data_out,
            ]
        gdb.write("\n".join(out_parts) + "\n")


class UiRegCommand(gdb.Command):
    def __init__(self) -> None:
        super().__init__("ui-reg", gdb.COMMAND_DATA)

    def invoke(self, arg: str, from_tty: bool) -> None:
        _ = from_tty
        argv = gdb.string_to_argv(arg)
        if not argv:
            raise gdb.GdbError("Usage: ui-reg <reg> [reg ...]")

        ptr_w = pointer_size_bytes()
        rows: list[tuple[str, str, str, str]] = []

        for reg in argv:
            reg_name = reg if reg.startswith("$") else f"${reg}"
            value = eval_uint(reg_name)
            value_s = format_hex(value, ptr_w)
            label = symbol_desc_at(value)
            deref = ""
            pointee = try_read_uint(value, ptr_w)
            if pointee is not None:
                pointee_s = format_hex(pointee, ptr_w)
                pointee_label = symbol_desc_at(pointee)
                deref = f"-> {pointee_s}"
                if pointee_label:
                    deref += f" {pointee_label}"
            rows.append((reg_name, value_s, label, deref))

        reg_w = max(len(r[0]) for r in rows)
        val_w = max(len(r[1]) for r in rows)
        lbl_w = max(len(r[2]) for r in rows)

        lines: list[str] = []
        for reg_name, value_s, label, deref in rows:
            line = f"{reg_name:<{reg_w}} {value_s:<{val_w}}"
            if lbl_w > 0:
                line += f"  {label:<{lbl_w}}"
            elif label:
                line += f"  {label}"
            if deref:
                line += f"  {deref}"
            lines.append(line)

        gdb.write("\n".join(lines) + "\n")


class UiMemCommand(gdb.Command):
    def __init__(self) -> None:
        super().__init__("ui-mem", gdb.COMMAND_DATA)

    def invoke(self, arg: str, from_tty: bool) -> None:
        _ = from_tty
        argv = gdb.string_to_argv(arg)
        if not argv:
            raise gdb.GdbError("Usage: ui-mem <expr> [expr ...]")

        ptr_w = pointer_size_bytes()
        rows: list[tuple[str, str, str, str, str]] = []

        for expr in argv:
            addr = eval_uint(expr)
            addr_s = format_hex(addr, ptr_w)
            value = try_read_uint(addr, ptr_w)
            if value is None:
                rows.append((expr, addr_s, "(unreadable)", "", ""))
                continue

            value_s = format_hex(value, ptr_w)
            value_label = symbol_desc_at(value)
            deref = ""
            pointee = try_read_uint(value, ptr_w)
            if pointee is not None:
                pointee_s = format_hex(pointee, ptr_w)
                pointee_label = symbol_desc_at(pointee)
                deref = f"-> {pointee_s}"
                if pointee_label:
                    deref += f" {pointee_label}"

            rows.append((expr, addr_s, value_s, value_label, deref))

        name_w = max(len(r[0]) for r in rows)
        addr_w = max(len(r[1]) for r in rows)
        val_w = max(len(r[2]) for r in rows)
        lbl_w = max(len(r[3]) for r in rows)

        lines: list[str] = []
        for name, addr_s, value_s, value_label, deref in rows:
            line = f"{name:<{name_w}}  {addr_s:<{addr_w}}  {value_s:<{val_w}}"
            if lbl_w > 0:
                line += f"  {value_label:<{lbl_w}}"
            elif value_label:
                line += f"  {value_label}"
            if deref:
                line += f"  {deref}"
            lines.append(line)

        gdb.write("\n".join(lines) + "\n")


class AliasUiWordsCommand(gdb.Command):
    def __init__(self) -> None:
        super().__init__("ui-words", gdb.COMMAND_DATA)

    def invoke(self, arg: str, from_tty: bool) -> None:
        _ = from_tty
        gdb.execute(f"ui-rodata {arg}")


UiTextCommand()
UiWordsCommand()
UiDataCommand()
UiSectionsCommand()
UiRegCommand()
UiMemCommand()
AliasUiWordsCommand()
