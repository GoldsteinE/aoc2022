function retval = check_cycle(x, cycle)
	retval = 0;
	if (mod((cycle - 20), 40) == 0)
		retval = x * cycle;
	endif
endfunction

line = fgetl(0);
cycle = 0;
x = 1;
total = 0;
screen = [ blanks(40); blanks(40); blanks(40); blanks(40); blanks(40); blanks(40); ];
while (line != -1)
	if (strcmp(line, "noop") == 1)
		if (abs(x - mod(cycle, 40)) <= 1)
			screen(floor(cycle / 40) + 1, mod(cycle, 40) + 1) = "#";
		endif
		cycle += 1;
		total += check_cycle(x, cycle + 1);
	else
		num = str2num(strsplit(line){2});
		if (abs(x - mod(cycle, 40)) <= 1)
			screen(floor(cycle / 40) + 1, mod(cycle, 40) + 1) = "#";
		endif
		cycle += 1;
		total += check_cycle(x, cycle + 1);
		if (abs(x - mod(cycle, 40)) <= 1)
			screen(floor(cycle / 40) + 1, mod(cycle, 40) + 1) = "#";
		endif
		x += num;
		cycle += 1;
		total += check_cycle(x, cycle + 1);
	endif
	line = fgetl(0);
endwhile

if (strcmp(argv(){1}, "1") == 1)
	disp(total);
else
	disp(screen);
endif
