#!/bin/sh

set -e
cd "$(dirname "$0")"/..

lua code/main.lua "${2}" < "in/${1}${2}.txt"
