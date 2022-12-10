BEGIN {
	curr = 0
	idx = 1
}

/[0-9]+/ {
	curr += $0
}

/^$/ {
	totals[idx] = curr
	curr = 0
	idx += 1
}

END {
	if (curr != 0)
		totals[idx] = curr
	count = asort(totals)
	total = 0
	for (idx = count; idx > count - 3; idx--)
		total += totals[idx]
	print total
}
