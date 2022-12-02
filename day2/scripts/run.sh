#!/bin/sh

set -e
cd "$(dirname "$0")"/..

< in/"$1$2.txt" sed -Enf code/part"$2".sed
