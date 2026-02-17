
: BEGIN IMMEDIATE HERE @ ;		\ save location on the stack

\ LITERAL takes whatever is on the stack and compiles LIT <foo>
: LITERAL IMMEDIATE
	' LIT ,		\ compile LIT
	,		\ compile the literal itself (from the stack)
	;

: '(' [ CHAR ( ] LITERAL 
;

: ( IMMEDIATE
	1		\ allowed nested parens by keeping track of depth
	BEGIN
	 	KEY		\ read next character
	 	DUP '(' = IF	\ open paren?
	\ 		DROP		\ drop the open paren
	\ 		1+		\ depth increases
	\ 	ELSE
	\ 		')' = IF	\ close paren?
	\ 			1-		\ depth decreases
	\ 		THEN
	\ 	THEN
	\ DUP 0= UNTIL		\ continue until we reach matching close paren, depth 0
	\ DROP		\ drop the depth counter
;

\ (
\ 	FORTH word .S prints the contents of the stack.  It doesn't alter the stack.
\ 	Very useful for debugging.
\ )
\ : .S		( -- )
\ 	DSP@		( get current stack pointer )
\ 	BEGIN
\ 		DUP S0 @ <
\ 	WHILE
\ 		DUP @ U.	( print the stack element )
\ 		SPACE
\ 		4+		( move up )
\ 	REPEAT
\ 	DROP
\ ;