set inferior-tty /dev/pts/7

file ./jonesforth

# break code_INTERPRET if $ecx==9 && *(char*)$edi==95 && *((char*)$edi+1)==95

break _FIND if ($ecx==9) && *(char*)$edi=='_' && *((char*)$edi+1)=='_'

# break _FIND if ($ecx==9) && \
# *(char*)$edi=='_' && *((char*)$edi+1)=='_' && \
# *((char*)$edi+2)=='B' && *((char*)$edi+3)=='R' && \
# *((char*)$edi+4)=='E' && *((char*)$edi+5)=='A' && \
# *((char*)$edi+6)=='K' && *((char*)$edi+7)=='_' && \
# *((char*)$edi+8)=='_'


# run < <(cat jonesforth.f <(echo ": __BREAK__ ; __BREAK__") -)

# run < <(cat jonesforth.f <(echo ": __BREAK__ ; __BREAK__") -)

run < <(cat jonesforth.f <(echo ": __BREAK__ ; __BREAK__") /dev/pts/7)

