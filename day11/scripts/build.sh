#!/bin/sh

set -e
cd "$(dirname "$0")"/../build

find . -name '*.beam' -delete
elixirc -o . ../code/main.ex
