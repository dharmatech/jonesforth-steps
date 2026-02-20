#ifndef ASM_COMPILER_EXT_S
#define ASM_COMPILER_EXT_S

/*      EXTENDING THE COMPILER ----------------------------------------------------------------------

        Words flagged with IMMEDIATE (F_IMMED) aren't just for the FORTH compiler to use.  You can define
        your own IMMEDIATE words too, and this is a crucial aspect when extending basic FORTH, because
        it allows you in effect to extend the compiler itself.  Does gcc let you do that?

        Standard FORTH words like IF, WHILE, ." and so on are all written as extensions to the basic
        compiler, and are all IMMEDIATE words.

        The IMMEDIATE word toggles the F_IMMED (IMMEDIATE flag) on the most recently defined word,
        or on the current word if you call it in the middle of a definition.

        Typical usage is:

        : MYIMMEDWORD IMMEDIATE
                ...definition...
        ;

        but some FORTH programmers write this instead:

        : MYIMMEDWORD
                ...definition...
        ; IMMEDIATE

        The two usages are equivalent, to a first approximation.
*/

defcode "IMMEDIATE",9,F_IMMED,IMMEDIATE
    movl var_LATEST,%edi    // LATEST word.
    addl $4,%edi            // Point to name/flags byte.
    xorb $F_IMMED,(%edi)    // Toggle the IMMED bit.
NEXT

/*      'addr HIDDEN' toggles the hidden flag (F_HIDDEN) of the word defined at addr.  To hide the
        most recently defined word (used above in : and ; definitions) you would do:

                LATEST @ HIDDEN

        'HIDE word' toggles the flag on a named 'word'.

        Setting this flag stops the word from being found by FIND, and so can be used to make 'private'
        words.  For example, to break up a large word into smaller parts you might do:

                : SUB1 ... subword ... ;
                : SUB2 ... subword ... ;
                : SUB3 ... subword ... ;
                : MAIN ... defined in terms of SUB1, SUB2, SUB3 ... ;
                HIDE SUB1
                HIDE SUB2
                HIDE SUB3

        After this, only MAIN is 'exported' or seen by the rest of the program.
*/

// HIDDEN/HIDE are intentionally not defined in this step:
// HIDDEN is provided by asm/HIDDEN.S and HIDE depends on FIND, which this step
// does not yet export as a dictionary word.

/*
        ' (TICK) is a standard FORTH word which returns the codeword pointer of the next word.

        The common usage is:

        ' FOO ,

        which appends the codeword of FOO to the current word we are defining (this only works in compiled code).

        You tend to use ' in IMMEDIATE words.  For example an alternate (and rather useless) way to define
        a literal 2 might be:

        : LIT2 IMMEDIATE
                ' LIT ,         \ Appends LIT to the currently-being-defined word
                2 ,             \ Appends the number 2 to the currently-being-defined word
        ;

        So you could do:

        : DOUBLE LIT2 * ;

        (If you don't understand how LIT2 works, then you should review the material about compiling words
        and immediate mode).

        This definition of ' uses a cheat which I copied from buzzard92.  As a result it only works in
        compiled code.  It is possible to write a version of ' based on WORD, FIND, >CFA which works in
        immediate mode too.
*/
defcode "'",1,,TICK
    lodsl                   // Get the address of the next word and skip it.
    pushl %eax              // Push it on the stack.
NEXT

#define HAVE_LIB_COMPILER_EXT 1
#endif
