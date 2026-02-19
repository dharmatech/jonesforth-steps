source gdb/forth-dict.gdb
# break 1367
break _start

define stepi-dict
	stepi
	forth-dict 5
end

define loop-stepi
	while 1 < 2
		stepi-dict
		x/4dw $esp
	end
end

run < examples/words.f

set pagination off

loop-stepi

exit
