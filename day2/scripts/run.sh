#!/bin/sh

set -e
cd "$(dirname "$0")"/..

< in/"$1$2.txt" sed -f code/part"$2".sed | sed -nf code/count.sed
