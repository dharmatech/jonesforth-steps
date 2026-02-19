source gdb/forth-dict.gdb
# break 1367
# break _start

# breakpoint for running to the end of the program
# _KEY:    mov $__NR_exit,%eax     // syscall: exit
break 1293 

define stepi-dict
	forth-dict 5
	stepi
end

define loop-stepi
	while 1 < 2   &&   $_isvoid($_exitcode)
		echo --------------------\n
		x/4dw $esp
		stepi-dict
	end
end


define loop-stepi-alt
	while 1 < 2   &&   $_isvoid($_exitcode)
		echo --------------------\n
		echo stepi: \ 
		stepi
		if $_isvoid($_exitcode)
			echo \n
			forth-dict 5
			echo \n
			echo $esp: \ 
			x/4dw $esp
		end
	end
end





run < examples/words.f

set pagination off

# loop-stepi
loop-stepi-alt

exit
