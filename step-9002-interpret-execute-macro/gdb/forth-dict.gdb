# Print and inspect FORTH dictionary/runtime state.
#
# Usage:
#   source gdb/forth-dict.gdb
#   forth-dict                  # print up to 256 dictionary entries
#   forth-dict 32               # print up to 32 entries
#   forth-view                  # show nested FORTH execution view from return stack + ESI
#   forth-view 12 8             # max_depth=12, cells_per_frame=8
#   forth-next-cell             # step machine instructions until ESI changes, then forth-view
#   forth-next-cell 5           # do it 5 times
#   forth-next-known            # step until next ESI that maps to a known FORTH frame
#   forth-next-known 3          # do it 3 times
#   forth-until cde             # step by FORTH cells until current word is "cde"
#   forth-until cde 5000        # same, with max_cells guard
#   forth-until-silent cde      # fast/silent continue until entering word cde (DOCOL)
#   forth-until-silent cde 20000 # with max DOCOL-hit guard
#   break-interpret-word __TRACE_GATE__  # break when INTERPRET sees this exact token

python
import gdb


def _u8(inferior, addr):
    data = inferior.read_memory(addr, 1).tobytes()
    return int.from_bytes(data, byteorder="little", signed=False)


def _u32(inferior, addr):
    data = inferior.read_memory(addr, 4).tobytes()
    return int.from_bytes(data, byteorder="little", signed=False)


def _fmt_name(raw):
    out = []
    for b in raw:
        if 32 <= b <= 126:
            out.append(chr(b))
        else:
            out.append("\\x%02x" % b)
    return "".join(out)


def _safe_eval_u32(expr):
    return int(gdb.parse_and_eval(expr))


def _eval_u32_or(expr, default):
    try:
        return int(gdb.parse_and_eval(expr))
    except (gdb.error, gdb.MemoryError):
        return default


def _safe_info_symbol(addr):
    try:
        text = gdb.execute("info symbol %#x" % addr, to_string=True).strip()
    except gdb.error:
        return None
    if not text or text.startswith("No symbol matches"):
        return None
    # Typical format: "DOCOL in section .text"
    return text.split(" in section ")[0].strip()


class _DictIndex(object):
    def __init__(self, entries, by_cfa, by_name, here):
        self.entries = entries
        self.by_cfa = by_cfa
        self.by_name = by_name
        self.here = here

    def find_by_ip(self, ip):
        # return stack IP/ESI points into threaded cell stream (body area)
        for e in self.entries:
            start = e["cfa"] + 4
            end = e["end"]
            if start <= ip < end:
                return e
        return None


def _build_dict_index(inferior, max_entries=8192):
    latest = _eval_u32_or("(unsigned int)var_LATEST", 0)
    here = _eval_u32_or("(unsigned int)var_HERE", 0)

    entries = []
    by_cfa = {}
    by_name = {}
    seen = set()

    entry = latest
    i = 0
    failed_at = None
    while entry != 0 and i < max_entries and entry not in seen:
        seen.add(entry)
        try:
            link = _u32(inferior, entry)
            lenflags = _u8(inferior, entry + 4)
        except gdb.MemoryError:
            failed_at = entry
            break
        name_len = lenflags & 0x1F
        flags = lenflags & 0xE0
        name_addr = entry + 5
        try:
            name_raw = inferior.read_memory(name_addr, name_len).tobytes()
        except gdb.MemoryError:
            failed_at = entry
            break
        cfa = (name_addr + name_len + 3) & ~3
        name = _fmt_name(name_raw)

        rec = {
            "hdr": entry,
            "link": link,
            "cfa": cfa,
            "flags": flags,
            "len": name_len,
            "name": name,
            "codeptr": 0,
            "end": cfa + 4,  # filled later
        }
        try:
            rec["codeptr"] = _u32(inferior, cfa)
        except gdb.MemoryError:
            failed_at = entry
            break
        entries.append(rec)
        by_cfa[cfa] = rec
        by_name[name] = rec

        entry = link
        i += 1

    # Sort by header address to estimate body ranges:
    # [this hdr, next newer hdr). Latest word body ends at HERE.
    entries.sort(key=lambda e: e["hdr"])
    for idx, rec in enumerate(entries):
        if idx + 1 < len(entries):
            rec["end"] = entries[idx + 1]["hdr"]
        else:
            rec["end"] = here if here > rec["cfa"] else rec["cfa"] + 4

    index = _DictIndex(entries, by_cfa, by_name, here)
    index.failed_at = failed_at
    return index


