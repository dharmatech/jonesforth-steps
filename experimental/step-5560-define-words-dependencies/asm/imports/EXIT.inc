#ifndef ASM_IMPORT_EXIT_INC
#define ASM_IMPORT_EXIT_INC

#ifndef HAVE_WORD_EXIT
#include "../EXIT.S"
#endif

#ifndef HAVE_WORD_EXIT
#error "Missing dependency: EXIT"
#endif

#endif
