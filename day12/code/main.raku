sub can_go(Str $dest, Str $src) {
	$dest.ord - $src.ord <= 1
}

my @field;
$*IN.lines().map({ Array.new($_.split('')[1 .. *-2]) }).iterator.push-all(@field);
my $part = shift @*ARGS;

my %edges;
my %nodes;
my $starting_pos;
my $final_pos;
my @interesting_nodes;
for (0 ..^ elems @field) -> $idx {
	my $s := @field[$idx].first('S', :k);
	if !($s === Nil) {
		$starting_pos = ($idx, $s).raku;
		@field[$idx][$s] = 'a';
	}

	my $e := @field[$idx].first('E', :k);
	if !($e === Nil) {
		$final_pos = ($idx, $e).raku;
		@field[$idx][$e] = 'z';
	}

	for (0 ..^ elems @field[$idx]) -> $jdx {
		# meh, dunno how to do it without conversion to string
		my $key = ($idx, $jdx).raku;
		%edges{$key} = [];
		%nodes{$key} = ∞;
		push @interesting_nodes, $key if @field[$idx][$jdx] ~~ 'a';
		if $idx > 0 && can_go(@field[$idx][$jdx], @field[$idx - 1][$jdx]) {
			push %edges{$key}, ($idx - 1, $jdx).raku;
		}
		if $jdx > 0 && can_go(@field[$idx][$jdx], @field[$idx][$jdx - 1]) {
			push %edges{$key}, ($idx, $jdx - 1).raku;
		}
		if $idx < (elems @field) - 1 && can_go(@field[$idx][$jdx], @field[$idx + 1][$jdx]) {
			push %edges{$key}, ($idx + 1, $jdx).raku;
		}
		if $jdx < (elems @field[$idx]) - 1 && can_go(@field[$idx][$jdx], @field[$idx][$jdx + 1]) {
			push %edges{$key}, ($idx, $jdx + 1).raku;
		}
	}
}

%nodes{$final_pos} = 0;
my @queue = $final_pos;
while @queue {
	my $node = shift @queue;
	for %edges{$node}.list -> $come_from {
		if %nodes{$come_from} > %nodes{$node} + 1 {
			push @queue, $come_from;
			%nodes{$come_from} = %nodes{$node} + 1;
		}
	}
}

if $part ~~ "1" {
	say %nodes{$starting_pos};
} else {
	say(min @interesting_nodes.list.map({ %nodes{$_} }));
}
