let part = getenv('PART')
let input_file = getenv('INPUT')
let input_lines = readfile(input_file)

let stack_lines = []
let command_lines = []
let write_to_command = v:false
for line in input_lines
	if line == ''
		let write_to_command = v:true
	elseif write_to_command
		call add(command_lines, line)
	else
		call add(stack_lines, line)
	endif
endfor

let last_stack_line = remove(stack_lines, -1)
let stacks = []
let first_digit = match(last_stack_line, "[0-9]")
while first_digit != -1
	call add(stacks, [])
	let first_digit = match(last_stack_line, "[0-9]", first_digit + 1)
endwhile

for line in stack_lines
	let idx = 1
	let stack = 0
	while idx < len(line)
		if line[idx] != " "
			call add(stacks[stack], line[idx])
		endif
		let idx += 4
		let stack += 1
	endwhile
endfor

for stack in stacks
	call reverse(stack)
endfor

for line in command_lines
	let [_, count, src, dest; _] = matchlist(line, 'move \([0-9]*\) from \([0-9]*\) to \([0-9]*\)')
	let src -= 1
	let dest -= 1
	if part == "1"
		for _ in range(count)
			let crate = remove(stacks[src], -1)
			call add(stacks[dest], crate)
		endfor
	else
		let crates = remove(stacks[src], -count, -1)
		call extend(stacks[dest], crates)
	endif
endfor

let answer = ""
for stack in stacks
	let answer .= stack[-1]
endfor

echo answer "\n"
