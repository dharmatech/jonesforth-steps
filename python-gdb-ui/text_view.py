#!/usr/bin/env python3
"""Render an aligned disassembly table from gdb output.

Columns: label | address | bytes | instruction
"""

from __future__ import annotations

import argparse
import re
import subprocess
import sys
from dataclasses import dataclass
from pathlib import Path


LINE_RE = re.compile(
    r"^\s*(?:=>\s*)?(0x[0-9a-fA-F]+)"
    r"(?:\s+<([^>]+)>)?:\s*"
    r"(?:(?P<bytes>[0-9a-fA-F]{2}(?:\s+[0-9a-fA-F]{2})*)\s+)?"
    r"(?P<instr>.*\S)?\s*$"
)


@dataclass
class DisasmRow:
    label: str
    address: str
    byte_values: str
    instruction: str


def run_gdb(binary: Path, start_expr: str, end_expr: str) -> str:
    cmd = [
        "gdb",
        "-q",
        "-batch",
        str(binary),
        "-ex",
        f"set $text_start=(unsigned int){start_expr}",
        "-ex",
        f"set $text_end=(unsigned int){end_expr}",
        "-ex",
        "disassemble /r $text_start,$text_end",
    ]

    proc = subprocess.run(cmd, capture_output=True, text=True)
    # gdb can return non-zero if the selected range reaches an invalid address.
    return f"{proc.stdout}{proc.stderr}"


def parse_rows(gdb_output: str) -> list[DisasmRow]:
    rows: list[DisasmRow] = []

    for line in gdb_output.splitlines():
        m = LINE_RE.match(line)
        if not m:
            continue

        address = m.group(1)
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
            DisasmRow(
                label=label,
                address=address,
                byte_values=byte_values,
                instruction=instruction,
            )
        )

    return rows


def render_table(rows: list[DisasmRow]) -> str:
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


def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "binary",
        nargs="?",
        default="step-0000/jonesforth",
        help="Path to ELF binary (default: step-0000/jonesforth)",
    )
    parser.add_argument(
        "--start",
        default="code_LIT",
        help="gdb expression for disassembly start (default: code_LIT)",
    )
    parser.add_argument(
        "--end",
        default="_start+18",
        help="gdb expression for disassembly end (default: _start+18)",
    )
    return parser


def main() -> int:
    args = build_parser().parse_args()
    gdb_output = run_gdb(Path(args.binary), args.start, args.end)
    rows = parse_rows(gdb_output)
    table = render_table(rows)

    if not rows:
        print("No disassembly rows parsed from gdb output.", file=sys.stderr)
        return 1

    print(table)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
