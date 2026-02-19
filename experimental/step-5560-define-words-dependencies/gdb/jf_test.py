import gdb


class _State:
    expected_word = None
    expected_tos = None
    seen_word_defined = False
    seen_tos_after_word = False
    parse_error = False


def _eval_int(expr: str) -> int:
    return int(gdb.parse_and_eval(expr))


def _inferior():
    inf = gdb.selected_inferior()
    if inf is None:
        raise gdb.GdbError("No inferior selected")
    return inf


def _read_u8(addr: int) -> int:
    data = _inferior().read_memory(addr, 1).tobytes()
    return data[0]


def _read_u32(addr: int) -> int:
    data = _inferior().read_memory(addr, 4).tobytes()
    return int.from_bytes(data, "little", signed=False)


def _read_bytes(addr: int, n: int) -> bytes:
    if n <= 0:
        return b""
    return _inferior().read_memory(addr, n).tobytes()


def _dict_has_word(name: str) -> bool:
    # Dictionary header layout:
    #   +0: link (u32), +4: flags+len (u8), +5..: name bytes
    entry = _eval_int("*(int*)(&var_LATEST)")
    name_b = name.encode("ascii")
    want_len = len(name_b)
    while entry != 0:
        try:
            length = _read_u8(entry + 4) & 0x1F
            if length == want_len:
                if _read_bytes(entry + 5, want_len) == name_b:
                    return True
            entry = _read_u32(entry)
        except gdb.MemoryError:
            return False
    return False


def _tos() -> int:
    esp = int(gdb.parse_and_eval("$esp")) & 0xFFFFFFFF
    val = _read_u32(esp)
    if val & 0x80000000:
        return val - 0x100000000
    return val


class JfConfig(gdb.Command):
    def __init__(self):
        super().__init__("jf-config", gdb.COMMAND_USER)

    def invoke(self, arg, from_tty):
        argv = gdb.string_to_argv(arg)
        if len(argv) != 2:
            raise gdb.GdbError("Usage: jf-config <word> <expected_tos>")
        _State.expected_word = argv[0]
        _State.expected_tos = int(argv[1], 0)
        _State.seen_word_defined = False
        _State.seen_tos_after_word = False
        _State.parse_error = False


class JfUpdate(gdb.Command):
    def __init__(self):
        super().__init__("jf-update", gdb.COMMAND_USER)

    def invoke(self, arg, from_tty):
        if _State.expected_word is None:
            raise gdb.GdbError("jf-config must run before jf-update")

        if not _State.seen_word_defined and _dict_has_word(_State.expected_word):
            _State.seen_word_defined = True

        if _State.seen_word_defined:
            try:
                if _tos() == _State.expected_tos:
                    _State.seen_tos_after_word = True
            except gdb.MemoryError:
                pass


class JfCheckParseError(gdb.Command):
    def __init__(self):
        super().__init__("jf-check-parse-error", gdb.COMMAND_USER)

    def invoke(self, arg, from_tty):
        try:
            ecx = _eval_int("$ecx") & 0xFFFFFFFF
            errmsg = _eval_int("&errmsg") & 0xFFFFFFFF
            if ecx == errmsg:
                _State.parse_error = True
        except gdb.error:
            pass


class JfAssert(gdb.Command):
    def __init__(self):
        super().__init__("jf-assert", gdb.COMMAND_USER)

    def invoke(self, arg, from_tty):
        if _State.expected_word is None:
            raise gdb.GdbError("jf-config must run before jf-assert")

        if _State.parse_error:
            raise gdb.GdbError("FAIL: parse error occurred")
        if not _State.seen_word_defined:
            raise gdb.GdbError(
                f"FAIL: {_State.expected_word} was never defined in dictionary"
            )
        if not _State.seen_tos_after_word:
            raise gdb.GdbError(
                f"FAIL: never observed {_State.expected_tos} on stack after {_State.expected_word} definition"
            )
        gdb.write(
            f"PASS: {_State.expected_word} defined and produced {_State.expected_tos} on stack\n"
        )


JfConfig()
JfUpdate()
JfCheckParseError()
JfAssert()
