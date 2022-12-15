#!/bin/sh

set -e
cd "$(dirname "$0")"/..

build/wrapper "${1}" "${2}" < "in/${1}${2}.txt"
