# Print the FORTH dictionary by walking the linked list from var_LATEST.
#
# Usage:
#   source gdb/forth-dict.gdb
#   forth-dict           # print up to 256 entries
#   forth-dict 32        # print up to 32 entries

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
end
