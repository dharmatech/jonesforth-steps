#!/usr/bin/env python3
"""Render aligned debugger tables for jonesforth sections.

Views:
- text:   label | address | byte values | instruction
- rodata: label | address | value | optional pointed label
"""

from __future__ import annotations

import argparse
import re
import subprocess
import sys
from dataclasses import dataclass
from pathlib import Path


TEXT_LINE_RE = re.compile(
    r"^\s*(?:=>\s*)?(0x[0-9a-fA-F]+)"
    r"(?:\s+<([^>]+)>)?:\s*"
    r"(?:(?P<bytes>[0-9a-fA-F]{2}(?:\s+[0-9a-fA-F]{2})*)\s+)?"
    r"(?P<instr>.*\S)?\s*$"
)

EXAMINE_LINE_RE = re.compile(r"^\s*(0x[0-9a-fA-F]+):\s*(.*)$")
HEX_TOKEN_RE = re.compile(r"0x[0-9a-fA-F]+")
EVAL_HEX_RE = re.compile(r"\$\d+\s*=\s*(0x[0-9a-fA-F]+)")
NM_LINE_RE = re.compile(r"^([0-9a-fA-F]{8,16})\s+([a-zA-Z])\s+(\S+)$")


@dataclass
class TextRow:
    label: str
    address: str
    byte_values: str
    instruction: str


@dataclass
class RodataRow:
    label: str
    address: str
    value: str
    points_to: str


def run_gdb(binary: Path, commands: list[str]) -> str:
    cmd = ["gdb", "-q", "-batch", str(binary)]
    for c in commands:
        cmd.extend(["-ex", c])

    proc = subprocess.run(cmd, capture_output=True, text=True)
    # gdb can return non-zero for partial range reads; parser filters usable lines.
    return f"{proc.stdout}{proc.stderr}"


def eval_u32(binary: Path, expr: str) -> int:
    output = run_gdb(binary, [f"p/x {expr}"])
    m = EVAL_HEX_RE.search(output)
    if not m:
        raise ValueError(f"Unable to evaluate gdb expression: {expr}")
    return int(m.group(1), 16)


def parse_text_rows(gdb_output: str) -> list[TextRow]:
    rows: list[TextRow] = []

    for line in gdb_output.splitlines():
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

        rows.append(
            TextRow(
                label=label,
                address=address,
                byte_values=byte_values,
                instruction=instruction,
            )
        )

    return rows


def render_text_table(rows: list[TextRow]) -> str:
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


def load_symbol_map(binary: Path) -> dict[int, str]:
    proc = subprocess.run(["nm", "-n", str(binary)], capture_output=True, text=True)
    symbols: dict[int, str] = {}
    for line in proc.stdout.splitlines():
        m = NM_LINE_RE.match(line.strip())
        if not m:
            continue
        addr_s, _sym_type, name = m.groups()
        addr = int(addr_s, 16)
        symbols.setdefault(addr, name)
    return symbols


def load_label_overrides(path: Path | None) -> dict[int, str]:
    if path is None:
        return {}

    labels: dict[int, str] = {}
    for idx, raw in enumerate(path.read_text().splitlines(), start=1):
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
                raise ValueError(f"Invalid label file line {idx}: {raw}")
            addr_s, label = parts[0], parts[1].strip()

        try:
            addr = int(addr_s, 0)
        except ValueError as exc:
            raise ValueError(f"Invalid address on line {idx}: {addr_s}") from exc

        labels[addr] = label

    return labels


def parse_examine_words(gdb_output: str) -> list[tuple[int, int]]:
    words: list[tuple[int, int]] = []

    for line in gdb_output.splitlines():
        m = EXAMINE_LINE_RE.match(line)
        if not m:
            continue

        base_addr = int(m.group(1), 16)
        values = [int(tok, 16) for tok in HEX_TOKEN_RE.findall(m.group(2))]
        for i, value in enumerate(values):
            words.append((base_addr + i * 4, value))

    return words


def render_rodata_table(rows: list[RodataRow]) -> str:
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


def build_text_view(binary: Path, start_expr: str, end_expr: str) -> str:
    output = run_gdb(
        binary,
        [
            f"set $text_start=(unsigned int){start_expr}",
            f"set $text_end=(unsigned int){end_expr}",
            "disassemble /r $text_start,$text_end",
        ],
    )
    rows = parse_text_rows(output)
    if not rows:
        raise ValueError("No disassembly rows parsed from gdb output.")
    return render_text_table(rows)


def build_rodata_view(
    binary: Path,
    start_expr: str,
    end_expr: str,
    label_file: Path | None,
) -> str:
    start_addr = eval_u32(binary, start_expr)
    end_addr = eval_u32(binary, end_expr)

    if end_addr <= start_addr:
        raise ValueError("rodata end address must be greater than start address")
    if (end_addr - start_addr) % 4 != 0:
        raise ValueError("rodata range size must be word-aligned (multiple of 4)")

    count = (end_addr - start_addr) // 4
    output = run_gdb(binary, [f"x/{count}xw 0x{start_addr:08x}"])
    words = parse_examine_words(output)

    if not words:
        raise ValueError("No rodata words parsed from gdb output.")

    symbols = load_symbol_map(binary)
    overrides = load_label_overrides(label_file)

    rows: list[RodataRow] = []
    for addr, value in words:
        row_label = overrides.get(addr) or symbols.get(addr, "")
        points_to = overrides.get(value) or symbols.get(value, "")
        rows.append(
            RodataRow(
                label=row_label,
                address=f"0x{addr:08x}",
                value=f"0x{value:08x}",
                points_to=points_to,
            )
        )

    return render_rodata_table(rows)


def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "binary",
        nargs="?",
        default="step-0000/jonesforth",
        help="Path to ELF binary (default: step-0000/jonesforth)",
    )
    parser.add_argument(
        "--view",
        choices=["text", "rodata"],
        default="text",
        help="Which section-style table to print (default: text)",
    )

    parser.add_argument(
        "--start",
        default="code_LIT",
        help="gdb expression for start. text default: code_LIT",
    )
    parser.add_argument(
        "--end",
        default="_start+18",
        help="gdb expression for end. text default: _start+18",
    )

    parser.add_argument(
        "--labels",
        type=Path,
        help=(
            "Optional label override file for rodata view. "
            "Format per line: '0xADDR LABEL' or '0xADDR=LABEL'."
        ),
    )

    return parser


def main() -> int:
    args = build_parser().parse_args()
    binary = Path(args.binary)

    try:
        if args.view == "text":
            table = build_text_view(binary, args.start, args.end)
        else:
            start_expr = args.start
            end_expr = args.end
            if args.start == "code_LIT":
                start_expr = "&LIT"
            if args.end == "_start+18":
                end_expr = "((unsigned int)&cold_start)+24"
            table = build_rodata_view(binary, start_expr, end_expr, args.labels)
    except ValueError as exc:
        print(str(exc), file=sys.stderr)
        return 1

    print(table)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