def _read_return_ips(inferior):
    ebp = _safe_eval_u32("(unsigned int)$ebp")
    rsp_base = _safe_eval_u32("(unsigned int)return_stack")
    rsp_top = _safe_eval_u32("(unsigned int)return_stack_top")

    if ebp < rsp_base or ebp >= rsp_top:
        return []

    ips = []
    p = ebp
    # hard guard against bad pointers in corrupted state
    for _ in range(8192):
        if p >= rsp_top:
            break
        val = _safe_u32(inferior, p)
        if val is None:
            break
        ips.append(val)
        p += 4
    return ips


def _fmt_cell_label(val, dict_index):
    if val in dict_index.by_cfa:
        return dict_index.by_cfa[val]["name"]
    sym = _safe_info_symbol(val)
    if sym:
        return sym
    return ""


def _find_word_by_name(dict_index, target):
    target_l = target.lower()
    for rec in dict_index.entries:
        if rec["name"].lower() == target_l:
            return rec
    return None


def _safe_u32(inferior, addr):
    try:
        return _u32(inferior, addr)
    except gdb.MemoryError:
        return None


class ForthDict(gdb.Command):
    """forth-dict [N]
Walk and display the FORTH dictionary linked list from var_LATEST.
N limits output entries (default 256)."""

    def __init__(self):
        super(ForthDict, self).__init__("forth-dict", gdb.COMMAND_USER)

    def invoke(self, arg, from_tty):
        argv = gdb.string_to_argv(arg)
        max_entries = 256
        if len(argv) > 1:
            raise gdb.GdbError("usage: forth-dict [max_entries]")
        if len(argv) == 1:
            max_entries = int(argv[0], 0)
            if max_entries <= 0:
                raise gdb.GdbError("max_entries must be > 0")

        inferior = gdb.selected_inferior()
        # var_LATEST is an assembler symbol with no strong type info in GDB.
        # Cast explicitly and use its current value as the head pointer.
        entry = int(gdb.parse_and_eval("(unsigned int)var_LATEST"))

        gdb.write("FORTH dictionary (LATEST=%#x)\n" % entry)

        i = 0
        while entry != 0 and i < max_entries:
            link = _u32(inferior, entry)
            lenflags = _u8(inferior, entry + 4)
            name_len = lenflags & 0x1F
            flags = lenflags & 0xE0
            name_addr = entry + 5
            name_raw = inferior.read_memory(name_addr, name_len).tobytes()
            cfa = (name_addr + name_len + 3) & ~3

            gdb.write(
                "[%3d] hdr=%#x link=%#x cfa=%#x flags=%#x len=%d name=\"%s\"\n"
                % (i, entry, link, cfa, flags, name_len, _fmt_name(name_raw))
            )

            entry = link
            i += 1

        if entry != 0:
            gdb.write("... truncated after %d entries\n" % max_entries)


ForthDict()


