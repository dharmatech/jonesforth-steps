#ifndef ASM_IMPORT_FIND_INC
#define ASM_IMPORT_FIND_INC

#ifndef HAVE_WORD_FIND
#include "../FIND.S"
#endif

#ifndef HAVE_WORD_FIND
#error "Missing dependency: FIND"
#endif

#endif
