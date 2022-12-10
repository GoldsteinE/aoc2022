H
$!d
x
s/\n{10000}/a/g
t 10k
: 10k
s/a{9}/9/
t thousands
s/a{8}/8/
t thousands
s/a{7}/7/
t thousands
s/a{6}/6/
t thousands
s/a{5}/5/
t thousands
s/a{4}/4/
t thousands
s/a{3}/3/
t thousands
s/a{2}/2/
t thousands
s/a{1}/1/
t thousands
s/\n/0\n/
t thousands
: thousands
s/\n{9000}/9/
t hundreds
s/\n{8000}/8/
t hundreds
s/\n{7000}/7/
t hundreds
s/\n{6000}/6/
t hundreds
s/\n{5000}/5/
t hundreds
s/\n{4000}/4/
t hundreds
s/\n{3000}/3/
t hundreds
s/\n{2000}/2/
t hundreds
s/\n{1000}/1/
t hundreds
s/\n/0\n/
t hundreds
: hundreds
s/\n{900}/9/
t tens
s/\n{800}/8/
t tens
s/\n{700}/7/
t tens
s/\n{600}/6/
t tens
s/\n{500}/5/
t tens
s/\n{400}/4/
t tens
s/\n{300}/3/
t tens
s/\n{200}/2/
t tens
s/\n{100}/1/
t tens
s/\n/0\n/
t tens
: tens
s/\n{90}/9/
t ones
s/\n{80}/8/
t ones
s/\n{70}/7/
t ones
s/\n{60}/6/
t ones
s/\n{50}/5/
t ones
s/\n{40}/4/
t ones
s/\n{30}/3/
t ones
s/\n{20}/2/
t ones
s/\n{10}/1/
t ones
s/\n/0\n/
t ones
: ones
s/\n{9}/9/
t finish
s/\n{8}/8/
t finish
s/\n{7}/7/
t finish
s/\n{6}/6/
t finish
s/\n{5}/5/
t finish
s/\n{4}/4/
t finish
s/\n{3}/3/
t finish
s/\n{2}/2/
t finish
s/\n{1}/1/
t finish
s/$/0/
: finish
s/^0*//
p
