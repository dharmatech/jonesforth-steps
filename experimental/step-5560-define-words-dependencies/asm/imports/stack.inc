#ifndef ASM_IMPORT_STACK_INC
#define ASM_IMPORT_STACK_INC

#ifndef HAVE_LIB_STACK
#include "../stack.S"
#endif

#ifndef HAVE_LIB_STACK
#error "Missing dependency: stack library"
#endif

#endif
