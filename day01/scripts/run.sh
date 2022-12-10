#!/bin/sh

set -e
cd "$(dirname "$0")"/..

gawk -f code/part"$2".awk < "in/${1}${2}.txt"
