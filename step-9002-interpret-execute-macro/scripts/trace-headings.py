#!/usr/bin/env python3
"""Insert nested markdown headings into the Single Stepping trace section.

The script reads an existing markdown trace and rewrites only the fenced code block
under `# Single Stepping` so function calls/returns appear as nested sub-headings.
"""

from __future__ import annotations

import argparse
import re
from pathlib import Path

SINGLE_STEPPING_HEADING = "# Single Stepping"
DELIM_LINE = "--------------------"
CALL_RE = re.compile(r":\s*call\s+0x[0-9a-fA-F]+\s+<([^>]+)>")
RET_RE = re.compile(r":\s*ret[lq]?\b")
SRC_LINE_RE = re.compile(r"^\d+\s+")


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Add nested headings to the Single Stepping trace section."
    )
    parser.add_argument("input", type=Path, help="Input markdown file")
    parser.add_argument("output", type=Path, help="Output markdown file")
    return parser.parse_args()


def find_single_stepping_block(lines: list[str]) -> tuple[int, int]:
    heading_idx = -1
    for i, line in enumerate(lines):
        if line.strip() == SINGLE_STEPPING_HEADING:
            heading_idx = i
            break
    if heading_idx < 0:
        raise ValueError(f"Heading not found: {SINGLE_STEPPING_HEADING}")

    fence_start = -1
    for i in range(heading_idx + 1, len(lines)):
        if lines[i].strip().startswith("```"):
            fence_start = i
            break
    if fence_start < 0:
        raise ValueError("Opening code fence under # Single Stepping not found")

    fence_end = -1
    for i in range(fence_start + 1, len(lines)):
        if lines[i].strip().startswith("```"):
            fence_end = i
            break
    if fence_end < 0:
        raise ValueError("Closing code fence under # Single Stepping not found")

    return fence_start, fence_end


def split_frames(content_lines: list[str]) -> list[list[str]]:
    frames: list[list[str]] = []
    current: list[str] = []

    for line in content_lines:
        if line.strip() == DELIM_LINE and current:
            frames.append(current)
            current = [line]
        else:
            current.append(line)

    if current:
        frames.append(current)

    return frames


def parse_frame_action(frame: list[str]) -> tuple[str | None, str | None]:
    for line in frame:
        if not line.startswith("$pc =>"):
            continue

        call_match = CALL_RE.search(line)
        if call_match:
            target = call_match.group(1).split("+", 1)[0]
            return "call", target

        if RET_RE.search(line):
            return "ret", None

        return None, None

    return None, None


def heading_for_stack(stack: list[str]) -> str | None:
    if not stack:
        return None
    level = len(stack) + 1
    return f"{'#' * level} {stack[-1]}\n"


def strip_frame_delims(frame: list[str]) -> list[str]:
    return [line for line in frame if line.strip() != DELIM_LINE]


def find_step_title(frame: list[str]) -> str:
    clean = strip_frame_delims(frame)

    for line in clean:
        text = line.strip()
        if SRC_LINE_RE.match(text):
            return text

    for line in clean:
        text = line.strip()
        if text:
            return text

    return "step"


def step_heading_for_stack(stack: list[str], title: str) -> str:
    # Keep step headings one level deeper than the function heading tree.
    level = len(stack) + 2
    return f"{'#' * level} {title}\n"


def flush_frame(out: list[str], stack: list[str], frame: list[str]) -> None:
    clean_frame = strip_frame_delims(frame)
    if not clean_frame:
        return

    if out and out[-1].strip():
        out.append("\n")

    out.append(step_heading_for_stack(stack, find_step_title(clean_frame)))

    out.append("```\n")
    out.extend(clean_frame)
    if clean_frame and clean_frame[-1].strip():
        out.append("\n")
    out.append("```\n")


def render_nested_content(content_lines: list[str]) -> list[str]:
    frames = split_frames(content_lines)
    if not frames:
        return ["```\n", "```\n"]

    out: list[str] = []
    stack: list[str] = []
    current_stack_key: tuple[str, ...] | None = None
    emit_heading_for_current_stack = True

    for frame in frames:
        stack_key = tuple(stack)
        if stack_key != current_stack_key:
            if out and out[-1].strip():
                out.append("\n")
            if stack:
                if emit_heading_for_current_stack:
                    out.append(heading_for_stack(stack) or "")
            current_stack_key = stack_key

        flush_frame(out, stack, frame)
        action, target = parse_frame_action(frame)

        next_stack = stack
        next_emit_heading_for_current_stack = emit_heading_for_current_stack
        if action == "call" and target:
            next_stack = [*stack, target]
            next_emit_heading_for_current_stack = True
        elif action == "ret" and stack:
            next_stack = stack[:-1]
            next_emit_heading_for_current_stack = False

        if next_stack != stack:
            stack = next_stack
            emit_heading_for_current_stack = next_emit_heading_for_current_stack
    return out


def main() -> int:
    args = parse_args()
    lines = args.input.read_text(encoding="utf-8").splitlines(keepends=True)

    fence_start, fence_end = find_single_stepping_block(lines)
    content = lines[fence_start + 1 : fence_end]
    rendered = render_nested_content(content)

    new_lines = lines[:fence_start] + rendered + lines[fence_end + 1 :]
    args.output.write_text("".join(new_lines), encoding="utf-8")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
