
#ifndef ASM_SEMICOLON_S
#define ASM_SEMICOLON_S

#include "imports/FETCH.inc"
#include "imports/HIDDEN.inc"
#include "imports/LBRAC.inc"
#include "imports/EXIT.inc"
#include "imports/kernel_words.inc"

defword ";",1,F_IMMED,SEMICOLON
    .int LIT, EXIT, COMMA   // Append EXIT (so the word will return).
    .int LATEST, FETCH, HIDDEN // Toggle hidden flag -- unhide the word (see below for definition).
    .int LBRAC              // Go back to IMMEDIATE mode.
    .int EXIT               // Return from the function.

#define HAVE_WORD_SEMICOLON 1
#endif
