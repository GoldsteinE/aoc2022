#!/bin/sh

set -e
cd "$(dirname "$0")"/../build

elixir -e Main.main "${2}" < ../in/"${1}${2}".txt
