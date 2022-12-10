#!/bin/sh

set -e
cd "$(dirname "$0")"/..

rg --byte-offset --file code/part"$2".regex --only-matching --pcre2 < in/"$1""$2".txt \
	| rg --color=never --only-matching --max-count 1 '\d+'
