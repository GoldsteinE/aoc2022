with ada.strings;
with ada.strings.unbounded;
with ada.text_io;
with ada.text_io.unbounded_io;
with ada.integer_text_io;
with ada.command_line;
with ada.containers.vectors;
use ada.strings.unbounded;
use ada.text_io;
use ada.text_io.unbounded_io;
use ada.command_line;


procedure main is
	package digits_vectors is new ada.containers.vectors ( index_type => natural, element_type => integer );
	part : string := argument(1);
	line : unbounded_string;
	field : digits_vectors.vector;
	width : integer;
	height : integer;
	tmp : integer;
	total_seen : integer;
	one_direction_seen : integer;
	max_total_seen : integer;
	count_edge_reachable : integer;
	one_edge_reachable : integer;

	procedure walk(
		x : integer;
		y : integer;
		step_x : integer;
		step_y : integer;
		count_seen : out integer;
		edge_reachable : in out integer
	) is
		elem : integer;
		initial_elem : integer := digits_vectors.element(field, x * width + y);
		nx : integer := x + step_x;
		ny : integer := y + step_y;
	begin
		count_seen := 0;
		while nx >= 0 and nx < width and ny >= 0 and ny < height loop
			tmp := (nx - 1) * width + ny;
			elem := digits_vectors.element(field, nx * width + ny);
			count_seen := count_seen + 1;
			if initial_elem <= elem then
				return;
			end if;
			nx := nx + step_x;
			ny := ny + step_y;
		end loop;
		edge_reachable := 1;
	end walk;

begin
	height := 0;
	all_lines : loop
		exit all_lines when end_of_file(current_input);
		line := get_line(current_input);
		for char in 1 .. length(line) loop
			tmp := character'pos(element(line, char)) - character'pos('0');
			digits_vectors.append(field, tmp);
		end loop;
		width := length(line);
		height := height + 1;
	end loop all_lines;

	max_total_seen := 0;
	count_edge_reachable := 0;
	for yy in 0 .. (height - 1) loop
		for xx in 0 .. (width - 1) loop
			one_edge_reachable := 0;
			total_seen := 1;
			walk(xx, yy, -1, 0, one_direction_seen, one_edge_reachable);
			total_seen := total_seen * one_direction_seen;
			walk(xx, yy, 1, 0, one_direction_seen, one_edge_reachable);
			total_seen := total_seen * one_direction_seen;
			walk(xx, yy, 0, -1, one_direction_seen, one_edge_reachable);
			total_seen := total_seen * one_direction_seen;
			walk(xx, yy, 0, 1, one_direction_seen, one_edge_reachable);
			total_seen := total_seen * one_direction_seen;
			count_edge_reachable := count_edge_reachable + one_edge_reachable;

			if total_seen > max_total_seen then
				max_total_seen := total_seen;
			end if;
		end loop;
	end loop;

	if part = "1" then
		put_line(count_edge_reachable'image);
	else
		put_line(max_total_seen'image);
	end if;
end main;
