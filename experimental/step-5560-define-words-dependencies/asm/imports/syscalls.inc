#ifndef ASM_IMPORT_SYSCALLS_INC
#define ASM_IMPORT_SYSCALLS_INC

#ifndef HAVE_LIB_SYSCALLS
#include "../syscalls.S"
#endif

#ifndef HAVE_LIB_SYSCALLS
#error "Missing dependency: syscalls library"
#endif

#endif
