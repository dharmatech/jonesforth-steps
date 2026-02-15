
source ../python-gdb-ui/gdb_program_ui.py

define show-buffer

    list

    x/16i $pc-24

    ui-reg eax
    ui-reg ebx
    ui-reg ecx

    echo eflags: \ 
    info registers eflags

    echo currkey    \ 
    x/1xw &currkey

    echo bufftop    \  
    x/1xw &bufftop

    # Show the contents of the buffer in hex and ascii.
    # The buffer is 4096 bytes long, but we will only show the first 64 bytes for brevity.
    
    # x/64xb &buffer
    # x/64cb &buffer

    # bufftop - buffer
    # print/d ((int)*(int*)&bufftop) - (int)((int*)&buffer)

    printf "*&currkey - &buffer: %4d\n", ((int)*(int*)&currkey) - (int)((int*)&buffer)
    printf "*&bufftop - &buffer: %4d\n", ((int)*(int*)&bufftop) - (int)((int*)&buffer)

    printf "**&currkey:          %4c\n", **(int*)&currkey

    printf "buffer: %.10s\n", &buffer
    x/32xb &buffer

    printf "word_buffer: |%.32s|\n", &word_buffer

end

define stepi-show-buffer
    stepi

    show-buffer
end

# x/16i $pc-24



# tui enable
# winheight src -5
# tui disable

define display-buffer

    set $n = ((int)*(int*)&bufftop) - (int)((int*)&buffer)

    set $i = 0

    while $i < $n
        # printf "buffer+%4d: %4c\n", $i, *((char*)&buffer+$i)

        print/c *((char*)&buffer+$i)

        # printf "%c", *((char*)&buffer+$i)

        set $i = $i + 1
    end

end