class ForthView(gdb.Command):
    """forth-view [max_depth] [cells_per_frame]
Show nested FORTH execution context inferred from return stack + ESI.
Each frame shows threaded cells and marks the next cell pointer with '=>'.
Defaults: max_depth=16, cells_per_frame=6."""

    def __init__(self):
        super(ForthView, self).__init__("forth-view", gdb.COMMAND_USER)

    def invoke(self, arg, from_tty):
        try:
            argv = gdb.string_to_argv(arg)
            if len(argv) > 2:
                raise gdb.GdbError("usage: forth-view [max_depth] [cells_per_frame]")

            max_depth = 16
            cells_per_frame = 6
            if len(argv) >= 1:
                max_depth = int(argv[0], 0)
            if len(argv) == 2:
                cells_per_frame = int(argv[1], 0)
            if max_depth <= 0 or cells_per_frame <= 0:
                raise gdb.GdbError("max_depth and cells_per_frame must be > 0")

            inferior = gdb.selected_inferior()
            dict_index = _build_dict_index(inferior)
            esi = _eval_u32_or("(unsigned int)$esi", 0)
            pc = _eval_u32_or("(unsigned int)$pc", 0)
            ret_ips = _read_return_ips(inferior)  # top-first (youngest caller first)
            ret_ips = [ip for ip in ret_ips if dict_index.find_by_ip(ip) is not None]

            # oldest caller -> current frame
            frame_ips = list(reversed(ret_ips))
            frame_ips.append(esi)
            if len(frame_ips) > max_depth:
                frame_ips = frame_ips[-max_depth:]

            gdb.write(
                "FORTH view: pc=%#x esi=%#x depth=%d here=%#x\n"
                % (pc, esi, len(frame_ips), dict_index.here)
            )
            if getattr(dict_index, "failed_at", None) is not None:
                gdb.write(
                    "  (warning: dictionary walk stopped at unreadable hdr=%#x)\n"
                    % dict_index.failed_at
                )

            lit_rec = dict_index.by_name.get("LIT")
            lit_cfa = lit_rec["cfa"] if lit_rec else None

            for depth, ip in enumerate(frame_ips):
                indent = "  " * depth
                frame = dict_index.find_by_ip(ip)
                marker = "->" if depth == len(frame_ips) - 1 else "  "

                if not frame:
                    gdb.write("%s%s <unknown frame> ip=%#x\n" % (indent, marker, ip))
                    continue

                gdb.write(
                    "%s%s %s (hdr=%#x cfa=%#x ip=%#x)\n"
                    % (indent, marker, frame["name"], frame["hdr"], frame["cfa"], ip)
                )

                start = frame["cfa"]
                end = frame["end"]
                total_cells = max(1, (end - start) // 4)
                ip_idx = (ip - start) // 4 if start <= ip < end else 0
                lo = max(0, ip_idx - (cells_per_frame // 2))
                hi = min(total_cells, lo + cells_per_frame)
                lo = max(0, hi - cells_per_frame)

                for i in range(lo, hi):
                    addr = start + (4 * i)
                    val = _safe_u32(inferior, addr)
                    cell_marker = "=> " if addr == ip else "   "
                    if val is None:
                        gdb.write(
                            "%s   %s%#010x: <unreadable>\n" % (indent, cell_marker, addr)
                        )
                        continue
                    label = _fmt_cell_label(val, dict_index)

                    # Mark literal payload cells after LIT.
                    if lit_cfa is not None and i > 0:
                        prev = _safe_u32(inferior, addr - 4)
                        if prev == lit_cfa:
                            signed_val = int.from_bytes(
                                val.to_bytes(4, byteorder="little", signed=False),
                                byteorder="little",
                                signed=True,
                            )
                            label = "%s lit=%#010x (%d)" % (
                                label + " " if label else "",
                                val,
                                signed_val,
                            )
                            label = label.strip()

                    gdb.write(
                        "%s   %s%#010x: %#010x %s\n"
                        % (indent, cell_marker, addr, val, label)
                    )
        except gdb.MemoryError as exc:
            gdb.write("forth-view: memory read failed (%s)\n" % exc)
            gdb.write("Try: break DOCOL, continue, then forth-view again.\n")


ForthView()


class ForthNextCell(gdb.Command):
    """forth-next-cell [N]
Step machine instructions until ESI changes (approximate FORTH-cell step),
then render forth-view. Repeats N times (default 1)."""

    def __init__(self):
        super(ForthNextCell, self).__init__("forth-next-cell", gdb.COMMAND_USER)

    def invoke(self, arg, from_tty):
        argv = gdb.string_to_argv(arg)
        if len(argv) > 1:
            raise gdb.GdbError("usage: forth-next-cell [count]")
        count = 1
        if len(argv) == 1:
            count = int(argv[0], 0)
        if count <= 0:
            raise gdb.GdbError("count must be > 0")

        for _ in range(count):
            start_esi = _safe_eval_u32("(unsigned int)$esi")
            steps = 0
            max_steps = 200000

            while True:
                try:
                    gdb.execute("stepi", to_string=True)
                except gdb.error as exc:
                    gdb.write("forth-next-cell: stepi stopped: %s\n" % exc)
                    return

                steps += 1
                cur_esi = _safe_eval_u32("(unsigned int)$esi")
                if cur_esi != start_esi:
                    break
                if steps >= max_steps:
                    gdb.write(
                        "forth-next-cell: no ESI change after %d instructions\n" % max_steps
                    )
                    break

        gdb.write("forth-next-cell: stepped %d cell(s)\n" % count)
        gdb.execute("forth-view")


ForthNextCell()


class ForthNextKnown(gdb.Command):
    """forth-next-known [N]
Step machine instructions until ESI moves to a known FORTH frame address,
then render forth-view. Repeats N times (default 1)."""

    def __init__(self):
        super(ForthNextKnown, self).__init__("forth-next-known", gdb.COMMAND_USER)

    def invoke(self, arg, from_tty):
        argv = gdb.string_to_argv(arg)
        if len(argv) > 1:
            raise gdb.GdbError("usage: forth-next-known [count]")
        count = 1
        if len(argv) == 1:
            count = int(argv[0], 0)
        if count <= 0:
            raise gdb.GdbError("count must be > 0")

        inferior = gdb.selected_inferior()
        done = 0

        while done < count:
            start_esi = _eval_u32_or("(unsigned int)$esi", 0)
            steps = 0
            max_steps = 400000

            while True:
                try:
                    gdb.execute("stepi", to_string=True)
                except gdb.error as exc:
                    gdb.write("forth-next-known: stepi stopped: %s\n" % exc)
                    return

                steps += 1
                cur_esi = _eval_u32_or("(unsigned int)$esi", 0)
                if cur_esi == start_esi:
                    if steps >= max_steps:
                        gdb.write(
                            "forth-next-known: no ESI change after %d instructions\n"
                            % max_steps
                        )
                        return
                    continue

                dict_index = _build_dict_index(inferior)
                frame = dict_index.find_by_ip(cur_esi)
                if frame is not None:
                    done += 1
                    break

                if steps >= max_steps:
                    gdb.write(
                        "forth-next-known: no known frame after %d instructions\n"
                        % max_steps
                    )
                    return

        gdb.write("forth-next-known: stepped %d known frame(s)\n" % count)
        gdb.execute("forth-view")


ForthNextKnown()


class ForthUntil(gdb.Command):
    """forth-until <word> [max_cells]
Step by FORTH cells until the current ESI frame is in <word>, then show forth-view.
max_cells defaults to 100000."""

    def __init__(self):
        super(ForthUntil, self).__init__("forth-until", gdb.COMMAND_USER)

    def invoke(self, arg, from_tty):
        argv = gdb.string_to_argv(arg)
        if len(argv) < 1 or len(argv) > 2:
            raise gdb.GdbError("usage: forth-until <word> [max_cells]")

        target = argv[0]
        max_cells = 100000
        if len(argv) == 2:
            max_cells = int(argv[1], 0)
        if max_cells <= 0:
            raise gdb.GdbError("max_cells must be > 0")

        inferior = gdb.selected_inferior()
        cells = 0

        while cells < max_cells:
            # Rebuild index each cell so newly compiled words are visible.
            dict_index = _build_dict_index(inferior)
            esi = _eval_u32_or("(unsigned int)$esi", 0)
            frame = dict_index.find_by_ip(esi)
            if frame:
                name = frame["name"]
                if name == target or name.lower() == target.lower():
                    gdb.write(
                        "forth-until: reached %s after %d cell(s)\n" % (name, cells)
                    )
                    gdb.execute("forth-view")
                    return

            # One FORTH-cell step: run machine instructions until ESI changes.
            start_esi = _eval_u32_or("(unsigned int)$esi", 0)
            steps = 0
            max_steps = 200000
            while True:
                try:
                    gdb.execute("stepi", to_string=True)
                except gdb.error as exc:
                    gdb.write("forth-until: stepi stopped: %s\n" % exc)
                    return
                steps += 1
                cur_esi = _eval_u32_or("(unsigned int)$esi", 0)
                if cur_esi != start_esi:
                    break
                if steps >= max_steps:
                    gdb.write(
                        "forth-until: no ESI change after %d instructions\n" % max_steps
                    )
                    return
            cells += 1

        gdb.write(
            "forth-until: target '%s' not reached after %d cell(s)\n" % (target, max_cells)
        )


ForthUntil()


class _ForthUntilSilentBreak(gdb.Breakpoint):
    def __init__(self, target, max_hits):
        super(_ForthUntilSilentBreak, self).__init__("DOCOL", internal=True)
        self.silent = True
        self.target = target
        self.max_hits = max_hits
        self.hits = 0
        self.found = False
        self.found_name = None

    def stop(self):
        self.hits += 1
        inferior = gdb.selected_inferior()
        dict_index = _build_dict_index(inferior)
        rec = _find_word_by_name(dict_index, self.target)

        if rec is not None:
            eax = _eval_u32_or("(unsigned int)$eax", 0)
            if eax == rec["cfa"]:
                self.found = True
                self.found_name = rec["name"]
                return True

        if self.hits >= self.max_hits:
            return True

        return False


class _InterpretWordBreak(gdb.Breakpoint):
    def __init__(self, token_bytes):
        super(_InterpretWordBreak, self).__init__(
            "*((unsigned int)code_INTERPRET + 5)"
        )
        self.token = token_bytes
        self.silent = True

    def stop(self):
        # At code_INTERPRET+5, _WORD has just returned:
        #   ecx = token length, word_buffer = token bytes (not NUL-terminated).
        try:
            ecx = _eval_u32_or("(unsigned int)$ecx", 0)
            if ecx != len(self.token):
                return False
            inferior = gdb.selected_inferior()
            addr = _eval_u32_or("(unsigned int)&word_buffer", 0)
            if addr == 0:
                return False
            got = inferior.read_memory(addr, ecx).tobytes()
            return got == self.token
        except (gdb.error, gdb.MemoryError):
            return False


class BreakInterpretWord(gdb.Command):
    """break-interpret-word <token>
Create a breakpoint that stops when INTERPRET reads exactly <token> into word_buffer."""

    def __init__(self):
        super(BreakInterpretWord, self).__init__(
            "break-interpret-word", gdb.COMMAND_USER
        )

    def invoke(self, arg, from_tty):
        argv = gdb.string_to_argv(arg)
        if len(argv) != 1:
            raise gdb.GdbError("usage: break-interpret-word <token>")

        token = argv[0].encode("utf-8")
        if len(token) == 0:
            raise gdb.GdbError("token must not be empty")
        if len(token) > 32:
            raise gdb.GdbError("token too long for WORD buffer (max 32)")

        bp = _InterpretWordBreak(token)
        gdb.write(
            "Breakpoint %d on INTERPRET token \"%s\" at %s\n"
            % (bp.number, argv[0], bp.location)
        )


BreakInterpretWord()


class ForthUntilSilent(gdb.Command):
    """forth-until-silent <word> [max_docol_hits]
Fast/silent continue-mode until DOCOL enters <word>, then show forth-view.
max_docol_hits defaults to 100000."""

    def __init__(self):
        super(ForthUntilSilent, self).__init__("forth-until-silent", gdb.COMMAND_USER)

    def invoke(self, arg, from_tty):
        argv = gdb.string_to_argv(arg)
        if len(argv) < 1 or len(argv) > 2:
            raise gdb.GdbError("usage: forth-until-silent <word> [max_docol_hits]")

        target = argv[0]
        max_hits = 100000
        if len(argv) == 2:
            max_hits = int(argv[1], 0)
        if max_hits <= 0:
            raise gdb.GdbError("max_docol_hits must be > 0")

        # If the user already has a visible DOCOL breakpoint, it can preempt this
        # command's internal silent breakpoint. Temporarily disable such breakpoints.
        disabled = []
        for b in (gdb.breakpoints() or []):
            try:
                if b.enabled and b.visible and b.location in ("DOCOL", "*DOCOL"):
                    b.enabled = False
                    disabled.append(b)
            except Exception:
                pass

        bp = _ForthUntilSilentBreak(target, max_hits)
        try:
            gdb.execute("continue")
        except gdb.error as exc:
            gdb.write("forth-until-silent: continue stopped: %s\n" % exc)
        finally:
            try:
                bp.delete()
            except gdb.error:
                pass
            for b in disabled:
                try:
                    b.enabled = True
                except Exception:
                    pass

        if bp.found:
            gdb.write(
                "forth-until-silent: reached %s after %d DOCOL hit(s)\n"
                % (bp.found_name, bp.hits)
            )
            gdb.execute("forth-view")
            return

        gdb.write(
            "forth-until-silent: target '%s' not reached after %d DOCOL hit(s)\n"
            % (target, bp.hits)
        )


ForthUntilSilent()
end
