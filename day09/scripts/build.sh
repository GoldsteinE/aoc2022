#!/bin/sh

set -e
cd "$(dirname "$0")"/../build
ghc -outputdir . ../code/main.hs -o main
