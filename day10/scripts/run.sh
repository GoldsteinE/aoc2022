#!/bin/sh

set -e
cd "$(dirname "$0")"/..

octave code/main.m "${2}" < in/"${1}${2}.txt"
