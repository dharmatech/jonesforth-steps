#ifndef ASM_IMPORT_STACK_INC
#define ASM_IMPORT_STACK_INC

#ifndef HAVE_WORD_DROP
#include "../stack.S"
#endif

#ifndef HAVE_WORD_DROP
#error "Missing dependency: DROP"
#endif

#ifndef HAVE_WORD_SWAP
#error "Missing dependency: SWAP"
#endif

#ifndef HAVE_WORD_DUP
#error "Missing dependency: DUP"
#endif

#ifndef HAVE_WORD_OVER
#error "Missing dependency: OVER"
#endif

#ifndef HAVE_WORD_ROT
#error "Missing dependency: ROT"
#endif

#ifndef HAVE_WORD_NROT
#error "Missing dependency: -ROT"
#endif

#ifndef HAVE_WORD_TWODROP
#error "Missing dependency: 2DROP"
#endif

#ifndef HAVE_WORD_TWODUP
#error "Missing dependency: 2DUP"
#endif

#ifndef HAVE_WORD_TWOSWAP
#error "Missing dependency: 2SWAP"
#endif

#ifndef HAVE_WORD_QDUP
#error "Missing dependency: ?DUP"
#endif

#endif
