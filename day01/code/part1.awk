BEGIN {
	curr = 0
	total = 0
}

/[0-9]+/ {
	curr += $0
}

/^$/ {
	if (curr > total)
		total = curr
	curr = 0
}

END {
	if (curr > total)
		total = curr
	print total
}
