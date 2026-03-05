
- JONESFORTH interpreter outline
    - `_start`
        - `mov $cold_start,%esi    // Initialise interpreter.`
        - `NEXT`
        - `QUIT`
            
            ```
            .int RZ,RSPSTORE        // R0 RSP!, clear the return stack
            .int INTERPRET          // interpret the next word
            .int BRANCH,-8          // and loop (indefinitely)
            ```
            
            - `INTERPRET`
                - `_WORD` read a word from standard input
                - `_FIND` find the word in the dictionary
                - In dictionary?
                    - Has `F_IMMED` flag?
                        - `execute`
                            - `NEXT`
                    - Does not have `F_IMMED` flag?
                        - `check_state`
                            - IF`STATE == 0` : executing
                                - `execute`
                                    - `NEXT`
                            - IF `STATE != 0` : compiling
                                - `_COMMA`
                                - `NEXT`
                - Not in dictionary?
                    - `_NUMBER`