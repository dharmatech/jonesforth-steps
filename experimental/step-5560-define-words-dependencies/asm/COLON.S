#ifndef ASM_COLON_S
#define ASM_COLON_S

#include "imports/WORD.inc"
#include "imports/CREATE.inc"
#include "imports/FETCH.inc"
#include "imports/HIDDEN.inc"
#include "imports/RBRAC.inc"
#include "imports/EXIT.inc"

defword ":",1,,COLON
.int WORD               // Get the name of the new word
.int CREATE             // CREATE the dictionary entry / header
.int LIT, DOCOL, COMMA  // Append DOCOL  (the codeword).
.int LATEST, FETCH, HIDDEN // Make the word hidden (see below for definition).
.int RBRAC              // Go into compile mode.
.int EXIT               // Return from the function.

#define HAVE_WORD_COLON 1
#endif
