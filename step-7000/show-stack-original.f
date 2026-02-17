
: BEGIN IMMEDIATE HERE @ ;		\ save location on the stack

\ LITERAL takes whatever is on the stack and compiles LIT <foo>
: LITERAL IMMEDIATE
	' LIT ,		\ compile LIT
	,		\ compile the literal itself (from the stack)
	;

: '(' [ CHAR ( ] LITERAL 
;

 
\ 	FORTH word .S prints the contents of the stack.  It doesn't alter the stack.
\ 	Very useful for debugging.
 

\ BEGIN condition WHILE loop-part REPEAT
\	-- compiles to: --> condition 0BRANCH OFFSET2 loop-part BRANCH OFFSET
\	where OFFSET points back to condition (the beginning) and OFFSET2 points to after the whole piece of code
\ So this is like a while (condition) { loop-part } loop in the C language
: WHILE IMMEDIATE
	' 0BRANCH ,	\ compile 0BRANCH
	HERE @		\ save location of the offset2 on the stack
	0 ,		\ compile a dummy offset2
;


: IF IMMEDIATE
	' 0BRANCH ,	\ compile 0BRANCH
	HERE @		\ save location of the offset on the stack
	0 ,		\ compile a dummy offset
;

: RECURSE IMMEDIATE
	LATEST @	\ LATEST points to the word being compiled at the moment
	>CFA		\ get the codeword
	,		\ compile it
;

: THEN IMMEDIATE
	DUP
	HERE @ SWAP -	\ calculate the offset from the address saved on the stack
	SWAP !		\ store the offset in the back-filled location
;

: 'A' [ CHAR A ] LITERAL ;
: '0' [ CHAR 0 ] LITERAL ;

: ELSE IMMEDIATE
	' BRANCH ,	\ definite branch to just over the false-part
	HERE @		\ save location of the offset on the stack
	0 ,		\ compile a dummy offset
	SWAP		\ now back-fill the original (IF) offset
	DUP		\ same as for THEN word above
	HERE @ SWAP -
	SWAP !
;

: U.		\ ( u -- )
	BASE @ /MOD	\ ( width rem quot )
	?DUP IF			\ ( if quotient <> 0 then )
		RECURSE		\ ( print the quotient )
	THEN

	\ ( print the remainder )
	DUP 10 < IF
	 	'0'		\ ( decimal digits 0..9 )
	ELSE
	 	10 -		\ ( hex and beyond digits A..Z )
	 	'A'
	THEN
	+
	EMIT
;

: BL   32 ; \ BL (BLank) is a standard FORTH word for space.

: SPACE BL EMIT ;

: REPEAT IMMEDIATE
	' BRANCH ,	\ compile BRANCH
	SWAP		\ get the original offset (from BEGIN)
	HERE @ - ,	\ and compile it after BRANCH
	DUP
	HERE @ SWAP -	\ calculate the offset2
	SWAP !		\ and back-fill it in the original location
;

: .S		\ ( -- )
	DSP@		\ ( get current stack pointer )
	BEGIN
	 	DUP S0 @ <
	WHILE
	 	DUP @ U.	\ ( print the stack element )
		SPACE
	 	4 +		\ ( move up )
	REPEAT
	DROP
;

123 234 + .S

