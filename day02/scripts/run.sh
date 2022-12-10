#!/bin/sh

set -e
cd "$(dirname "$0")"/..

< in/"$1$2.txt" sed -Enf build/part"$2".sed
