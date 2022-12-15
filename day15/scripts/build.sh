#!/bin/sh

set -e
cd "$(dirname "$0")"/../build

for file in main.fut wrapper.c futhark.pkg; do
	cp ../code/$file .
done

futhark pkg sync
futhark c --library main.fut
gcc -O3 main.c wrapper.c -o wrapper
