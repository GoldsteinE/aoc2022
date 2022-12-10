#!/bin/sh

set -e
cd "$(dirname "$0")"/..

sh code/main.sh "$2" < in/"${1}${2}.txt"
