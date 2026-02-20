#ifndef ASM_IMPORT_RUNTIME_INC
#define ASM_IMPORT_RUNTIME_INC

#ifndef HAVE_LIB_RUNTIME
#include "../runtime.S"
#endif

#ifndef HAVE_LIB_RUNTIME
#error "Missing dependency: runtime library"
#endif

#endif
