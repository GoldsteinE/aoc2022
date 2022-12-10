#!/bin/sh

set -e
cd "$(dirname "$0")"/../code

cat part1.sed convert_newlines_to_digits.sed > ../build/part1.sed
cat part2.sed convert_newlines_to_digits.sed > ../build/part2.sed
