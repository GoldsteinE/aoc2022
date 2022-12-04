def one_contains_another: . as [[$l1, $r1], [$l2, $r2]] | ($l1 <= $l2 and $r1 >= $r2) or ($l2 <= $l1 and $r2 >= $r1);
def have_intersection:    . as [[$l1, $r1], [$l2, $r2]] | ($l1 <= $l2 and $r1 >= $l2) or ($l2 <= $l1 and $r2 >= $l1);

def run_logic:
	if env.PART == "2"
		then . | have_intersection
		else . | one_contains_another
	end;

[
	.
	| rtrimstr("\n")
	| split("\n")[]
	| split(",")
	| map(split("-") | map(tonumber))
	| run_logic
	| if . then 1 else 0 end
] | add
